//===-- HMCMCTargetDesc.h - HMC Target Descriptions -----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides HMC specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef HMCMCTARGETDESC_H
#define HMCMCTARGETDESC_H

//#include "HMCConfig.h"
#include "llvm/Support/DataTypes.h"

namespace llvm{

    class MCAsmBackend;
    class MCCodeEmitter;
    class MCContext;
    class MCInstrInfo;
    class MCObjectWriter;
    class MCRegisterInfo;
    class MCSubtargetInfo;
    class StringRef;
    class raw_ostream;
    
    class Target;

    extern Target TheHMCTarget;
    extern Target TheHMCNewTarget;

} // end llvm namespace

// Define symbolic names for HMC registers. This defines a mapping from
// register name to register number
#define GET_REGINFO_ENUM
#include "HMCGenRegisterInfo.inc"

// Defines symbolic names for the HMC Instructions
#define GET_INSTRINFO_ENUM
#include "HMCGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "HMCGenSubtargetInfo.inc"
//#include "../HMCSubtargetInfo.cpp"

#endif
