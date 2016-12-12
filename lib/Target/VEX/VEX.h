//===-- VEX.h - Top-level interface for VEX representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM VEX back-end.
//
//===----------------------------------------------------------------------===//

#ifndef TARGET_VEX_H
#define TARGET_VEX_H

//#include "VEXConfig.h"
#include "MCTargetDesc/VEXMCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/CommandLine.h"

namespace llvm {
    class VEXTargetMachine;
    class FunctionPass;

    FunctionPass *createVEXISelDag(VEXTargetMachine &TM);
    
    BasicBlockPass *createVEXTreeHeightReductionPass();

    ModulePass *createVEXReorderFunctionsPass();
    
//    FunctionPass *createVEXModuloScheduler(VEXTargetMachine &TM);
    
    FunctionPass *createVEXPostRAScheduler();

} // end namespace llvm;

#endif
