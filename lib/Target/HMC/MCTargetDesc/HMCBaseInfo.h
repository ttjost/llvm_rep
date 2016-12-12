//===-- HMCBaseInfo.h - Top level definitions for HMC MC ------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains small standalone helper functions and enum definitions for
// the HMC target useful for the compiler back-end and the MC libraries.
//
//===----------------------------------------------------------------------===//
#ifndef HMCBASEINFO_H
#define HMCBASEINFO_H

#include "llvm/Support/ErrorHandling.h"

namespace llvm {

/// getHMCRegisterNumbering - Given the enum value for some register,
/// return the number that it corresponds to.
inline static unsigned getHMCRegisterNumbering(unsigned RegEnum)
{
  switch (RegEnum) {
  case HMC::Reg0:
    return 0;
  case HMC::Reg1:
    return 1;
  case HMC::Reg2:
    return 2;
  case HMC::Reg3:
    return 3;
  case HMC::Reg4:
    return 4;
  case HMC::Reg5:
    return 5;
  case HMC::Reg6:
    return 6;
  case HMC::Reg7:
    return 7;
  case HMC::Reg8:
    return 8;
  case HMC::Reg9:
    return 9;
  case HMC::Reg10:
    return 10;
  case HMC::Reg11:
    return 11;
  case HMC::Reg12:
    return 12;
  case HMC::Reg13:
    return 13;
  case HMC::Reg14:
    return 14;
  case HMC::Reg15:
    return 15;
  case HMC::Reg16:
    return 16;
  case HMC::Reg17:
    return 17;
  case HMC::Reg18:
    return 18;
  case HMC::Reg19:
    return 19;
  case HMC::Reg20:
    return 20;
  case HMC::Reg21:
    return 21;
  case HMC::Reg22:
    return 22;
  case HMC::Reg23:
    return 23;
  case HMC::Reg24:
    return 24;
  case HMC::Reg25:
    return 25;
  case HMC::Reg26:
    return 26;
  case HMC::Reg27:
    return 27;
  case HMC::Reg28:
    return 28;
  case HMC::Reg29:
    return 29;
  case HMC::Reg30:
    return 30;
  case HMC::Reg31:
    return 31;
  case HMC::Reg32:
    return 32;
  case HMC::Reg33:
    return 33;
  case HMC::Reg34:
    return 34;
  case HMC::Reg35:
    return 35;
  case HMC::Reg36:
    return 36;
  case HMC::Reg37:
    return 37;
  case HMC::Reg38:
    return 38;
  case HMC::Reg39:
    return 39;
  case HMC::Reg40:
    return 40;
  case HMC::Reg41:
    return 41;
  case HMC::Reg42:
    return 42;
  case HMC::Reg43:
    return 43;
  case HMC::Reg44:
    return 44;
  case HMC::Reg45:
    return 45;
  case HMC::Reg46:
    return 46;
  case HMC::Reg47:
    return 47;
  case HMC::Reg48:
    return 48;
  case HMC::Reg49:
    return 49;
  case HMC::Reg50:
    return 50;
  case HMC::Reg51:
    return 51;
  case HMC::Reg52:
    return 52;
  case HMC::Reg53:
    return 53;
  case HMC::Reg54:
    return 54;
  case HMC::Reg55:
    return 55;
  case HMC::Reg56:
    return 56;
  case HMC::Reg57:
    return 57;
  case HMC::Reg58:
    return 58;
  case HMC::Reg59:
    return 59;
  case HMC::Reg60:
    return 60;
  case HMC::Reg61:
    return 61;
  case HMC::Reg62:
    return 62;
  case HMC::Reg63:
    return 63;
  case HMC::BrReg0:
    return 0;
  case HMC::BrReg1:
    return 1;
  case HMC::BrReg2:
    return 2;
  case HMC::BrReg3:
    return 3;
  case HMC::BrReg4:
    return 4;
  case HMC::BrReg5:
    return 5;
  case HMC::BrReg6:
    return 6;
  case HMC::BrReg7:
    return 7;
  case HMC::Lr:
    return 64;
  default: llvm_unreachable("Unknown register number!");
  }
}

extern int HMCDFAStateInputTable[][2];
extern unsigned int HMCDFAStateEntryTable[];




}

#endif
