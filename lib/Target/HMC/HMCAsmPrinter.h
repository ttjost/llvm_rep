//===-- HMCAsmPrinter.h - HMC LLVM Assembly Printer ----------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// HMC Assembly printer class.
//
//===----------------------------------------------------------------------===//

#ifndef HMCASMPRINTER_H
#define HMCASMPRINTER_H

#include "HMC.h"
#include "HMCMachineFunctionInfo.h"
#include "InstPrinter/HMCInstPrinter.h"
#include "HMCInstrInfo.h"
#include "HMCMCInstLower.h"
#include "HMCTargetMachine.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Mangler.h"
#include "llvm/IR/Module.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"

#include <set>
#include <string>

namespace llvm{

class MCStreamer;
class MachineInstr;
class MachineBasicBlock;
class Module;
class raw_ostream;

namespace LaneInformation {
  const unsigned Lane0 = 1 << 0;
  const unsigned Lane1 = 1 << 1;
  const unsigned Lane2 = 1 << 2;
  const unsigned Lane3 = 1 << 3;
  const unsigned Lane4 = 1 << 4;
  const unsigned Lane5 = 1 << 5;
  const unsigned Lane6 = 1 << 6;
  const unsigned Lane7 = 1 << 7;
  const unsigned Lane8 = 1 << 8;
  const unsigned Lane9 = 1 << 9;
  const unsigned Lane10 = 1 << 10;
  const unsigned Lane11 = 1 << 11;
  const unsigned Lane12 = 1 << 12;
  const unsigned Lane13 = 1 << 13;
  const unsigned Lane14 = 1 << 14;
  const unsigned Lane15 = 1 << 15;
}

class LLVM_LIBRARY_VISIBILITY HMCAsmPrinter : public AsmPrinter {

    void EmitInstrWithMacroNoAT(const MachineInstr *MI);

    bool lowerOperand(const MachineOperand &MO, MCOperand &MCOp);
    
    std::set<std::string> FunctionsCalledByCallee;

    FunctionInfo* FunctionsArguments;
    FunctionInfo* FunctionsCalled;
    FunctionInfo* FunctionsReturns;

    unsigned IssueWidth;

public:

    const HMCSubtarget *Subtarget;
    const HMCFunctionInfo *HMCFI;
    HMCMCInstLower MCInstLowering;

    HMCAsmPrinter(TargetMachine &TM, std::unique_ptr<MCStreamer> Streamer)
        : AsmPrinter(TM, std::move(Streamer)), MCInstLowering(*this) {
            
            Subtarget = static_cast<HMCTargetMachine *>(&TM)->getSubtargetImpl();
            FunctionsArguments = Subtarget->getTargetLowering()->getFunctionArguments();
            FunctionsReturns = Subtarget->getTargetLowering()->getFunctionReturns();
            FunctionsCalled = Subtarget->getTargetLowering()->getFunctionCalled();
            IssueWidth = Subtarget->getInstrItineraryData()->SchedModel.IssueWidth;
    }

    virtual const char *getPassName() const{
        return "HMC Assembly Printer";
    }

    virtual bool runOnMachineFunction(MachineFunction &MF);

    const HMCSubtarget* getSubtarget() const { return Subtarget; }

    // EmitInstruction() must exists or will have run time error.
    void EmitInstruction(const MachineInstr *MI);
    void printSavedRegsBitmask(raw_ostream &O);
    void printHex32(unsigned int Value, raw_ostream &O);
    void emitFrameDirective();
    const char* getCurrentABIString() const;
    void EmitFunctionEntryLabel() override;
    void EmitFunctionBodyStart() override;
    void EmitFunctionBodyEnd() override;
    void EmitStartOfAsmFile(Module &M);
    void EmitEndOfAsmFile(Module &M);
    virtual MachineLocation getDebugValueLocation(const MachineInstr *MI) const;
    void PrintDebugValueComment(const MachineInstr *MI, raw_ostream &OS);
    bool PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                         unsigned AsmVariant, const char *ExtraCode,
                         raw_ostream &OS) override;
};

}

#endif
