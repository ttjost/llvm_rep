//===-- HMCMCInstLower.h - Lower MachineInstr to MCInst -------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef HMCMCINSTLOWER_H
#define HMCMCINSTLOWER_H

#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/Support/Compiler.h"
#include "llvm/ADT/StringRef.h"

namespace llvm {
    class MCContext;
    class MCInst;
    class MCOperand;
    class MachineInstr;
    class MachineFunction;
    class HMCAsmPrinter;
    
    // HMCInstLower - This class is used to lower an MachineInstr into an MCInst
    class LLVM_LIBRARY_VISIBILITY HMCMCInstLower{
        
        typedef MachineOperand::MachineOperandType MachineOperandType;
        MCContext *Ctx;
        HMCAsmPrinter &AsmPrinter;

        MCSymbol *GetGlobalAddressSymbol(const MachineOperand &MO) const;
        MCSymbol *GetExternalSymbolSymbol(StringRef Symbol) const;
        
    public:
        HMCMCInstLower(HMCAsmPrinter &asmprinter);
        void Initialize(MCContext* C);
        void Lower(const MachineInstr *MI, MCInst &OutMI,
                   MCInst &InBundleMI, bool isInsideBundle,
                   unsigned numValArgumentOrLane = 0,
                   unsigned numValReturn = 0) const;
        MCOperand LowerOperand(const MachineOperand &MO, unsigned offset = 0) const;
    };
}

#endif
