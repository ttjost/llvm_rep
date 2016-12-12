//===-- VEXMCAsmInfo.h - VEX Asm Info ------------------------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the VEXMCAsmInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef VEXTARGETASMINFO_H
#define VEXTARGETASMINFO_H

#include "llvm/MC/MCAsmInfo.h"

namespace llvm {
    
    class Triple;
    
    class Target;

    class VEXMCAsmInfo : public MCAsmInfo {
        virtual void anchor();

        bool isNewScheduling;
    public:
        explicit VEXMCAsmInfo(const Triple &TT);
    };

} // namespace llvm

#endif
