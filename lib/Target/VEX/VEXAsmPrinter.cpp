//===-- VEXAsmPrinter.cpp - VEX LLVM Assembly Printer -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to GAS-format VEX assembly language.
//
//===----------------------------------------------------------------------===//

#include "VEXAsmPrinter.h"

#include "InstPrinter/VEXInstPrinter.h"

#include "MCTargetDesc/VEXBaseInfo.h"

#include "VEXTargetMachine.h"

#include "VEX.h"
#include "VEXInstrInfo.h"
#include "VEXTargetStreamer.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/Twine.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Mangler.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Target/TargetOptions.h"

using namespace llvm;

#define DEBUG_TYPE "vex-asm-printer"

// Later, this will be known in compile time, with no hint.
static cl::opt<bool> PrintNops("print-nops",
                                cl::Hidden, cl::init(false),
                                cl::desc("Print NOP Information in the assembly file"));

// FIXME :  Verify if this is correct for our VEX architecture

bool VEXAsmPrinter::runOnMachineFunction(MachineFunction &MF){
    Subtarget = &MF.getSubtarget<VEXSubtarget>();

    DEBUG(errs() << "\n\nVEX asm Printer\n\n");
    VEXFI = MF.getInfo<VEXFunctionInfo>();
    AsmPrinter::runOnMachineFunction(MF);
    return true;
}

struct LaneInfo {
    unsigned Issue;
    MachineBasicBlock::const_instr_iterator Instr;

    LaneInfo(unsigned Issue, MachineBasicBlock::const_instr_iterator Inst)
        : Issue(Issue), Instr(Inst) {
    }
};

struct InstructionInfo {
    // Ascending Sort
    bool operator() (InstructionInfo i,InstructionInfo j) { return (i.TotalFuncUnits < j.TotalFuncUnits);}

    MachineBasicBlock::const_instr_iterator Instr;
    unsigned TotalFuncUnits;

    InstructionInfo (MachineBasicBlock::const_instr_iterator I, unsigned FuncUnits) : Instr(I), TotalFuncUnits(FuncUnits) {
    }

    InstructionInfo () : Instr(nullptr), TotalFuncUnits(0) {
    }

};

//Emit Instruction must exists or will have run time error
void VEXAsmPrinter::EmitInstruction(const MachineInstr *MI){

    if(MI->isDebugValue()){
        SmallString<128> Str;
        raw_svector_ostream OS(Str);

        PrintDebugValueComment(MI, OS);
        return;
    }

    DEBUG(errs() << "Emitting instruction " << MI->getOpcode() << "\n");
    
    MCInst TmpInst0;
    std::vector<LaneInfo *> Lanes(IssueWidth);

    if (MI->isBundle()) {

        for (unsigned i = 0; i < IssueWidth; ++i) {
            Lanes[i] = new LaneInfo(i, nullptr);
        }

        MachineBasicBlock::const_instr_iterator I = MI;
        MachineBasicBlock::const_instr_iterator E = MI->getParent()->instr_end();
        if (PrintNops) {

            std::vector<InstructionInfo *> Instrs;

            for (++I; E != I && I->isInsideBundle(); ++I) {

                DEBUG(I->dump());

                MCInstrDesc MID = I->getDesc();
                unsigned InsnClass = MID.getSchedClass();
                const InstrItineraryData* InstrItins = Subtarget->getInstrItineraryData();
                const llvm::InstrStage *IS = InstrItins->beginStage(InsnClass);
                unsigned FuncUnits = IS->getUnits();

                Instrs.push_back(new InstructionInfo(I,FuncUnits));
            }

            std::sort(Instrs.begin(), Instrs.end(), [](InstructionInfo* a, InstructionInfo* b) {
                    return a->TotalFuncUnits < b->TotalFuncUnits;
                });

            for (struct InstructionInfo* Inst : Instrs) {
                DEBUG(Inst->Instr->dump());
                DEBUG(dbgs() << " TotalFuncUnits: "
                      << Inst->TotalFuncUnits << "\n\n");

                for (unsigned i = 0; i < IssueWidth; ++i) {
                    if (!(Lanes[i]->Instr) && ((Inst->TotalFuncUnits >> i) & 0x1)) {
                        Lanes[i]->Instr = Inst->Instr;
                        break;
                    }
                }
            }

            for (unsigned i = 0; i < IssueWidth; ++i) {
                DEBUG(dbgs() << "Lane: " << Lanes[i]->Issue << "\n");
                if (Lanes[i]->Instr)
                    DEBUG(Lanes[i]->Instr->dump());
                else
                    DEBUG(dbgs() << "No Instruction\n");
            }

        } else {
            unsigned i = 0;
            for (++I; E != I && I->isInsideBundle(); ++I) {
                Lanes[i++]->Instr = I;
            }
        }


        SmallVector<MCInst, 16> TmpInst;
        unsigned inst = 0;
        TmpInst0.setOpcode(MI->getOpcode());

        unsigned numValReturn = 0;
        unsigned numValArgumentOrLane = 0;

        for (unsigned i = 0; i < IssueWidth; ++i) {
            I = Lanes[i]->Instr;

            if (!I) {
                numValArgumentOrLane = i;
                if (!PrintNops) {
                    continue;
                }
            } else {
                if (I->isCFIInstruction() ||
                    I->isDebugValue() ||
                    I->isImplicitDef()) {
                    continue;
                } else {
                    if (I->isCall()) {
                        std::string FunctionName;

                        if (I->getOperand(0).isGlobal()) {
                            FunctionsCalledByCallee.insert(I->getOperand(0).getGlobal()->getName().str());
                            FunctionName = I->getOperand(0).getGlobal()->getName().str();
                        } else if (I->getOperand(0).isSymbol()) {
                            FunctionsCalledByCallee.insert(std::string(I->getOperand(0).getSymbolName()));
                            FunctionName = std::string(I->getOperand(0).getSymbolName());
                        }
                        std::multimap<std::string, unsigned>::iterator it = FunctionsArguments->info.find(FunctionName);

                        if (it == FunctionsArguments->info.end()) {
                            it = FunctionsCalled->info.find(FunctionName);
                            numValArgumentOrLane = (*it).second;
                            numValReturn = FunctionsReturns->info.find(FunctionName)->second;

                        } else {
                            numValArgumentOrLane = (*it).second;
                            numValReturn = FunctionsReturns->info.find(FunctionName)->second;
                        }

                        DEBUG(dbgs() << "Func: " << FunctionName << " NumValArg: " << numValArgumentOrLane << " NumReturn: " << numValReturn << "\n");

                    } else if (I->isReturn()) {
                        numValArgumentOrLane = 0;
                        numValReturn = FunctionsReturns->info.find(MF->getName().str())->second;
                    }
                }
            }

            MCInst Tmp;
            TmpInst.push_back(Tmp);
            MCInstLowering.Lower(I, TmpInst0, TmpInst[inst++], true, numValArgumentOrLane, numValReturn);
        }
        if (PrintNops) {
            MCInst Tmp;
            TmpInst.push_back(Tmp);
            MCInstLowering.Lower(nullptr, TmpInst0, TmpInst[inst++], true, 16, numValReturn);
        }

        for (unsigned i = 0, e = TmpInst0.getNumOperands();
             i != e ; ++i){
                // printInstruction(mi, O) defined in VEXGenAsmWriter.inc which came from
                // VEX.td indicate.
                if (TmpInst0.getOperand(i).isInst())
                    DEBUG(dbgs() << "IS INSTRUCTION\n");
                else
                    DEBUG(dbgs() << "NO INSTRUCTION\n");
                const MCInst *inst = TmpInst0.getOperand(i).getInst();
                DEBUG(dbgs() << inst->getOpcode() << " \n");
        }
        OutStreamer->EmitInstruction(TmpInst0, getSubtargetInfo());
    } else {

        for (unsigned i = 0; i < IssueWidth; ++i) {
            Lanes[i] = new LaneInfo(i, nullptr);
        }

        if (PrintNops) {

            TmpInst0.setOpcode(VEX::BUNDLE);
            MachineBasicBlock::const_instr_iterator I = MI;

            if (!(I->getOpcode() == VEX::NOP)) {
                DEBUG(I->dump());
                MCInstrDesc MID = I->getDesc();
                unsigned InsnClass = MID.getSchedClass();
                const InstrItineraryData* InstrItins = Subtarget->getInstrItineraryData();
                const llvm::InstrStage *IS = InstrItins->beginStage(InsnClass);
                unsigned FuncUnits = IS->getUnits();
                struct InstructionInfo* Inst = new InstructionInfo(I,FuncUnits);

                DEBUG(Inst->Instr->dump());
                DEBUG(dbgs() << " TotalFuncUnits: "
                      << Inst->TotalFuncUnits << "\n\n");

                for (unsigned i = 0; i < IssueWidth; ++i) {
                    if (!(Lanes[i]->Instr) && ((Inst->TotalFuncUnits >> i) & 0x1)) {
                        Lanes[i]->Instr = Inst->Instr;
                        break;
                    }
                }
                for (unsigned i = 0; i < IssueWidth; ++i) {
                    DEBUG(dbgs() << "Lane: " << Lanes[i]->Issue << "\n");
                    if (Lanes[i]->Instr)
                        DEBUG(Lanes[i]->Instr->dump());
                    else
                        DEBUG(dbgs() << "No Instruction\n");
                }
            }

        } else {
            Lanes[0]->Instr = MI;
            TmpInst0.setOpcode(MI->getOpcode());
        }

        SmallVector<MCInst, 16> TmpInst;
        unsigned inst = 0;

        for (unsigned i = 0; i < IssueWidth; ++i) {
            MachineBasicBlock::const_instr_iterator I = Lanes[i]->Instr;

            unsigned numValReturn = 0;
            unsigned numValArgumentOrLane = 0;

            if (!I) {
                numValArgumentOrLane = i;
                if (!PrintNops) {
                    continue;
                }
            } else {
                if (I->isCFIInstruction() ||
                    I->isDebugValue() ||
                    I->isImplicitDef()) {
                    continue;
                } else {

                    if (I->isCall()) {
                        std::string FunctionName;

                        if (I->getOperand(0).isGlobal()) {
                            FunctionsCalledByCallee.insert(I->getOperand(0).getGlobal()->getName().str());
                            FunctionName = I->getOperand(0).getGlobal()->getName().str();
                        } else if (I->getOperand(0).isSymbol()) {
                                    FunctionsCalledByCallee.insert(std::string(I->getOperand(0).getSymbolName()));
                                    FunctionName = std::string(I->getOperand(0).getSymbolName());
                        }
                        std::multimap<std::string, unsigned>::iterator it = FunctionsArguments->info.find(FunctionName);

                        if (it == FunctionsArguments->info.end()) {
                            it = FunctionsCalled->info.find(FunctionName);
                            numValArgumentOrLane = (*it).second;
                            numValReturn = FunctionsReturns->info.find(FunctionName)->second;

                        } else {
                            numValArgumentOrLane = (*it).second;
                            numValReturn = FunctionsReturns->info.find(FunctionName)->second;
                        }
                        DEBUG(dbgs() << "Func: " << FunctionName << " NumValArg: " << numValArgumentOrLane << " NumReturn: " << numValReturn << "\n");

                    } else
                        if (I->isReturn()) {
                            numValArgumentOrLane = 0;
                            numValReturn = FunctionsReturns->info.find(MF->getName().str())->second;
                        }
                }
            }
            if (PrintNops) {
                MCInst Tmp;
                TmpInst.push_back(Tmp);
                MCInstLowering.Lower(I, TmpInst0, TmpInst[inst++], true, numValArgumentOrLane, numValReturn);
            } else {
                MCInstLowering.Lower(I, TmpInst0, TmpInst0, false, numValArgumentOrLane, numValReturn);
            }
        }
        if (PrintNops) {
            MCInst Tmp;
            TmpInst.push_back(Tmp);
            MCInstLowering.Lower(nullptr, TmpInst0, TmpInst[inst++], true, 16, 0);
        }
        OutStreamer->EmitInstruction(TmpInst0, getSubtargetInfo());
    }
    DEBUG(errs() << "Done emitting\n");
}

// Create a bitmask with all callee saved registers for CPU
// registers. For CPU registers consider LR, GP and BR register for saving if necessary
void VEXAsmPrinter::printSavedRegsBitmask(raw_ostream &O){
    // CPU Saved Registers Bitmasks
    unsigned CPUBitmask = 0;

    int CPUTopSavedRegOff;

    // set the CPU bitmasks
    const MachineFrameInfo *MFI = MF->getFrameInfo();
    const std::vector<CalleeSavedInfo> &CSI = MFI->getCalleeSavedInfo();
    // size of stack area to which FP(?) callee-saved registers are saved.
    //unsigned CPURegSize = VEX::B

    unsigned i = 0, e = CSI.size();
    // Set CPU Bitmask
    for (; i != e; ++i){
        unsigned Reg = CSI[i].getReg();
        unsigned RegNum = getVEXRegisterNumbering(Reg);
        CPUBitmask |= (1 << RegNum);
    }

    // FIXME !!!!! Is this really 0?
    CPUTopSavedRegOff = 0;

    //Print CPUBitmask
    O << "\t.mask \t"; printHex32(CPUBitmask, O);
    O << "," << CPUTopSavedRegOff << '\n';
}

// Print a 32 bit hex number with all numbers.
void VEXAsmPrinter::printHex32(unsigned Value, raw_ostream &O) {
  O << "0x";
  for (int i = 7; i >= 0; i--)
    O.write_hex((Value & (0xF << (i*4))) >> (i*4));
}

//===----------------------------------------------------------------------===//
// Frame and Set directives (NOT USED)
//===----------------------------------------------------------------------===//
//->	.frame	$sp,8,$lr
//	.mask 	0x00000000,0
//	.set	noreorder
//	.set	nomacro
/// Frame Directive
void VEXAsmPrinter::emitFrameDirective(){
    const TargetRegisterInfo &RI = *MF->getSubtarget().getRegisterInfo();

    unsigned stackReg = RI.getFrameRegister(*MF);
    unsigned returnReg = RI.getRARegister();
    unsigned stackSize = MF->getFrameInfo()->getStackSize();

//    if(OutStreamer.hasRawTextSupport())
//        OutStreamer.EmitRawText("\t.frame\t$" +
//                                StringRef(VEXInstPrinter::getRegisterName(stackReg)).lower() +
//                                "," + Twine(stackSize) + ", $" +
//                                StringRef(VEXInstPrinter::getRegisterName(returnReg)).lower());
}

const char *VEXAsmPrinter::getCurrentABIString() const {
    return "abi32";
}

// .entry caller, sp=$r0.1, rl=$l0.0, asize=80, arg()
// main:
void VEXAsmPrinter::EmitFunctionEntryLabel() {
//    if(OutStreamer.hasRawTextSupport())
    unsigned StackSize = MF->getFrameInfo()->getStackSize() == 0 ? 0 : RoundUpToAlignment(MF->getFrameInfo()->getStackSize(), 32);
    OutStreamer->EmitRawText(".section .text \n.proc \n.entry caller, sp=$r0.1, rl=$l0.0, asize=-" +
                            Twine(StackSize) +
                            ", arg($r0.3:u32, $r0.4:u32, $r0.5:u32, $r0.6:u32, $r0.7:u32, $r0.8:u32, $r0.9:u32, $r0.10:u32)");
    OutStreamer->EmitRawText(Twine(CurrentFnSym->getName())+"::");
}

// FIXME : Should this be implemented

//  .frame  $sp,8,$pc
//  .mask   0x00000000,0
//->  .set  noreorder
//->  .set  nomacro
/// EmitFunctionBodyStart - Targets can override this to emit stuff before
/// the first basic block in the function.
void VEXAsmPrinter::EmitFunctionBodyStart() {
    MCInstLowering.Initialize(&MF->getContext());
    emitFrameDirective();

//    if (OutStreamer.hasRawTextSupport()) {
//        SmallString<128> Str;
//        raw_svector_ostream OS(Str);
//        printSavedRegsBitmask(OS);
//        OutStreamer.EmitRawText(OS.str());
//        OutStreamer.EmitRawText(StringRef("\t.set\tnoreorder"));
//        OutStreamer.EmitRawText(StringRef("\t.set\tnomacro"));
//
//        if (VEXFI->getEmitNOAT())
//            OutStreamer.EmitRawText(StringRef("\t.set\tnoat"));
//    }
}

/// EmitFunctionBodyEnd - Targets can override this to emit stuff after
/// the last basic block in the function.
///
/// .endp
void VEXAsmPrinter::EmitFunctionBodyEnd() {
    // There are instruction for this macros, but they must
    // always be at the function end, and we can't emit and
    // break with BB logic.
    OutStreamer->EmitRawText(".endp\n");
}

// FIXME : Is this correct?
//  .section .mdebug.abi32
//  .previous
void VEXAsmPrinter::EmitStartOfAsmFile(Module &M){

//    // Tell the assembler which ABI we are using
//    if(OutStreamer.hasRawTextSupport())
//        OutStreamer.EmitRawText("\t.section .mdebug." +
//                                Twine(getCurrentABIString()));
//
//    // return to previous section
//    if(OutStreamer.hasRawTextSupport())
//        OutStreamer.EmitRawText(StringRef("\t.previous"));
}

void VEXAsmPrinter::EmitEndOfAsmFile(Module &M) {
    
//    for (Module::iterator I = M.begin(), E = M.end(); I != E; ++I) {
//        if (I->isDeclaration()) {
//            OutStreamer->EmitRawText(".import " + I->getName() + "\n");
//            OutStreamer->EmitRawText(".type " + I->getName() + ", @function\n");
//        }
//    }
    for(StringRef FuncCall: FunctionsCalledByCallee) {
        OutStreamer->EmitRawText(".import " + FuncCall.str() + "\n");
        OutStreamer->EmitRawText(".type " + FuncCall.str() + ", @function\n");
    }
}

// FIXME :  Is this algorithm correct?
MachineLocation VEXAsmPrinter::getDebugValueLocation(const MachineInstr *MI) const{
    //Handles frame address emit in VEXInstrInfo::emitFrameIndexDebugValue.
    assert(MI->getNumOperands() == 4 && "Invalid no. of machine operands!");
    assert(MI->getOperand(0).isReg() && MI->getOperand(1).isImm() &&
           "Unexpected MachineOperand types");
    return MachineLocation(MI->getOperand(0).getReg(),
                           MI->getOperand(1).getImm());
}

void VEXAsmPrinter::PrintDebugValueComment(const MachineInstr *MI,
                                           raw_ostream &OS) {
  // TODO: implement
  OS << "PrintDebugValueComment()";
}

// PROBABLY THIS IS NOT USED
bool VEXAsmPrinter::PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                                    unsigned AsmVariant, const char *ExtraCode,
                                    raw_ostream &O){
    if (ExtraCode && ExtraCode[0]) {
        if (ExtraCode[1] != 0) return true; // Unknown modifier.
        
        switch (ExtraCode[0]) {
            default:
                // See if this is a generic print operand
                return AsmPrinter::PrintAsmOperand(MI, OpNo, AsmVariant, ExtraCode, O);
            case 'r':
                break;
        }
    }
    
    const MachineOperand &MO = MI->getOperand(OpNo);
    switch (MO.getType()) {
        default:
            return true;  // Unknown modifier.
        case MachineOperand::MO_Immediate: // Substitute immediate value without immediate syntax
            O << MO.getImm();
            return false;
        case MachineOperand::MO_Register:
            O << "$" << StringRef(VEXInstPrinter::getRegisterName(MO.getReg())).lower();
            return false;
    }
    
    return false;
}

// Force static initialization.
extern "C" void LLVMInitializeVEXAsmPrinter() {
  RegisterAsmPrinter<VEXAsmPrinter> X(TheVEXTarget);
  RegisterAsmPrinter<VEXAsmPrinter> Y(TheVEXNewTarget);
}

