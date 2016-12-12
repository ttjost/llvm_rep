//===-----------------        VEXModifyBranches.cpp        ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements a pass that remove unnecessary GOTO instructions from code
// and also replaces VEX::BR instructions with VEX::BRF when it is better to do so.
//
//===----------------------------------------------------------------------===//

#include "VEX.h"
#include "VEXTargetMachine.h"
#include "VEXInstrInfo.h"
#include "llvm/Pass.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/DebugLoc.h"


#define DEBUG_TYPE "vex-modifybranches"

using namespace llvm;

namespace llvm {
    FunctionPass *createVEXModifyBranchesPass(VEXTargetMachine &TM);
}

namespace {

class ModifyBranchesPass : public MachineFunctionPass {

private:
    TargetMachine &TM;

public:
    static char ID;
    ModifyBranchesPass(TargetMachine &TM) :  MachineFunctionPass(ID),
                                                    TM(TM) {}

    // --------------------------------------------------
    // TODO: Improve code readability for this algorithm.
    // --------------------------------------------------
    virtual bool runOnMachineFunction(MachineFunction &MF) {

        MachineFunction::iterator OneBeforeLastBB = MF.end();
        --OneBeforeLastBB;
        MachineFunction::iterator OneAfterIteratorBB = MF.begin();
        ++OneAfterIteratorBB;
        
        for (MachineFunction::iterator MBBI = MF.begin();
             MBBI != OneBeforeLastBB; ++MBBI, ++OneAfterIteratorBB) {

            for (MachineBasicBlock::iterator InstrIter = MBBI->end();
                 InstrIter != MBBI->begin();) {

                if (InstrIter->isBranch()) {
                    if (InstrIter->getOpcode() == VEX::GOTO){

                        if (InstrIter->getOperand(0).isMBB() && InstrIter->getOperand(0).getMBB() == OneAfterIteratorBB) {
                            DEBUG(errs() << "We can remove this VEX::GOTO!\n");
                            MachineBasicBlock::iterator ErasedInst = InstrIter;
                            --InstrIter;
                            ErasedInst->eraseFromParent();
                        } else {

                            MachineBasicBlock::iterator BranchInstr = InstrIter;
                            --BranchInstr;

                            const VEXSubtarget &Subtarget =
                                *static_cast<const VEXTargetMachine &>(TM).getSubtargetImpl();
                            const VEXInstrInfo *TII =
                              static_cast<const VEXInstrInfo *>(Subtarget.getInstrInfo());
                            
                            if (BranchInstr->getOpcode() == VEX::BR && BranchInstr->getOperand(1).isMBB() && BranchInstr->getOperand(1).getMBB() == OneAfterIteratorBB) {
                                DEBUG(errs() << "We can replace VEX::BR with VEX::BRF!\n");
                                
                                MachineBasicBlock::iterator NewBranchInstr = BuildMI(*MBBI, BranchInstr,
                                                                                     BranchInstr->getDebugLoc(),
                                                                                     TII->get(VEX::BRF));
                                NewBranchInstr->addOperand(BranchInstr->getOperand(0));
                                NewBranchInstr->addOperand(InstrIter->getOperand(0));
                                
                                MachineBasicBlock::iterator ErasedInst = InstrIter;
                                --InstrIter;
                                ErasedInst->eraseFromParent();
                                ErasedInst = InstrIter;
                                --InstrIter;
                                ErasedInst->eraseFromParent();
                            } else
                                --InstrIter;
                        }
                    } else
                        if (InstrIter != MBBI->begin())
                            --InstrIter;
                } else {
                    if (InstrIter != MBBI->begin())
                        --InstrIter;
                }
            }
        }
        return true;
    }

};
}

FunctionPass *llvm::createVEXModifyBranchesPass(VEXTargetMachine &TM) {
    return new ModifyBranchesPass(TM);
}


char ModifyBranchesPass::ID = 0;
//static RegisterPass<ModifyBranchesPass> X("modifybranches", "Modify Branches in VEX Target");
