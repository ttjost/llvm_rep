//===-- VEXMCInstLower.cpp - Convert VEX MachineInstr to MCInst ---------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains code to lower VEX MachineInstrs to their corresponding
// MCInst records.
//
//===----------------------------------------------------------------------===//

#include "VEXMCInstLower.h"

#include "VEXAsmPrinter.h"
#include "VEXInstrInfo.h"
#include "MCTargetDesc/VEXBaseInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/IR/Mangler.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"


#define DEBUG_TYPE "vex-mcinslower"

using namespace llvm;

VEXMCInstLower::VEXMCInstLower(VEXAsmPrinter &asmprinter)
: AsmPrinter(asmprinter) {
    DEBUG(errs() << "MCInstLower\n");
}

void VEXMCInstLower::Initialize(MCContext *C){
    Ctx = C;
}

//static void CreateMCInst(MCInst &Inst, unsigned Opc, const MCOperand& Opnd0,
//                         const MCOperand& Opnd1, const MCOperand Opnd2 = MCOperand()){
//    Inst.setOpcode(Opc);
//    Inst.addOperand(Opnd0);
//    Inst.addOperand(Opnd1);
//    if(Opnd2.isValid())
//        Inst.addOperand(Opnd2);
//}

MCSymbol *VEXMCInstLower::
GetGlobalAddressSymbol(const MachineOperand &MO) const{
    return AsmPrinter.getSymbol(MO.getGlobal());
}

MCSymbol *VEXMCInstLower::
GetExternalSymbolSymbol(StringRef Symbol) const {
    return AsmPrinter.GetExternalSymbolSymbol(Symbol);
}



// LowerOperand
MCOperand VEXMCInstLower::LowerOperand(const MachineOperand &MO,
                                       unsigned Offset) const {
    MachineOperandType MOTy = MO.getType();
    
    switch (MOTy) {
        case MachineOperand::MO_Register:
            // Ignore all implicit register operands
            if(MO.isImplicit()) break;
            return MCOperand::createReg(MO.getReg());
        case MachineOperand::MO_Immediate:
            return MCOperand::createImm(MO.getImm() + Offset);
        case MachineOperand::MO_RegisterMask:
            break;
        case MachineOperand::MO_MachineBasicBlock:
            return MCOperand::createExpr(MCSymbolRefExpr::create(MO.getMBB()->getSymbol(), *Ctx));
        case MachineOperand::MO_GlobalAddress:
            return MCOperand::createExpr(MCSymbolRefExpr::create(GetGlobalAddressSymbol(MO), *Ctx));
        case MachineOperand::MO_ExternalSymbol:
            return MCOperand::createExpr(MCSymbolRefExpr::create(GetExternalSymbolSymbol(MO.getSymbolName()), *Ctx));
        default:
            llvm_unreachable("unknown operand type");
            break;
    }
    return MCOperand();
}

void VEXMCInstLower::Lower(const MachineInstr *MI,
                           MCInst &OutMI,
                           MCInst &InBundleMI,
                           bool isInsideBundle,
                           unsigned numValArgumentOrLane,
                           unsigned numValReturn) const{
    DEBUG(errs() << "MCInstLower::Lower\n");

    if (!MI) {
        InBundleMI.setOpcode(VEX::NOPInstr0 + numValArgumentOrLane);
        MCOperand MCOp1 = MCOperand::createReg(VEX::Reg0);
        InBundleMI.addOperand(MCOp1);
        MCOperand MCOp2 = MCOperand::createReg(VEX::Reg0);
        InBundleMI.addOperand(MCOp2);
    } else {
        InBundleMI.setOpcode(MI->getOpcode());

        for (unsigned i = 0, e = MI->getNumOperands(); i != e ; ++i){
            const MachineOperand &MO = MI->getOperand(i);
            MCOperand MCOp = LowerOperand(MO);

            if(MCOp.isValid())
                InBundleMI.addOperand(MCOp);
        }

        if (numValArgumentOrLane != 0 || (numValArgumentOrLane == 0 && numValReturn != 0)) {
            MachineOperand MO = MachineOperand::CreateImm(numValArgumentOrLane);
            MCOperand MCOp = LowerOperand(MO);
            InBundleMI.addOperand(MCOp);
        }

        if (numValReturn != 0) {
            MachineOperand MO = MachineOperand::CreateImm(numValReturn);
            MCOperand MCOp = LowerOperand(MO);
            InBundleMI.addOperand(MCOp);
        }
    }

    if (isInsideBundle) {
        DEBUG(errs() << "Is Inside BUNDLE Instruction\n");
        MCOperand MCOp = MCOperand::createInst(&InBundleMI);
        OutMI.addOperand(MCOp);
    } else {
       DEBUG(errs() << "NOT BUNDLE\n");
       OutMI = InBundleMI;
    }
}
