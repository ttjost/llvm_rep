//===-- VEXMCTargetDesc.h - VEX Target Descriptions -----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides VEX specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef VEXMCTARGETDESC_H
#define VEXMCTARGETDESC_H

//#include "VEXConfig.h"
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

    extern Target TheVEXTarget;
    extern Target TheVEXNewTarget;

} // end llvm namespace

// Define symbolic names for VEX registers. This defines a mapping from
// register name to register number
#define GET_REGINFO_ENUM
#include "VEXGenRegisterInfo.inc"

// Defines symbolic names for the VEX Instructions
#define GET_INSTRINFO_ENUM
#include "VEXGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "VEXGenSubtargetInfo.inc"
//#include "../VEXSubtargetInfo.cpp"

#endif
