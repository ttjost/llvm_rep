//===-- HMCSelectionDAGInfo.cpp - HMC SelectionDAG Info -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the HMCSelectionDAGInfo class.
//
//===----------------------------------------------------------------------===//

#include "HMCSelectionDAGInfo.h"

#include "HMCTargetMachine.h"

using namespace llvm;

#define DEBUG_TYPE "HMC-selectiondag"

HMCSelectionDAGInfo::HMCSelectionDAGInfo(const DataLayout &DL)
: TargetSelectionDAGInfo() {
    DEBUG(errs() << "selectiondaginfo\n");
}

HMCSelectionDAGInfo::~HMCSelectionDAGInfo() {
}
