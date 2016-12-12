//===-- VEXSelectionDAGInfo.cpp - VEX SelectionDAG Info -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the VEXSelectionDAGInfo class.
//
//===----------------------------------------------------------------------===//

#include "VEXSelectionDAGInfo.h"

#include "VEXTargetMachine.h"

using namespace llvm;

#define DEBUG_TYPE "vex-selectiondag"

VEXSelectionDAGInfo::VEXSelectionDAGInfo(const DataLayout &DL)
: TargetSelectionDAGInfo() {
    DEBUG(errs() << "selectiondaginfo\n");
}

VEXSelectionDAGInfo::~VEXSelectionDAGInfo() {
}
