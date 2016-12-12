//===-- VEXTargetMachine.cpp - Define TargetMachine for VEX -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Implements the info about VEX target spec.
//
//===----------------------------------------------------------------------===//


#include "VEXTargetMachine.h"
#include "VEX.h"
#include "VEXVLIWPacketizer.cpp"
#include "VEXSchedulerMonitor.cpp"
#include "VEXModifyBranches.cpp"
#include "VEXMachineScheduler.h"
#include "HexagonMachineScheduler.h"
//#include "VEXSubtarget.h"
//#include "VEXTargetObjectFile.h"
#include "llvm/IR/PassManager.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/Support/CommandLine.h"
#include "VEXDataReuseTracking.cpp"

using namespace llvm;

#define DEBUG_TYPE "vex-targetmachine"

static cl::opt<bool> EnableVLIWScheduling("enable-vliw-scheduling",
                                          cl::Hidden, cl::init(true),
                                          cl::desc("Enable VLIW Scheduling"));

cl::opt<bool> EnableSPMs("enable-spms",
                                cl::Hidden, cl::init(false),
                                cl::desc("Enable Code Generation for ScratchPad Memories"));

cl::opt<bool> UseHexagonScheduler("enable-hexagonsched",
                                cl::Hidden, cl::init(true),
                                cl::desc("Enable Hexagon Scheduler"));

cl::opt<bool> EnableTHR("enable-thr",
                                cl::Hidden, cl::init(false),
                                cl::desc("Enable Tree Height Reduction for VEX"));

// This might never be used
// We will probably generate code for SPM right before Register Allocation
static cl::opt<bool> PreIsel("pre-isel",
                                cl::Hidden, cl::init(false),
                                cl::desc("Enable Code Generation for ScratchPad Memories before Instruction Selection"));

extern "C" void LLVMInitializeVEXTarget() {
    
    // Register Target
    // Normal Scheduling
    RegisterTargetMachine<VEXNormalTargetMachine> X(TheVEXTarget);
    // New Scheduling
    RegisterTargetMachine<VEXNewTargetMachine> Y(TheVEXNewTarget);
    
}

static std::string computeDataLayout() {
    std::string Ret = "";
    
    Ret += "E";
    
    // Added MM_None
    //Ret += "-m:n";
    
    Ret += "-p:32:32";
    
    // 8 and 16 bit integers only need no have natural alignment, but try to
    // align them to 32 bits. 64 bit integers have natural alignment.
    Ret += "-i8:8:32-i16:16:32-i32:32-f64:32";
    
    // 32 bit registers are always available and the stack is at least 64 bit
    // aligned.
    Ret += "-f128:32-n32-S32";

    return Ret;
}

// DataLayout --> Little-endian, 32-bit pointer/ABI/alignment
// The Stack is alwats 32 bytes aligned
// On function prologue, the stack is created by decrementin
// its pointer. Once decremented, all references are done with positive
// offset from the stack/frame pointer, using StackGrowsUp enables
// an easier handling.
// Using CodeModel::Large enables differente CALL behavior
VEXTargetMachine::
VEXTargetMachine(const Target &T, const Triple TT,
                 StringRef CPU, StringRef FS, const TargetOptions &Options,
                 Reloc::Model RM, CodeModel::Model CM,
                 CodeGenOpt::Level OL,
                 bool isNewScheduling)
    // - Default is normal Scheduling
    : LLVMTargetMachine(T, computeDataLayout(), TT, CPU, FS, Options, RM, CM, OL),
        isNewScheduling(isNewScheduling),
        TLOF(make_unique<TargetLoweringObjectFileELF>()),
        DataInfo(make_unique<DataReuseInfo>()),
        Subtarget(TT, CPU, FS, isNewScheduling, EnableVLIWScheduling, RM, *this){
    initAsmInfo();
}

VEXTargetMachine::~VEXTargetMachine() {}

VEXNormalTargetMachine::
VEXNormalTargetMachine(const Target &T, const Triple TT,
                       StringRef CPU, StringRef FS, const TargetOptions &Options,
                       Reloc::Model RM, CodeModel::Model CM,
                       CodeGenOpt::Level OL)
: VEXTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, false) {}

void VEXNormalTargetMachine::anchor() {}

VEXNewTargetMachine::
VEXNewTargetMachine(const Target &T, const Triple TT,
                    StringRef CPU, StringRef FS, const TargetOptions &Options,
                    Reloc::Model RM, CodeModel::Model CM,
                    CodeGenOpt::Level OL)
: VEXTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, true) {}

void VEXNewTargetMachine::anchor() {}

//const VEXSubtarget *
//VEXTargetMachine::getSubtargetImpl(const Function &F) const {
//    if (Subtarget)
//        return Subtarget;
//    return &DefaultSubtarget;
//}

static ScheduleDAGInstrs *createVEXVLIWMachineSched(MachineSchedContext *C) {
    if (UseHexagonScheduler)
        return new NewVEXVLIWMachineScheduler(C, make_unique<NewVEXConvergingVLIWScheduler>());
    else
        return new VEXVLIWMachineScheduler(C, make_unique<ConvergingVEXVLIWScheduler>());
}

static MachineSchedRegistry
SchedCustomRegistry("vex", "Run VEX custom scheduler",
                    createVEXVLIWMachineSched);

namespace {

// @ VEXPassConfig{
//  VEX Code Generator Pass Configuration Options
    class VEXPassConfig : public TargetPassConfig {
    
    public:
        VEXPassConfig(VEXTargetMachine *TM, PassManagerBase &PM)
        : TargetPassConfig(TM, PM){
            substitutePass(&PostRASchedulerID, &PostMachineSchedulerID);
        }
        
        VEXTargetMachine &getVEXTargetMachine() const {
            return getTM<VEXTargetMachine>();
        }
        
        const VEXSubtarget &getVEXSubtarget() const {
            return *getVEXTargetMachine().getSubtargetImpl();
        }
        
        ScheduleDAGInstrs *
        createMachineScheduler(MachineSchedContext *C) const override {
            return createVEXVLIWMachineSched(C);
        }
        
        void addIRPasses() override;
        bool addPreISel() override;
        bool addInstSelector() override;
        void addPreEmitPass() override;
        void addPreRegAlloc() override;
        void addPostRegAlloc() override;
        void addMachineSSAOptimization() override;
        
    };
}

void VEXPassConfig::addIRPasses() {
    TargetPassConfig::addIRPasses();
    
    if (EnableTHR)
        addPass(createVEXTreeHeightReductionPass());

//    if (EnableSPMs)
//        addPass(createVEXReorderFunctionsPass());
}

bool VEXPassConfig::addPreISel() {

//    if (EnableSPMs && PreIsel)
//        addPass(createVEXLoopInfoPass(getVEXTargetMachine()));
    return false;
}

bool VEXPassConfig::addInstSelector() {
    addPass(createVEXISelDag(getVEXTargetMachine()));
    return false;
}

void VEXPassConfig::addMachineSSAOptimization() {
//    addPass(createVEXModuloScheduler(getVEXTargetMachine()));
    TargetPassConfig::addMachineSSAOptimization();
}

void VEXPassConfig::addPreRegAlloc() {
    if (EnableSPMs && !PreIsel)
        addPass(createVEXDataReuseTracking(getVEXTargetMachine()));
}

void VEXPassConfig::addPostRegAlloc() {
//    if (EnableSPMs)
//        addPass(createVEXDataReuseTrackingPostRegAlloc(getVEXTargetMachine()));
}

void VEXPassConfig::addPreEmitPass() {
    DEBUG(errs() << "addPreEmitPass " << EnableVLIWScheduling << "\n");
    //addPass(createVEXPostRAScheduler());
    
    addPass(createVEXModifyBranchesPass(getVEXTargetMachine()));
    //if (EnableVLIWScheduling)
        addPass(createVEXPacketizer(EnableVLIWScheduling, getVEXTargetMachine()), false);
        addPass(createSchedulerMonitor(getVEXTargetMachine()));
}

TargetPassConfig *VEXTargetMachine::createPassConfig(PassManagerBase &PM){
    return new VEXPassConfig(this, PM);
}


