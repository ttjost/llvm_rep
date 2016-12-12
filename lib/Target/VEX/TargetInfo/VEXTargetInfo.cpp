//===-- VEXTargetInfo.cpp - VEX Target Implementation -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "VEX.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target llvm::TheVEXTarget;
Target llvm::TheVEXNewTarget;

extern "C" void LLVMInitializeVEXTargetInfo() {
    RegisterTarget<Triple::vex,
        /*HasJIT=*/false> X(TheVEXTarget, "vex", "VEX");
    
//    RegisterTarget<Triple::vexnew,
//        /*HasJIT=*/false> Y(TheVEXNewTarget,"vexnew", "VEX New Scheduling");

}
