//===-- VEXISelDAGToDAG.cpp - Top-level interface for VEX representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//  This file defines an instruction selector for the VEX Target
//
//===----------------------------------------------------------------------===//

#include "VEX.h"

#include "VEXMachineFunctionInfo.h"
#include "VEXSubtarget.h"
#include "VEXTargetMachine.h"
//#include "llvm/IR/CFG.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Type.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/CodeGen/MachineBranchProbabilityInfo.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/MachineTraceMetrics.h"
#include "llvm/CodeGen/LiveIntervalAnalysis.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/CodeGen/ScheduleDAGInstrs.h"

using namespace llvm;

#define DEBUG_TYPE "vex-mod-sched"


static cl::opt<bool> VEXModSched("vex-mod-sched", cl::init(false),
                                 cl::Hidden, cl::desc("Enable VEX Modulo Scheduler"));

//===----------------------------------------------------------------------===//
// VEXModuloScheduler - VEX Modulo Scheduler.
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "vex-mod-sched"


namespace llvm {
    
class AliasAnalysis;
class LiveIntervals;
class MachineDominatorTree;
class MachineLoopInfo;
    
    // DefaultVLIWScheduler - This class extends ScheduleDAGInstrs and overrides
    // Schedule method to build the dependence graph.
    class LoopScheduler : public ScheduleDAGInstrs {
    public:
        LoopScheduler (MachineFunction &MF,
                       MachineLoopInfo &MLI,
                       LiveIntervals *LIS);
        // Schedule - Actual scheduling work.
        void schedule() override;
    };
}

LoopScheduler::LoopScheduler(MachineFunction &MF,
                             MachineLoopInfo &MLI,
                             LiveIntervals *LIS)
: ScheduleDAGInstrs(MF, &MLI, false, false, LIS) {
    // TODO: Is this really correct?
    CanHandleTerminators = true;
}

void LoopScheduler::schedule() {
    // Build the scheduling graph.
    buildSchedGraph(nullptr);
}

namespace {
    
    class LLVM_LIBRARY_VISIBILITY VEXModuloScheduler : public MachineFunctionPass {
    public:
        static char ID;
        VEXTargetMachine& TM;
        
        explicit VEXModuloScheduler(VEXTargetMachine &TM):
        MachineFunctionPass(ID), TM(TM) {
            innerLoops.clear();
            DEBUG(errs() << "Creating VEX Modulo Scheduler\n\n");
        }
        
        virtual bool runOnMachineFunction(MachineFunction &MF) override;
        
        void getAnalysisUsage(AnalysisUsage &AU) const override;
        
        virtual const char *getPassName() const{
            return "VEX Modulo Scheduler";
        }
        
        // VLIWPacketizerList Dtor
        ~VEXModuloScheduler() {
//            if (Scheduler)
//                delete Scheduler;
        }
        
    protected:
        
        
    private:
        const TargetInstrInfo *TII;
        const TargetRegisterInfo *TRI;
        MCSchedModel SchedModel;
        // Does the proceeded function has Oz attribute.
        bool MinSize;
        MachineRegisterInfo *MRI;
        MachineDominatorTree *DomTree;
        MachineLoopInfo *Loops;
        MachineTraceMetrics *Traces;
        MachineTraceMetrics::Ensemble *MinInstr;
        LiveIntervals *LIS;
        
        DenseSet<MachineLoop *> innerLoops;
        
        LoopScheduler *Scheduler;
    
        std::vector<SUnit> SUnits;            // The scheduling units.
        
        /// After calling BuildSchedGraph, each machine instruction in the current
        /// scheduling region is mapped to an SUnit.
        DenseMap<MachineInstr*, SUnit*> MISUnitMap;
        
        MachineLoop *IsCandidateToSchedule(MachineFunction::iterator BasicBlock);
        void FindInnerLoops(MachineFunction &MF);
        void initSUnits(MachineBasicBlock* Loop);
        
    };
    
}

void VEXModuloScheduler::getAnalysisUsage(AnalysisUsage &AU) const {
    AU.addRequired<MachineBranchProbabilityInfo>();
    AU.addRequired<MachineDominatorTree>();
    AU.addPreserved<MachineDominatorTree>();
    AU.addRequired<MachineLoopInfo>();
    AU.addPreserved<MachineLoopInfo>();
    AU.addRequired<MachineTraceMetrics>();
    AU.addPreserved<MachineTraceMetrics>();
    //AU.addRequired<LiveIntervals>();
    //AU.addPreserved<LiveIntervals>();
    //AU.addPreserved<SlotIndexes>();
    MachineFunctionPass::getAnalysisUsage(AU);
}

// Tests if the inner loop has only one basic block.
// This is the simplest type of BBs. Inner loops with Condition Code will be ignored.
MachineLoop *VEXModuloScheduler::IsCandidateToSchedule(MachineFunction::iterator BasicBlock) {
    MachineLoop* loop = Loops->getLoopFor(BasicBlock);
    if (loop && loop->getNumBlocks() == 1) {
        return loop;
    } else
        return nullptr;
}

// Find inner Loops that can be candidates for Modulo Scheduling
void VEXModuloScheduler::FindInnerLoops(MachineFunction &MF) {
    
    for (MachineFunction::iterator MBBI = MF.begin(),
            MBBE = MF.end(); MBBI != MBBE; ++MBBI) {
        
        if (MachineLoop* loop = IsCandidateToSchedule(MBBI)){
            loop->dump();
            innerLoops.insert(loop);
        }
    }
    
    for (MachineLoop* loopi : innerLoops) {
        MachineBasicBlock* MBB = loopi->getTopBlock();
        errs() << "Basic Block: " <<loopi->getTopBlock()->getName() << "\n";
        
//        Scheduler->startBlock(MBB);
//        MachineBasicBlock::iterator BeginItr = MBB->begin();
//        MachineBasicBlock::iterator EndItr = MBB->end();
//        
//        Scheduler->enterRegion(MBB, MBB->begin(), MBB->end(),
//                               std::distance(BeginItr, EndItr));
//        
//        Scheduler->buildSchedGraph(nullptr);
//        
//        for (unsigned i = 0; i < Scheduler->SUnits.size(); ++i) {
//            Scheduler->SUnits[i].dump(Scheduler);
//        }
    }
    
    for (MachineLoop* loopi : innerLoops) {
        MachineBasicBlock* bb = loopi->getTopBlock();
        errs() << "Basic Block " <<loopi->getTopBlock()->getName() << " with " << std::distance(bb->begin(), bb->end()) << " instructions\n";
        
        for (MachineBasicBlock::iterator i = bb->begin(),
             e = bb->end(); i != e; ++i) {
            i->dump();
        }
        
        errs() << "\n\n";
    }
}

void VEXModuloScheduler::initSUnits(MachineBasicBlock* Loop) {
    
    
    for (MachineBasicBlock::iterator I = Loop->begin(),
         E = Loop->end(); I != E; I++) {
        MachineInstr *MI = I;
        SUnits.push_back(SUnit(MI, SUnits.size()));
        
    }
    
}

bool VEXModuloScheduler::runOnMachineFunction(MachineFunction &MF){
    
    if (!VEXModSched)
        return false;
    
    innerLoops.clear();
    TII = MF.getSubtarget().getInstrInfo();
    TRI = MF.getSubtarget().getRegisterInfo();
    SchedModel = MF.getSubtarget().getSchedModel();
    MRI = &MF.getRegInfo();
    DomTree = &getAnalysis<MachineDominatorTree>();
    Loops = getAnalysisIfAvailable<MachineLoopInfo>();
    Traces = &getAnalysis<MachineTraceMetrics>();
    //LIS = &getAnalysis<LiveIntervals>();
    MinSize = MF.getFunction()->hasFnAttribute(Attribute::MinSize);
    
    //Scheduler = new LoopScheduler(MF, *Loops, LIS);
    
    FindInnerLoops(MF);
    
    for (MachineLoop* loopi : innerLoops) {
        MachineBasicBlock* bb = loopi->getTopBlock();
//        errs() << "Basic Block: " <<loopi->getTopBlock()->getName() << "\n";
//        
//        for (MachineBasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i)
//            i->dump();
//        errs() << "\n\n";
    }
    
    return false;
}

char VEXModuloScheduler::ID = 0;

FunctionPass *llvm::createVEXModuloScheduler(VEXTargetMachine &TM) {
    return new VEXModuloScheduler(TM);
}
