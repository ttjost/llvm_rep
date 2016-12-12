//===-- HMCMCAsmInfo.h - HMC Asm Info ------------------------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the HMCMCAsmInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef HMCTARGETASMINFO_H
#define HMCTARGETASMINFO_H

#include "llvm/MC/MCAsmInfo.h"

namespace llvm {
    
    class Triple;
    
    class Target;

    class HMCMCAsmInfo : public MCAsmInfo {
        virtual void anchor();

        bool isNewScheduling;
    public:
        explicit HMCMCAsmInfo(const Triple &TT);
    };

} // namespace llvm

#endif
