//===-- HMCSelectionDAGInfo.h - HMC SelectionDAG Info ---------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the HMC subclass for TargetSelectionDAGInfo.
//
//===----------------------------------------------------------------------===//

#ifndef HMCSELECTIONDAGINFO_H
#define HMCSELECTIONDAGINFO_H

#include "llvm/Target/TargetSelectionDAGInfo.h"

namespace llvm {
    
    class HMCTargetMachine;
    
    class HMCSelectionDAGInfo : public TargetSelectionDAGInfo {
    public:
        explicit HMCSelectionDAGInfo(const DataLayout &DL);
        ~HMCSelectionDAGInfo();
    };
}


#endif
