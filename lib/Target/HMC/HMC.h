//===-- HMC.h - Top-level interface for HMC representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM HMC back-end.
//
//===----------------------------------------------------------------------===//

#ifndef TARGET_HMC_H
#define TARGET_HMC_H

//#include "HMCConfig.h"
#include "MCTargetDesc/HMCMCTargetDesc.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/CommandLine.h"

namespace llvm {
    class HMCTargetMachine;
    class FunctionPass;

    FunctionPass *createHMCISelDag(HMCTargetMachine &TM);
    
    BasicBlockPass *createHMCTreeHeightReductionPass();

    ModulePass *createHMCReorderFunctionsPass();
    
//    FunctionPass *createHMCModuloScheduler(HMCTargetMachine &TM);
    
    FunctionPass *createHMCPostRAScheduler();

} // end namespace llvm;

#endif
