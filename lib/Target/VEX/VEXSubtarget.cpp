//===-- VEXSubtarget.cpp - VEX Subtarget Information --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the VEX specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#include "VEXMachineFunctionInfo.h"
#include "VEX.h"
#include "VEXRegisterInfo.h"
#include "VEXSubtarget.h"
#include "VEXFrameLowering.h"

#include "VEXTargetMachine.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "vex-subtarget"

#define GET_SUBTARGETINFO_TARGET_DESC
#define GET_SUBTARGETINFO_CTOR
//#include "VEXSubtargetInfo.cpp"
#include "VEXGenSubtargetInfo.inc"


static cl::opt<bool>
EnableVEXCalls("vex-calls", cl::Hidden,
               cl::desc("VEX Call: use stack only to pass arguments."),
               cl::init(false));

cl::opt<bool> DisableVEXMISched("disable-vex-misched",
                                       cl::Hidden, cl::ZeroOrMore, cl::init(false),
                                       cl::desc("Disable VEX MI Scheduling"));

extern cl::opt<bool> GenericBinary;


//// Select the VEX CPU for the given triple and cpu name.
//// FIXME : Merge with the copy in VEXMCTargetDesc.cpp
//static StringRef selectVEXCPU(Triple TT, StringRef CPU){
//    if(CPU.empty() || CPU == "generic"){
//        if (TT.getArch() == Triple::vex)
//            CPU = "rvex-4issue";
//    }
//    return CPU;
//}

// VEXSubtarget::VEXSubtarget
VEXSubtarget::VEXSubtarget(const Triple &TT, const std::string &CPU,
                           const std::string &FS, bool isNewScheduling,
                           bool EnableVLIWScheduling, Reloc::Model _RM,
                           VEXTargetMachine &_TM):
    VEXGenSubtargetInfo(TT, CPU, FS),
    VEXABI(ABI32),
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

VEXSubtarget &VEXSubtarget::initializeSubtargetDependencies(StringRef CPU,
                                                            StringRef FS){
    
    if (GenericBinary) {
        errs() << "Generating Generic Binary.\n\t-mcpu=rvex-generic\n";
        CPU = "rvex-generic";
    } else if (CPU == "rvex-default") {
        errs() << "clang: warning: unknown target CPU: assuming '-mcpu=rvex-4issue'\n" << "\n";
        CPU = "rvex-4issue";
    } else if (CPU == "help" || CPU.empty()) {
        errs() << "-mcpu=<cpu-name>\n\tOptions: rvex-[2|4|8]issue, simple-[2|4|8]issue.\n\tDefault: rvex-4issue\n" << "\n";
        CPU = "rvex-4issue";
    }

    if (CPU == "rvex-2issue")
        VEXArchVersion = rvex_2issue;
    else if (CPU == "rvex-4issue")
        VEXArchVersion = rvex_4issue;
    else if (CPU == "rvex-8issue")
        VEXArchVersion = rvex_8issue;
    else if (CPU == "simple-2issue")
        VEXArchVersion = simple_2issue;
    else if (CPU == "simple-4issue")
        VEXArchVersion = simple_4issue;
    else if (CPU == "simple-8issue")
        VEXArchVersion = simple_8issue;

    // Parse features string.
    ParseSubtargetFeatures(CPU, FS);
    // Initialize scheduling itinerary for the specified CPU.
    InstrItins = getInstrItineraryForCPU(CPU);
    
    return *this;
    
}

bool VEXSubtarget::enableMachineScheduler() const {
    if (DisableVEXMISched)
            return false;
    return true;
}

bool VEXSubtarget::abiUsesSoftFloat() const {
//  return TM->Options.UseSoftFloat;
    return true;
}




