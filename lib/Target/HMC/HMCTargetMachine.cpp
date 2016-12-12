//===-- HMCTargetMachine.cpp - Define TargetMachine for HMC -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Implements the info about HMC target spec.
//
//===----------------------------------------------------------------------===//


#include "HMCTargetMachine.h"
#include "HMC.h"
#include "HMCVLIWPacketizer.cpp"
#include "HMCMachineScheduler.h"
#include "HexagonMachineScheduler.h"
#include "llvm/IR/PassManager.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/Support/CommandLine.h"

using namespace llvm;

#define DEBUG_TYPE "HMC-targetmachine"

cl::opt<bool> UseHMCHexagonScheduler("enable-hmchexagonsched",
                                cl::Hidden, cl::init(true),
                                cl::desc("Enable Hexagon Scheduler"));

extern "C" void LLVMInitializeHMCTarget() {
    
    // Register Target
    // Normal Scheduling
    RegisterTargetMachine<HMCNormalTargetMachine> X(TheHMCTarget);
    // New Scheduling
    RegisterTargetMachine<HMCNewTargetMachine> Y(TheHMCNewTarget);
    
}

static std::string computeDataLayout() {
    std::string Ret = "";
    
    Ret += "E";
    
    // Added MM_None
    //Ret += "-m:n";
    
    Ret += "-p:32:32";
    
    // 8 and 16 bit integers only need no have natural alignment, but try to
    // align them to 32 bits. 64 bit integers have natural alignment.
    Ret += "-i8:8:32-i16:16:32-i32:32-i64:64";
    
    // 32 bit registers are always available and the stack is at least 64 bit
    // aligned.
    Ret += "-f128:64-n32-S32";

    return Ret;
}

// DataLayout --> Little-endian, 32-bit pointer/ABI/alignment
// The Stack is alwats 32 bytes aligned
// On function prologue, the stack is created by decrementin
// its pointer. Once decremented, all references are done with positive
// offset from the stack/frame pointer, using StackGrowsUp enables
// an easier handling.
// Using CodeModel::Large enables differente CALL behavior
HMCTargetMachine::
HMCTargetMachine(const Target &T, const Triple TT,
                 StringRef CPU, StringRef FS, const TargetOptions &Options,
                 Reloc::Model RM, CodeModel::Model CM,
                 CodeGenOpt::Level OL,
                 bool isNewScheduling)
    // - Default is normal Scheduling
    : LLVMTargetMachine(T, computeDataLayout(), TT, CPU, FS, Options, RM, CM, OL),
        isNewScheduling(isNewScheduling),
        TLOF(make_unique<TargetLoweringObjectFileELF>()),
        Subtarget(TT, CPU, FS, isNewScheduling, true, RM, *this){
    initAsmInfo();
}

HMCTargetMachine::~HMCTargetMachine() {}

HMCNormalTargetMachine::
HMCNormalTargetMachine(const Target &T, const Triple TT,
                       StringRef CPU, StringRef FS, const TargetOptions &Options,
                       Reloc::Model RM, CodeModel::Model CM,
                       CodeGenOpt::Level OL)
: HMCTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, false) {}

void HMCNormalTargetMachine::anchor() {}

HMCNewTargetMachine::
HMCNewTargetMachine(const Target &T, const Triple TT,
                    StringRef CPU, StringRef FS, const TargetOptions &Options,
                    Reloc::Model RM, CodeModel::Model CM,
                    CodeGenOpt::Level OL)
: HMCTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, true) {}

void HMCNewTargetMachine::anchor() {}

//const HMCSubtarget *
//HMCTargetMachine::getSubtargetImpl(const Function &F) const {
//    if (Subtarget)
//        return Subtarget;
//    return &DefaultSubtarget;
//}

static ScheduleDAGInstrs *createHMCVLIWMachineSched(MachineSchedContext *C) {
    if (UseHMCHexagonScheduler)
        return new NewHMCVLIWMachineScheduler(C, make_unique<NewHMCConvergingVLIWScheduler>());
    else
        return new HMCVLIWMachineScheduler(C, make_unique<ConvergingHMCVLIWScheduler>());
}

static MachineSchedRegistry
SchedCustomRegistry("HMC", "Run HMC custom scheduler",
                    createHMCVLIWMachineSched);

namespace {

// @ HMCPassConfig{
//  HMC Code Generator Pass Configuration Options
    class HMCPassConfig : public TargetPassConfig {
    
    public:
        HMCPassConfig(HMCTargetMachine *TM, PassManagerBase &PM)
        : TargetPassConfig(TM, PM){
            substitutePass(&PostRASchedulerID, &PostMachineSchedulerID);
        }
        
        HMCTargetMachine &getHMCTargetMachine() const {
            return getTM<HMCTargetMachine>();
        }
        
        const HMCSubtarget &getHMCSubtarget() const {
            return *getHMCTargetMachine().getSubtargetImpl();
        }
        
        ScheduleDAGInstrs *
        createMachineScheduler(MachineSchedContext *C) const override {
            return createHMCVLIWMachineSched(C);
        }
        
        bool addInstSelector() override;
        void addPreEmitPass() override;
        
    };
}

bool HMCPassConfig::addInstSelector() {
    addPass(createHMCISelDag(getHMCTargetMachine()));
    return false;
}

void HMCPassConfig::addPreEmitPass() {
        addPass(createHMCPacketizer(true, getHMCTargetMachine()), false);
}

TargetPassConfig *HMCTargetMachine::createPassConfig(PassManagerBase &PM){
    return new HMCPassConfig(this, PM);
}


