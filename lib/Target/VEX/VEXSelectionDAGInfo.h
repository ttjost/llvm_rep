//===-- VEXSelectionDAGInfo.h - VEX SelectionDAG Info ---------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the VEX subclass for TargetSelectionDAGInfo.
//
//===----------------------------------------------------------------------===//

#ifndef VEXSELECTIONDAGINFO_H
#define VEXSELECTIONDAGINFO_H

#include "llvm/Target/TargetSelectionDAGInfo.h"

namespace llvm {
    
    class VEXTargetMachine;
    
    class VEXSelectionDAGInfo : public TargetSelectionDAGInfo {
    public:
        explicit VEXSelectionDAGInfo(const DataLayout &DL);
        ~VEXSelectionDAGInfo();
    };
}


#endif
