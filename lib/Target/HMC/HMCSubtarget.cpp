//===-- HMCSubtarget.cpp - HMC Subtarget Information --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the HMC specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#include "HMCMachineFunctionInfo.h"
#include "HMC.h"
#include "HMCRegisterInfo.h"
#include "HMCSubtarget.h"
#include "HMCFrameLowering.h"

#include "HMCTargetMachine.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "HMC-subtarget"

#define GET_SUBTARGETINFO_TARGET_DESC
#define GET_SUBTARGETINFO_CTOR
//#include "HMCSubtargetInfo.cpp"
#include "HMCGenSubtargetInfo.inc"


static cl::opt<bool>
EnableHMCCalls("HMC-calls", cl::Hidden,
               cl::desc("HMC Call: use stack only to pass arguments."),
               cl::init(false));

cl::opt<bool> DisableHMCMISched("disable-HMC-misched",
                                       cl::Hidden, cl::ZeroOrMore, cl::init(true),
                                       cl::desc("Disable HMC MI Scheduling"));

//// Select the HMC CPU for the given triple and cpu name.
//// FIXME : Merge with the copy in HMCMCTargetDesc.cpp
//static StringRef selectHMCCPU(Triple TT, StringRef CPU){
//    if(CPU.empty() || CPU == "generic"){
//        if (TT.getArch() == Triple::HMC)
//            CPU = "rHMC-4issue";
//    }
//    return CPU;
//}

// HMCSubtarget::HMCSubtarget
HMCSubtarget::HMCSubtarget(const Triple &TT, const std::string &CPU,
                           const std::string &FS, bool isNewScheduling,
                           bool EnableVLIWScheduling, Reloc::Model _RM,
                           HMCTargetMachine &_TM):
    HMCGenSubtargetInfo(TT, CPU, FS),
    HMCABI(ABI32),
    AllocationOrder(0),
    isNewScheduling(isNewScheduling),
    EnableVLIWScheduling(EnableVLIWScheduling),
    RM(_RM), TargetTriple(TT),
    TSInfo(*_TM.getDataLayout()),
    InstrInfo(initializeSubtargetDependencies(CPU, FS)),
    FrameLowering(),
    TLInfo(_TM, *this),
    OptBBHeights(make_unique<BBsInfo>()),
    SchedBBHeights(make_unique<BBsInfo>()) {
        DEBUG(errs() << "Subtarget\n");
        
}

HMCSubtarget &HMCSubtarget::initializeSubtargetDependencies(StringRef CPU,
                                                            StringRef FS){
    
//    if (CPU == "") {
//        errs() << "clang: warning: unknown target CPU: assuming '-mcpu=simple-64issue. '\n" << "\n";
//    }

    HMCArchVersion = simple_64issue;
    CPU = "simple-64issue";
    
    // Parse features string.
    ParseSubtargetFeatures(CPU, FS);
    // Initialize scheduling itinerary for the specified CPU.
    InstrItins = getInstrItineraryForCPU(CPU);
    
    return *this;
    
}

bool HMCSubtarget::enableMachineScheduler() const {
    return true;
}

bool HMCSubtarget::abiUsesSoftFloat() const {
//  return TM->Options.UseSoftFloat;
    return true;
}




