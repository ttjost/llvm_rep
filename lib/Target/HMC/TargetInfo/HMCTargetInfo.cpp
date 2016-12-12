//===-- HMCTargetInfo.cpp - HMC Target Implementation -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "HMC.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target llvm::TheHMCTarget;
Target llvm::TheHMCNewTarget;

extern "C" void LLVMInitializeHMCTargetInfo() {
    RegisterTarget<Triple::hmc,
        /*HasJIT=*/false> X(TheHMCTarget, "hmc", "HMC VEX");
    
//    RegisterTarget<Triple::HMCnew,
//        /*HasJIT=*/false> Y(TheHMCNewTarget,"HMCnew", "HMC New Scheduling");

}
