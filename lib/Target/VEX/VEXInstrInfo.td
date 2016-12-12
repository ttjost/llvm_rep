//===-- VEXInstrInfo.td - Target Description for VEX Target -----------===//
//
// This file describes the VEX instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

include "VEXInstrFormats.td"

//===----------------------------------------------------------------------===//
// Instruction Pattern Stuff
//===----------------------------------------------------------------------===//

//def simm9Op : Operand<i32> {
//  let DecoderMethod = "DecodeSIMM9";
//}

def imm32   : PatLeaf<(imm), [{ return isInt<32>(N->getSExtValue()); }]>;
def imm32Op : Operand<i32>;

//def immZExt5 : PatLeaf<(imm32), [{
//    return N->getZExtValue() == ((N->getZExtValue()) & 0x1f) ;
//}]>;

//def imm5Op  : Operand<i32>;

//// Node immediate is zero (e.g. insve.d)
//def imms : PatLeaf<(imm), [{ return isInt<1>(N->getSExtValue()); }]>;
//def immSExt8  : PatLeaf<(imm), [{ return isInt<8>(N->getSExtValue()); }]>;
//def immSExt16  : PatLeaf<(imm), [{ return isInt<16>(N->getSExtValue()); }]>;

//// Node immediate is zero (e.g. insve.d)
//def immz : PatLeaf<(imm), [{ return isInt<1>(N->getZExtValue()); }]>;
//def immZExt8  : PatLeaf<(imm), [{ return isInt<8>(N->getZExtValue()); }]>;
//def immZExt16  : PatLeaf<(imm), [{ return isInt<16>(N->getZExtValue()); }]>;

def ADDR : ComplexPattern<iPTR, 2, "SelectAddr", [frameindex], []>;

// Address operands

def VEXMEMriAsmOperand : AsmOperandClass {
  let Name = "MEMri";
  let ParserMethod = "parseMEMOperand";
} 

def MEM : Operand<iPTR> {
  let PrintMethod = "printMemOperand";
  let MIOperandInfo = (ops ptr_rc, imm32Op);
  let ParserMatchClass = VEXMEMriAsmOperand;
}

// Used for FrameIndex Node. We need another print method, so we
// define printMemOperandEA which will be called in VEXInstPrinter class
def ADDR_FI : Operand<i32> {
  let PrintMethod = "printMemOperandEA";
  let MIOperandInfo = (ops GPRegs, imm32Op);
  let EncoderMethod = "getMemEncoding";
}

def brtarget : Operand<OtherVT> {
// Methods used by Assembler and Disassembler.
  let EncoderMethod = "getBranchTargetOpValue";
  let DecoderMethod = "DecodeBranchTarget";
}

//===----------------------------------------------------------------------===//
// VEX Profiles and Nodes
//===----------------------------------------------------------------------===//


//===----------------------------------------------------------------------===//
// Type Profiles.
//===----------------------------------------------------------------------===//

//def SDT_VEXBranchCond : SDTypeProfile <0, 2, [SDTCisInt<0>, SDTCisVT<1, OtherVT> ]>;

def SDT_VEXWrapper : SDTypeProfile <1, 1, [SDTCisSameAs<0, 1>,
                                           SDTCisPtrTy<0>]>;

def SDT_VEXMov : SDTypeProfile <1, 1, [SDTCisSameAs<0, 1>,
                                    SDTCisInt<0>]>;

def SDT_VEXTWORESULT : SDTypeProfile<2, 3,
                                     [SDTCisSameAs<0, 2>,
                                     SDTCisSameAs<0, 3>,
                                     SDTCisInt<0>,
                                     SDTCisVT<1, i1>,
                                     SDTCisVT<4, i1>]>;

def SDT_VEXSLCT : SDTypeProfile<1, 3,
                                    [SDTCisSameAs<0, 2>,
                                        SDTCisSameAs<0, 3>,
                                        SDTCisInt<0>,
                                        SDTCisVT<1, i1>]>;

def SDT_VEXPseudoCall         : SDTypeProfile<0, -1, [SDTCisVT<0, iPTR>]>;
def SDT_VEXPseudoTailCall     : SDTypeProfile<0, -1, [SDTCisVT<0, iPTR>]>;
def SDT_VEXCallSeqStart : SDCallSeqStart<[SDTCisVT<0, i32>]>;
def SDT_VEXCallSeqEnd   : SDCallSeqEnd<[SDTCisVT<0, i32>, SDTCisVT<1, i32>]>;

//===----------------------------------------------------------------------===//
// VEX Specific Node Definitions.
//===----------------------------------------------------------------------===//

def VEXPseudoRet : SDNode<"VEXISD::PSEUDO_RET", SDTNone,
                          [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;

def VEXMov : SDNode<"VEXISD::MOV", SDT_VEXMov>;

def VEXADDCG    : SDNode<"VEXISD::ADDCG", SDT_VEXTWORESULT>;
def VEXDIVS     : SDNode<"VEXISD::DIVS", SDT_VEXTWORESULT>;

def VEXWrapper : SDNode<"VEXISD::WRAPPER", SDT_VEXWrapper>;

def VEXPseudoCall    : SDNode<"VEXISD::PSEUDO_CALL", SDT_VEXPseudoCall,
                        [SDNPHasChain, SDNPOutGlue,
                        SDNPOptInGlue, SDNPVariadic]>;

def VEXPseudoTailCall    : SDNode<"VEXISD::PSEUDO_TAILCALL", SDT_VEXPseudoTailCall,
                                [SDNPHasChain, SDNPOutGlue,
                                SDNPOptInGlue, SDNPVariadic]>;

def VEXCallseq_start :  SDNode<"ISD::CALLSEQ_START", SDT_VEXCallSeqStart,
                               [SDNPHasChain, SDNPOutGlue]>;

def VEXCallseq_end: SDNode<"ISD::CALLSEQ_END",   SDT_VEXCallSeqEnd,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue]>;

// **************************************************************
//                       NOT USED
//
//def VEXBr       : SDNode<"VEXISD::BR", SDT_VEXBranchCond,
//                    [SDNPHasChain, SDNPOptInGlue]>;
//
//def VEXBrf       : SDNode<"VEXISD::BRF", SDT_VEXBranchCond,
//                    [SDNPHasChain, SDNPOptInGlue]>;
// **************************************************************

def VEXMax   : SDNode<"VEXISD::MAX", SDTIntBinOp>;
def VEXMaxu  : SDNode<"VEXISD::MAXU", SDTIntBinOp>;
def VEXMin   : SDNode<"VEXISD::MIN", SDTIntBinOp>;
def VEXMinu  : SDNode<"VEXISD::MINU", SDTIntBinOp>;

def VEXOrc      : SDNode<"VEXISD::ORC", SDTIntBinOp>;
def VEXSh1Add   : SDNode<"VEXISD::SH1ADD", SDTIntBinOp>;

def VEXSlct     : SDNode<"VEXISD::SLCT", SDT_VEXSLCT>;

def VEXMPYLL    : SDNode<"VEXISD::MPYLL", SDTIntBinOp>;
def VEXMPYLLU   : SDNode<"VEXISD::MPYLLU", SDTIntBinOp>;
def VEXMPYLH    : SDNode<"VEXISD::MPYLH", SDTIntBinOp>;
def VEXMPYLHU   : SDNode<"VEXISD::MPYLHU", SDTIntBinOp>;
def VEXMPYHH    : SDNode<"VEXISD::MPYHH", SDTIntBinOp>;
def VEXMPYHHU   : SDNode<"VEXISD::MPYHHU", SDTIntBinOp>;
def VEXMPYL     : SDNode<"VEXISD::MPYL", SDTIntBinOp>;
def VEXMPYLU    : SDNode<"VEXISD::MPYLU", SDTIntBinOp>;
def VEXMPYH     : SDNode<"VEXISD::MPYH", SDTIntBinOp>;
def VEXMPYHU    : SDNode<"VEXISD::MPYHU", SDTIntBinOp>;
def VEXMPYHS    : SDNode<"VEXISD::MPYHS", SDTIntBinOp>;


//===----------------------------------------------------------------------===//
// Instruction Class Templates
//===----------------------------------------------------------------------===//

class AlignedLoad<PatFrag Node> :
PatFrag<(ops node:$ptr), (Node node:$ptr), [{
    LoadSDNode *LD = cast<LoadSDNode>(N);
    return LD->getMemoryVT().getSizeInBits()/8 <= LD->getAlignment();
}]>;

class AlignedStore<PatFrag Node> :
PatFrag<(ops node:$val, node:$ptr), (Node node:$val, node:$ptr), [{
    StoreSDNode *SD = cast<StoreSDNode>(N);
    return SD->getMemoryVT().getSizeInBits()/8 <= SD->getAlignment();
}]>;

// Load/Store PatFrags.
def load_a          : AlignedLoad<load>;
def store_a         : AlignedStore<store>;

/// Type I
multiclass ArithLogicInstr<string OpcStr, bits<8> Opcode, SDNode OpNode, InstrItinClass Itin, bit isCommR = 0, bit isCommI = 0> {
  def r  : ArithLogic_r <Opcode,
                      (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                      !strconcat(OpcStr, " $dst = $s1, $s2"),
                      [(set GPRegs:$dst, (OpNode GPRegs:$s1, GPRegs:$s2))], Itin, isCommR>;
  def i  : ArithLogic_i <Opcode,
                      (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                      !strconcat(OpcStr, " $dst = $s1, $s2"),
                      [(set GPRegs:$dst, (OpNode GPRegs:$s1, imm32:$s2))], Itin, isCommI>;
    
}

/// Type I
multiclass SHIFTInstr<string OpcStr, bits<8> Opcode, SDNode OpNode, InstrItinClass Itin, bit isCommR = 0, bit isCommI = 0> {
  def r  : SHIFT_r <Opcode,
                     (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                     !strconcat(OpcStr, " $dst = $s1, $s2"),
                     [(set GPRegs:$dst, (OpNode GPRegs:$s1, GPRegs:$s2))], Itin, isCommR>;
  def i  : SHIFT_i <Opcode,
                   (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                   !strconcat(OpcStr, " $dst = $s1, $s2"),
                   [(set GPRegs:$dst, (OpNode GPRegs:$s1, i32:$s2))], Itin, isCommI>;
}

/// Type I
multiclass MOVInstr<string OpcStr, bits<8> Opcode, RegisterClass DstOp, RegisterClass SrcOp, InstrItinClass Itin> {
  def r  : MOV_r <Opcode,
                     (outs DstOp:$dst), (ins SrcOp:$s1),
                     !strconcat(OpcStr, " $dst = $s1"),
                     [], Itin>;
  def i  : MOV_i <Opcode,
                     (outs DstOp:$dst), (ins i32imm:$s1),
                     !strconcat(OpcStr, " $dst = $s1"),
                     [], Itin>{
    let isMoveImm = 1;
    }
}

let isCompare = 1 in {

multiclass CMPInstr<string OpcStr, bits<8> OpVal, PatFrag cond_op,
                    InstrItinClass ItinBrReg, InstrItinClass ItinGPReg>{

def BRegr: InstVEX<(outs BrRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                    !strconcat(OpcStr, " $dst = $s1, $s2"),
                    [(set BrRegs:$dst, (cond_op GPRegs:$s1, GPRegs:$s2))], ItinBrReg>;

def BRegi : InstVEX<(outs BrRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                    !strconcat(OpcStr, " $dst = $s1, $s2"),
                    [(set BrRegs:$dst, (cond_op GPRegs:$s1, imm32:$s2))], ItinBrReg>;

def Regr : InstVEX<(outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                    !strconcat(OpcStr, " $dst = $s1, $s2"),
                    [(set GPRegs:$dst, (cond_op GPRegs:$s1, GPRegs:$s2))], ItinGPReg>;
def Regi : InstVEX<(outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                    !strconcat(OpcStr, " $dst = $s1, $s2"),
                    [(set GPRegs:$dst, (cond_op GPRegs:$s1, imm32:$s2))], ItinGPReg>;

}
}

class LoadInstr<string OpcStr, bits<8> OpVal, PatFrag OpNode, InstrItinClass Itin>
    : InstVEX<(outs GPRegs:$dst), (ins MEM:$addr),
                !strconcat(OpcStr, " $dst = $addr"),
                [(set GPRegs:$dst, (OpNode ADDR:$addr))], Itin>{
//    let DecoderMethod = "DecodeMem";
    let canFoldAsLoad = 1;
    let mayLoad = 1;
}

class LoadInstrLr<string OpcStr, bits<8> OpVal, PatFrag OpNode, InstrItinClass Itin>
    : InstVEX<(outs LrReg:$dst), (ins MEM:$addr),
                !strconcat(OpcStr, " $dst = $addr"),
                [(set LrReg:$dst, (OpNode ADDR:$addr))], Itin>{
    //    let DecoderMethod = "DecodeMem";
    let canFoldAsLoad = 1;
    let mayLoad = 1;
}

// ScratchPad Instructions.
// We do not need to match these instructions with the DAG,
// because we will insert them manually, whenever is needed.
class LoadInstrSpm<string OpcStr, bits<8> OpVal, InstrItinClass Itin>
    : InstVEX<(outs GPRegs:$dst), (ins MEM:$addr),
                !strconcat(OpcStr, " $dst = $addr"),
                [], Itin>{
//    let DecoderMethod = "DecodeMem";
    let mayLoad = 1;
}

class StoreInstr<string OpcStr, bits<8> OpVal, PatFrag OpNode, InstrItinClass Itin>
    : InstVEX<(outs), (ins GPRegs:$s1, MEM:$addr),
                !strconcat(OpcStr, " $addr = $s1"),
                [(OpNode GPRegs:$s1, ADDR:$addr)], Itin>{
    //    let DecoderMethod = "DecodeMem";
    let mayStore = 1;
}

class StoreInstrLr<string OpcStr, bits<8> OpVal, PatFrag OpNode, InstrItinClass Itin>
    : InstVEX<(outs), (ins LrReg:$s1, MEM:$addr),
                !strconcat(OpcStr, " $addr = $s1"),
                [(OpNode LrReg:$s1, ADDR:$addr)], Itin>{
    //    let DecoderMethod = "DecodeMem";
    let mayStore = 1;
}

// ScratchPad Instructions.
// We do not need to match these instructions with the DAG,
// because we will insert them manually, whenever is needed.
class StoreInstrSpm<string OpcStr, bits<8> OpVal, InstrItinClass Itin>
    : InstVEX<(outs), (ins GPRegs:$s1, MEM:$addr),
                !strconcat(OpcStr, " $addr = $s1"),
                [], Itin>{
    //    let DecoderMethod = "DecodeMem";
    let mayStore = 1;
}

class ExtendInstr<string OpcStr, bits<8> OpVal, SDNode OpNode, InstrItinClass Itin>
    : InstVEX<(outs GPRegs:$dst), (ins GPRegs:$s1),
              !strconcat(OpcStr, " $dst = $s1"),
              [], Itin>{
}

class ExtendImmediateInstr<InstrItinClass Itin>
    : InstVEX<(outs), (ins),
            "longimmediate",
            [], Itin>{
}

class TwoResultInstr<string OpcStr, bits<8> OpVal, SDNode OpNode, InstrItinClass Itin>
    : InstVEX<(outs GPRegs:$dst1, BrRegs:$cout ), (ins GPRegs:$s1, GPRegs:$s2, BrRegs:$cin),
              !strconcat(OpcStr, " $dst1, $cout = $s1, $s2, $cin"),
              [(set GPRegs:$dst1, BrRegs:$cout, (OpNode GPRegs:$s1, GPRegs:$s2, BrRegs:$cin))],
              Itin>{
}

class ReturnInstr<string OpcStr, bits<8> OpVal, InstrItinClass Itin>
   : InstVEX<(outs GPRegs:$dst), (ins GPRegs:$sp, imm32Op:$imm, GPRegs:$l0),
               !strconcat(OpcStr, " $dst = $sp, $imm, $l0"),
                [], Itin>{
    let isTerminator = 1;
    let isBarrier = 1;
    let isReturn = 1;
}

let isTerminator = 1, isBranch = 1 in {
multiclass BranchInstr<string OpcStr1, string OpcStr2, bits<8> OpVal, SDNode OpNode, InstrItinClass Itin>{
def R : InstVEX<(outs), (ins BrRegs:$s1, brtarget:$offset),
                !strconcat(OpcStr1, " $s1, $offset"),
                [(OpNode BrRegs:$s1, bb:$offset)], Itin>;

def RF : InstVEX<(outs), (ins BrRegs:$s1, brtarget:$offset),
                 !strconcat(OpcStr2, " $s1, $offset"),
                 [(OpNode (not BrRegs:$s1), bb:$offset)], Itin>;
}
}

class CallInstr<string OpcStr, bits<8> OpVal, InstrItinClass Itin>
: InstVEX<(outs), (ins GPRegs:$lr, imm32Op:$offset),
    !strconcat(OpcStr, " $lr = $offset"),
    [], Itin>{
    let isTerminator = 1;
    let isBarrier = 1;
    let isBranch = 1;
}

class JumpInstr<string OpcStr, bits<8> OpVal, SDNode OpNode, InstrItinClass Itin>
: InstVEX<(outs), (ins brtarget:$offset),
!strconcat(OpcStr, " $offset"),
[(OpNode bb:$offset)], Itin>{
    let isTerminator = 1;
    let isBarrier = 1;
    let isBranch = 1;
}

multiclass SelectInstr<bits<8> OpVal, InstrItinClass Itin> {

def r  : InstVEX<(outs GPRegs:$dst), (ins BrRegs:$cond, GPRegs:$s1, GPRegs:$s2),
                 "slct $dst = $cond, $s1, $s2",
                 [(set GPRegs:$dst, (select BrRegs:$cond, GPRegs:$s1, GPRegs:$s2))], Itin>;
def i  : InstVEX<(outs GPRegs:$dst), (ins BrRegs:$cond, GPRegs:$s1, imm32Op:$s2),
                 "slct $dst = $cond, $s1, $s2",
                 [(set GPRegs:$dst, (select BrRegs:$cond, GPRegs:$s1, imm32:$s2))], Itin>;
                 
def Fr  : InstVEX<(outs GPRegs:$dst), (ins BrRegs:$cond, GPRegs:$s1, GPRegs:$s2),
                 "slctf $dst = $cond, $s1, $s2",
                 [(set GPRegs:$dst, (select (not BrRegs:$cond), GPRegs:$s1, GPRegs:$s2))], Itin>;
def Fi  : InstVEX<(outs GPRegs:$dst), (ins BrRegs:$cond, GPRegs:$s1, imm32Op:$s2),
                 "slctf $dst = $cond, $s1, $s2",
                 [(set GPRegs:$dst, (select (not BrRegs:$cond), GPRegs:$s1, imm32:$s2))], Itin>;
}

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

def NOP : Pseudo<(outs), (ins) , [], "nop">;

// Look at how NOP Instruction for lanes 10 to 15 are named.
// This happens to keep an order on instruction opcodes.
def NOPInstr0 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop0 $src1 , $src2", [], IIAll>;
def NOPInstr1 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop1 $src1, $src2", [], IIAll>;
def NOPInstr2 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop2 $src1, $src2", [], IIAll>;
def NOPInstr3 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop3 $src1, $src2", [], IIAll>;
def NOPInstr4 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop4 $src1, $src2", [], IIAll>;
def NOPInstr5 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop5 $src1, $src2", [], IIAll>;
def NOPInstr6 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop6 $src1, $src2", [], IIAll>;
def NOPInstr7 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop7 $src1, $src2", [], IIAll>;
def NOPInstr8 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop8 $src1, $src2", [], IIAll>;
def NOPInstr9 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop9 $src1, $src2", [], IIAll>;
def NOPInstr_10 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop10 $src1, $src2", [], IIAll>;
def NOPInstr_11 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop11 $src1, $src2", [], IIAll>;
def NOPInstr_12 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop12 $src1, $src2", [], IIAll>;
def NOPInstr_13 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop13 $src1, $src2", [], IIAll>;
def NOPInstr_14 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop14 $src1, $src2", [], IIAll>;
def NOPInstr_15 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop15 $src1, $src2", [], IIAll>;
def NOPInstr_16 : InstVEX<(outs), (ins GPRegs:$src1, GPRegs:$src2),
                        "nop16 $src1, $src2", [], IIAll>;


// Pattern Fragments
def zext8 : PatFrag<(ops node:$ptr), (i32 (zext (i8 node:$ptr)))>;
//def zextloadi32i1 : PatFrag<(ops node:$ptr), (i32 (zextloadi1 node:$ptr))>;
//def  extloadi32i1 : PatFrag<(ops node:$ptr), (i32 ( extloadi1 node:$ptr))>;

//                      PSEUDO Instructions
// These instructions will not generate code.
// They are used to ease the process of converting SelectionDAG Nodes
// to real target instructions
def PSEUDO_RET : Pseudo<(outs), (ins) , [(VEXPseudoRet)]>{
    let isTerminator = 1;
    let isBarrier = 1;
    let isReturn = 1;
}


let Defs = [Lr] in {
def PSEUDO_TCALL : Pseudo<(outs), (ins i32imm:$offset), [(VEXPseudoTailCall imm:$offset)]> {
    let isTerminator = 1;
    let isBarrier = 1;
    let isReturn = 1;
    let isCall = 1;
}
}

def ADJCALLSTACKDOWN : Pseudo<(outs), (ins imm32Op:$amt),
                              [(VEXCallseq_start timm:$amt)],
                              "#ADJCALLSTACKDOWN">;

def ADJCALLSTACKUP : Pseudo<(outs), (ins imm32Op:$amt1, imm32Op:$amt2),
                              [(VEXCallseq_end timm:$amt1, timm:$amt2)],
                              "#ADJCALLSTACKUP">;

// ADD Instruction
defm ADD    : ArithLogicInstr<"add", 0b01100010, add, IIAlu, 1, 1>;

// AND Instruction
defm AND    : ArithLogicInstr<"and", 0b01100011, and, IIAlu, 1, 1>;

// SUB Instruction
defm SUB    : ArithLogicInstr<"sub", 0b01100011, sub, IIAlu, 1, 1>;

// ANDC Instruction
def ANDCr      : ArithLogic_r<0b01100100,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "andc $dst = $s1, $s2",
                           [(set GPRegs:$dst, (and (not GPRegs:$s1), GPRegs:$s2))], IIAlu, 0>;
def ANDCi      : ArithLogic_i<0b01100100,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "andc $dst = $s1, $s2",
                           [(set GPRegs:$dst, (and (not GPRegs:$s1), imm32:$s2))], IIAlu, 0>;
           
// MAX/MIN Instructions
defm MAX    : ArithLogicInstr<"max", 0b01100101, VEXMax, IIAlu>;
                           
defm MAXU   : ArithLogicInstr<"maxu", 0b01100110, VEXMaxu, IIAlu>;

defm MIN    : ArithLogicInstr<"min", 0b01100100, VEXMin, IIAlu>;

defm MINU   : ArithLogicInstr<"minu", 0b01101000, VEXMinu, IIAlu>;

// OR Instruction
defm OR     : ArithLogicInstr<"or", 0b01101001, or, IIAlu>;

// ORC Instruction
def ORCr      : ArithLogic_r<0b01101010,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "orc $dst = $s1, $s2",
                           [(set GPRegs:$dst, (or GPRegs:$s2, (not GPRegs:$s1)))], IIAlu, 0>;
def ORCi      : ArithLogic_i<0b01101010,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "orc $dst = $s1, $s2",
                           [(set GPRegs:$dst, (or (not GPRegs:$s1), imm32:$s2))], IIAlu, 0>;

// SH1ADD Instruction
def SH1ADDr      : ArithLogic_r<0b01101011,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "sh1add $dst = $s1, $s2",
                           [], IIAlu, 0>;
def SH1ADDi      : ArithLogic_i<0b01101010,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "sh1add $dst = $s1, $s2",
                           [], IIAlu, 0>;

// SH2ADD Instruction
def SH2ADDr      : ArithLogic_r<0b01101100,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "sh2add $dst = $s1, $s2",
                           [], IIAlu, 0>;
def SH2ADDi      : ArithLogic_i<0b01101100,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "sh2add $dst = $s1, $s2",
                           [], IIAlu, 0>;

// SH3ADD Instruction
def SH3ADDr      : ArithLogic_r<0b01101101,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "sh3add $dst = $s1, $s2",
                          [], IIAlu, 0>;
def SH3ADDi      : ArithLogic_i<0b01101101,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "sh3add $dst = $s1, $s2",
                           [], IIAlu, 0>;

// SH4ADD Instruction
def SH4ADDr      : ArithLogic_r<0b01101110,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "sh4add $dst = $s1, $s2",
                           [], IIAlu, 0>;
def SH4ADDi      : ArithLogic_i<0b01101110,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "sh4add $dst = $s1, $s2",
                           [], IIAlu, 0>;
                                                     
// SHL Instruction
def SHLr        : SHIFT_r<0b01101111,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, GPRegs:$s2),
                          "shl $dst = $s1, $s2",
                          [(set GPRegs:$dst, (shl GPRegs:$s1, GPRegs:$s2))], IIAlu, 0>;
def SHLi        : SHIFT_i<0b01101111,
                          (outs GPRegs:$dst), (ins GPRegs:$s1, imm32Op:$s2),
                          "shl $dst = $s1, $s2",
                          [(set GPRegs:$dst, (shl GPRegs:$s1, i32:$s2))], IIAlu, 0>;

// SHR Instruction
defm SHR    : SHIFTInstr<"shr", 0b00011000, sra, IIAlu>;

// SHRU Instruction
defm SHRU   : SHIFTInstr<"shru", 0b00011001, srl, IIAlu>;

// XOR Instruction
defm XOR    : ArithLogicInstr<"xor", 0b00011111, xor, IIAlu, 1, 1>;

defm MOV    : MOVInstr<"mov", 0b00000000, GPRegs, GPRegs, IIAlu>;

def MTB     : MOV_r<0b00000000,
                    (outs BrRegs:$dst), (ins GPRegs:$s1),
                    "mtb $dst = $s1", [], IICpGrBr>;

def MFB     : MOV_r<0b00000000,
                    (outs GPRegs:$dst), (ins BrRegs:$s1),
                    "mfb $dst = $s1", [], IICpBrGr>;

def MFL     : MOV_r<0b00000000,
                    (outs GPRegs:$dst), (ins LrReg:$s1),
                    "mfl $dst = $s1", [], IICpGrLr>;

def MTL     : MOV_r<0b00000000,
                   (outs LrReg:$dst), (ins GPRegs:$s1),
                    "mtl $dst = $s1", [], IICpLrGr>;

// Extend Byte/Half Instructions
def SXTB    : ExtendInstr<"sxtb", 0b00000000, add, IIAlu>;
def ZXTB    : ExtendInstr<"zxtb", 0b00000000, add, IIAlu>;

def SXTH    : ExtendInstr<"sxth", 0b00000000, add, IIAlu>;
def ZXTH    : ExtendInstr<"zxth", 0b00000000, add, IIAlu>;

// Used to Extend Immediate from 9 to 32 bits.
// This will be used in the VEXVLIWPacketizer.cpp file
let isCodeGenOnly = 1, isPseudo = 1 in {
    def EXTIMM  : ExtendImmediateInstr<IIAll>;
}

def DIVS    : TwoResultInstr<"divs", 0b00000000, VEXDIVS, IIAlu>;

// We need to set earlyclobber so we don't use the same registers
// as both sources and destination in the instruction.
// Using such causes some unwanted behaviour in the program
let Constraints = "@earlyclobber $dst1" in
def ADDCG   : TwoResultInstr<"addcg", 0b00000000, VEXADDCG, IIAlu>;


// Select Instructions
defm SLCT   : SelectInstr<0b00000000, IISelect>;


// Create Pattern to "not" instruction
def : Pat<(not GPRegs:$in),
          (XORi GPRegs:$in, -1)>;

def : Pat<(i32 (sext_inreg GPRegs:$src, i8)),
          (SXTB GPRegs:$src)>;

def: Pat<(and (i32 GPRegs:$src1), 0xFF),
         (ZXTB GPRegs:$src1)>;

def: Pat<(and (i32 GPRegs:$src1), 0xFFFF),
         (ZXTH GPRegs:$src1)>;

def : Pat<(i32 (sext_inreg GPRegs:$src, i16)),
          (SXTH GPRegs:$src)>;

// Immediates
def : Pat<(i32 imm32:$in),
          (MOVi imm:$in)>;
def : Pat<(i32 imm:$imm),
          (MOVi imm:$imm)>;

def : Pat<(VEXMov GPRegs:$src),
            (MOVr GPRegs:$src)>;
def : Pat<(VEXMov imm:$in),
            (MOVi imm:$in)>;

// Carry patterns
def : Pat<(subc GPRegs:$lhs, GPRegs:$rhs),
          (SUBr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(addc GPRegs:$lhs, GPRegs:$rhs),
          (ADDr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(addc  GPRegs:$src, imm32:$imm),
          (ADDi GPRegs:$src, imm32:$imm)>;

// Used for ISD::SDIV and ISD::UDIV Instructions
def : Pat<(VEXOrc GPRegs:$lhs, GPRegs:$rhs),
          (ORCr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(VEXSh1Add GPRegs:$lhs, GPRegs:$rhs),
          (SH1ADDr GPRegs:$lhs, GPRegs:$rhs)>;

def : Pat<(VEXSlct BrRegs:$cond, GPRegs:$s1, GPRegs:$s2),
            (SLCTr BrRegs:$cond, GPRegs:$s1, GPRegs:$s2)>;

//def : Pat<(i1 imm:$imm),
//(MOVi imm:$imm)>;

// Handle FrameIndex. Similar to LEA_ADDri from Sparc Architecture
let isCodeGenOnly = 1 in {
def LEA_ADDri   : InstVEX<(outs GPRegs:$dst), (ins ADDR_FI:$addr),
                          "add $dst = $addr",
                          [(set iPTR:$dst, ADDR:$addr)],
                          IIAlu>;
}

// Move Between Regs


//===----------------------------------------------------------------------===//
//                      Multiplication instructions
//===----------------------------------------------------------------------===//

defm MPYLL      : ArithLogicInstr<"mpyll", 0b00000000, VEXMPYLL, IIMultiply, 1, 1>;

defm MPYLLU     : ArithLogicInstr<"mpyllu", 0b00000001, VEXMPYLLU, IIMultiply, 1, 1>;

defm MPYLH      : ArithLogicInstr<"mpylh", 0b00000010, VEXMPYLH, IIMultiply, 1, 1>;

defm MPYLHU     : ArithLogicInstr<"mpylhu", 0b00000010, VEXMPYLHU, IIMultiply, 1, 1>;

defm MPYHH      : ArithLogicInstr<"mpyhh", 0b00000011, VEXMPYHH, IIMultiply, 1, 1>;

defm MPYHHU     : ArithLogicInstr<"mpyhhu", 0b00000100, VEXMPYHHU, IIMultiply, 1, 1>;

defm MPYL       : ArithLogicInstr<"mpyl", 0b00000101, VEXMPYL, IIMultiply, 1, 1>;

defm MPYLU      : ArithLogicInstr<"mpylu", 0b00000110, VEXMPYLU, IIMultiply, 1, 1>;

defm MPYH       : ArithLogicInstr<"mpyh", 0b00000111, VEXMPYH, IIMultiply, 1, 1>;

defm MPYHU      : ArithLogicInstr<"mpyhh", 0b00001001, VEXMPYHU, IIMultiply, 1, 1>;
                           
defm MPYHS      : ArithLogicInstr<"mpyhs", 0b00001010, VEXMPYHS, IIMultiply, 1, 1>;
                           
//===----------------------------------------------------------------------===//
//                      Compare instructions
//===----------------------------------------------------------------------===//
// TODO: Fix these CMP Instructions. Should have both BRegs and GPRegs
// as a result to the set*** DAG operation. For now, it only pattern matches
// with i1 type. It should also do the same for i32.

defm CMPEQ  : CMPInstr<"cmpeq", 0b01000000, seteq, IICmpBr, IICmpGr>;
defm CMPGE  : CMPInstr<"cmpge", 0b01000001, setge, IICmpBr, IICmpGr>;
defm CMPGEU : CMPInstr<"cmpgeu", 0b01000010, setuge, IICmpBr, IICmpGr>;
defm CMPGT  : CMPInstr<"cmpgt", 0b01000011, setgt, IICmpBr, IICmpGr>;
defm CMPGTU : CMPInstr<"cmpgtu", 0b01000100, setugt, IICmpBr, IICmpGr>;
defm CMPLE  : CMPInstr<"cmple", 0b01000101, setle, IICmpBr, IICmpGr>;
defm CMPLEU : CMPInstr<"cmpleu", 0b01000110, setule, IICmpBr, IICmpGr>;
defm CMPLT  : CMPInstr<"cmplt", 0b01000111, setlt, IICmpBr, IICmpGr>;
defm CMPLTU : CMPInstr<"cmpltu", 0b01001000, setult, IICmpBr, IICmpGr>;
defm CMPNE  : CMPInstr<"cmpne", 0b01001001, setne, IICmpBr, IICmpGr>;


//===----------------------------------------------------------------------===//
//                      Memory instructions
//===----------------------------------------------------------------------===//

def LDW       : LoadInstr<"ldw", 0b00010000, load_a, IILoad>;
def STW       : StoreInstr<"stw", 0b00010101, store_a, IIStore>;

def LDWLr     : LoadInstrLr<"ldw", 0b00010000, load_a, IILoadLr>;
def STWLr     : StoreInstrLr<"stw", 0b00010101, store_a, IIStoreLr>;

def LDWPseudo : Pseudo<(outs GPRegs:$dst1, BrRegs:$dst2),
                        (ins MEM:$addr),
                        []>{
    let mayLoad = 1;
}

def STWPseudo : Pseudo<(outs GPRegs:$dst),
                        (ins BrRegs:$s1, MEM:$addr),
                        []>{
    let mayStore = 1;
}

def LDHExt    : LoadInstr<"ldh", 0b00010000, extloadi16, IILoad>;
def LDH       : LoadInstr<"ldh", 0b00010000, sextloadi16, IILoad>;
def LDHU      : LoadInstr<"ldhu", 0b00010000, zextloadi16, IILoad>;
def STH       : StoreInstr<"sth", 0b00010101, truncstorei16, IIStore>;

def LDBExt    : LoadInstr<"ldb", 0b00010000, extloadi8, IILoad>;
def LDB       : LoadInstr<"ldb", 0b00010000, sextloadi8, IILoad>;
def LDBU      : LoadInstr<"ldbu", 0b00010000, zextloadi8, IILoad>;
def STB       : StoreInstr<"stb", 0b00010101, truncstorei8, IIStore>;

// Scratchpad Load/Store Instructions
def LDWSpm       : LoadInstrSpm<"ldwSpm", 0b00010000, IIAll>;
def STWSpm       : StoreInstrSpm<"stwSpm", 0b00010101, IIAll>;
def LDHSpm       : LoadInstrSpm<"ldhSpm", 0b00010000, IIAll>;
def LDHUSpm      : LoadInstrSpm<"ldhuSpm", 0b00010000, IIAll>;
def STHSpm       : StoreInstrSpm<"sthSpm", 0b00010101, IIAll>;
def LDBSpm       : LoadInstrSpm<"ldbSpm", 0b00010000, IIAll>;
def LDBUSpm      : LoadInstrSpm<"ldbuSpm", 0b00010000, IIAll>;
def STBSpm       : StoreInstrSpm<"stwSpm", 0b00010101, IIAll>;

// Separate Instructions for Each Lane
// LLVM does not select these instructions automatically
// Instead, we manually select them at VEXDataReuseTracking.cpp

// Lane 0
def LDW0       : LoadInstrSpm<"ldw0", 0b00010000, IILane0>;
def STW0       : StoreInstrSpm<"stw0", 0b00010101, IILane0>;
def LDH0       : LoadInstrSpm<"ldh0", 0b00010000, IILane0>;
def LDHU0      : LoadInstrSpm<"ldhu0", 0b00010000, IILane0>;
def STH0       : StoreInstrSpm<"sth0", 0b00010101, IILane0>;
def LDB0       : LoadInstrSpm<"ldb0", 0b00010000, IILane0>;
def LDBU0      : LoadInstrSpm<"ldbu0", 0b00010000, IILane0>;
def STB0       : StoreInstrSpm<"stb0", 0b00010101, IILane0>;

// Lane 1
def LDW1       : LoadInstrSpm<"ldw1", 0b00010000, IILane1>;
def STW1       : StoreInstrSpm<"stw1", 0b00010101, IILane1>;
def LDH1       : LoadInstrSpm<"ldh1", 0b00010000, IILane1>;
def LDHU1      : LoadInstrSpm<"ldhu1", 0b00010000, IILane1>;
def STH1       : StoreInstrSpm<"sth1", 0b00010101, IILane1>;
def LDB1       : LoadInstrSpm<"ldb1", 0b00010000, IILane1>;
def LDBU1      : LoadInstrSpm<"ldbu1", 0b00010000, IILane1>;
def STB1       : StoreInstrSpm<"stb1", 0b00010101, IILane1>;

// Lane 2
def LDW2       : LoadInstrSpm<"ldw2", 0b00010000, IILane2>;
def STW2       : StoreInstrSpm<"stw2", 0b00010101, IILane2>;
def LDH2       : LoadInstrSpm<"ldh2", 0b00010000, IILane2>;
def LDHU2      : LoadInstrSpm<"ldhu2", 0b00010000, IILane2>;
def STH2       : StoreInstrSpm<"sth2", 0b00010101, IILane2>;
def LDB2       : LoadInstrSpm<"ldb2", 0b00010000, IILane2>;
def LDBU2      : LoadInstrSpm<"ldbu2", 0b00010000, IILane2>;
def STB2       : StoreInstrSpm<"stb2", 0b00010101, IILane2>;

// Lane 3
def LDW3       : LoadInstrSpm<"ldw3", 0b00010000, IILane3>;
def STW3       : StoreInstrSpm<"stw3", 0b00010101, IILane3>;
def LDH3       : LoadInstrSpm<"ldh3", 0b00010000, IILane3>;
def LDHU3      : LoadInstrSpm<"ldhu3", 0b00010000, IILane3>;
def STH3       : StoreInstrSpm<"sth3", 0b00010101, IILane3>;
def LDB3       : LoadInstrSpm<"ldb3", 0b00010000, IILane3>;
def LDBU3      : LoadInstrSpm<"ldbu3", 0b00010000, IILane3>;
def STB3       : StoreInstrSpm<"stb3", 0b00010101, IILane3>;

// Lane 4
def LDW4       : LoadInstrSpm<"ldw4", 0b00010000, IILane4>;
def STW4       : StoreInstrSpm<"stw4", 0b00010101, IILane4>;
def LDH4       : LoadInstrSpm<"ldh4", 0b00010000, IILane4>;
def LDHU4      : LoadInstrSpm<"ldhu4", 0b00010000, IILane4>;
def STH4       : StoreInstrSpm<"sth4", 0b00010101, IILane4>;
def LDB4       : LoadInstrSpm<"ldb4", 0b00010000, IILane4>;
def LDBU4      : LoadInstrSpm<"ldbu4", 0b00010000, IILane4>;
def STB4       : StoreInstrSpm<"stb4", 0b00010101, IILane4>;

// Lane 5
def LDW5       : LoadInstrSpm<"ldw5", 0b00010000, IILane5>;
def STW5       : StoreInstrSpm<"stw5", 0b00010101, IILane5>;
def LDH5       : LoadInstrSpm<"ldh5", 0b00010000, IILane5>;
def LDHU5      : LoadInstrSpm<"ldhu5", 0b00010000, IILane5>;
def STH5       : StoreInstrSpm<"sth5", 0b00010101, IILane5>;
def LDB5       : LoadInstrSpm<"ldb5", 0b00010000, IILane5>;
def LDBU5      : LoadInstrSpm<"ldbu5", 0b00010000, IILane5>;
def STB5       : StoreInstrSpm<"stb5", 0b00010101, IILane5>;

// Lane 6
def LDW6       : LoadInstrSpm<"ldw6", 0b00010000, IILane6>;
def STW6       : StoreInstrSpm<"stw6", 0b00010101, IILane6>;
def LDH6       : LoadInstrSpm<"ldh6", 0b00010000, IILane6>;
def LDHU6      : LoadInstrSpm<"ldhu6", 0b00010000, IILane6>;
def STH6       : StoreInstrSpm<"sth6", 0b00010101, IILane6>;
def LDB6       : LoadInstrSpm<"ldb6", 0b00010000, IILane6>;
def LDBU6      : LoadInstrSpm<"ldbu6", 0b00010000, IILane6>;
def STB6       : StoreInstrSpm<"stb6", 0b00010101, IILane6>;

// Lane 7
def LDW7       : LoadInstrSpm<"ldw7", 0b00010000, IILane7>;
def STW7       : StoreInstrSpm<"stw7", 0b00010101, IILane7>;
def LDH7       : LoadInstrSpm<"ldh7", 0b00010000, IILane7>;
def LDHU7      : LoadInstrSpm<"ldhu7", 0b00010000, IILane7>;
def STH7       : StoreInstrSpm<"sth7", 0b00010101, IILane7>;
def LDB7       : LoadInstrSpm<"ldb7", 0b00010000, IILane7>;
def LDBU7      : LoadInstrSpm<"ldbu7", 0b00010000, IILane7>;
def STB7       : StoreInstrSpm<"stb7", 0b00010101, IILane7>;

// Lane 8
def LDW8       : LoadInstrSpm<"ldw8", 0b00010000, IILane8>;
def STW8       : StoreInstrSpm<"stw8", 0b00010101, IILane8>;
def LDH8       : LoadInstrSpm<"ldh8", 0b00010000, IILane8>;
def LDHU8      : LoadInstrSpm<"ldhu8", 0b00010000, IILane8>;
def STH8       : StoreInstrSpm<"sth8", 0b00010101, IILane8>;
def LDB8       : LoadInstrSpm<"ldb8", 0b00010000, IILane8>;
def LDBU8      : LoadInstrSpm<"ldbu8", 0b00010000, IILane8>;
def STB8       : StoreInstrSpm<"stb8", 0b00010101, IILane8>;

// Lane 9
def LDW9       : LoadInstrSpm<"ldw9", 0b00010000, IILane9>;
def STW9       : StoreInstrSpm<"stw9", 0b00010101, IILane9>;
def LDH9       : LoadInstrSpm<"ldh9", 0b00010000, IILane9>;
def LDHU9      : LoadInstrSpm<"ldhu9", 0b00010000, IILane9>;
def STH9       : StoreInstrSpm<"sth9", 0b00010101, IILane9>;
def LDB9       : LoadInstrSpm<"ldb9", 0b00010000, IILane9>;
def LDBU9      : LoadInstrSpm<"ldbu9", 0b00010000, IILane9>;
def STB9       : StoreInstrSpm<"stb9", 0b00010101, IILane9>;

// Lane 10
def LDW10       : LoadInstrSpm<"ldw10", 0b00010000, IILane10>;
def STW10       : StoreInstrSpm<"stw10", 0b00010101, IILane10>;
def LDH10       : LoadInstrSpm<"ldh10", 0b00010000, IILane10>;
def LDHU10      : LoadInstrSpm<"ldhu10", 0b00010000, IILane10>;
def STH10       : StoreInstrSpm<"sth10", 0b00010101, IILane10>;
def LDB10       : LoadInstrSpm<"ldb10", 0b00010000, IILane10>;
def LDBU10      : LoadInstrSpm<"ldbu10", 0b00010000, IILane10>;
def STB10       : StoreInstrSpm<"stb10", 0b00010101, IILane10>;

// Lane 11
def LDW11       : LoadInstrSpm<"ldw11", 0b00010000, IILane11>;
def STW11       : StoreInstrSpm<"stw11", 0b00010101, IILane11>;
def LDH11       : LoadInstrSpm<"ldh11", 0b00010000, IILane11>;
def LDHU11      : LoadInstrSpm<"ldhu11", 0b00010000, IILane11>;
def STH11       : StoreInstrSpm<"sth11", 0b00010101, IILane11>;
def LDB11       : LoadInstrSpm<"ldb11", 0b00010000, IILane11>;
def LDBU11      : LoadInstrSpm<"ldbu11", 0b00010000, IILane11>;
def STB11       : StoreInstrSpm<"stb11", 0b00010101, IILane11>;

// Lane 12
def LDW12       : LoadInstrSpm<"ldw12", 0b00010000, IILane12>;
def STW12       : StoreInstrSpm<"stw12", 0b00010101, IILane12>;
def LDH12       : LoadInstrSpm<"ldh12", 0b00010000, IILane12>;
def LDHU12      : LoadInstrSpm<"ldhu12", 0b00010000, IILane12>;
def STH12       : StoreInstrSpm<"sth12", 0b00010101, IILane12>;
def LDB12       : LoadInstrSpm<"ldb12", 0b00010000, IILane12>;
def LDBU12      : LoadInstrSpm<"ldbu12", 0b00010000, IILane12>;
def STB12       : StoreInstrSpm<"stb12", 0b00010101, IILane12>;

// Lane 13
def LDW13       : LoadInstrSpm<"ldw13", 0b00010000, IILane13>;
def STW13       : StoreInstrSpm<"stw13", 0b00010101, IILane13>;
def LDH13       : LoadInstrSpm<"ldh13", 0b00010000, IILane13>;
def LDHU13      : LoadInstrSpm<"ldhu13", 0b00010000, IILane13>;
def STH13       : StoreInstrSpm<"sth13", 0b00010101, IILane13>;
def LDB13       : LoadInstrSpm<"ldb13", 0b00010000, IILane13>;
def LDBU13      : LoadInstrSpm<"ldbu13", 0b00010000, IILane13>;
def STB13       : StoreInstrSpm<"stb13", 0b00010101, IILane13>;

// Lane 14
def LDW14       : LoadInstrSpm<"ldw14", 0b00010000, IILane14>;
def STW14       : StoreInstrSpm<"stw14", 0b00010101, IILane14>;
def LDH14       : LoadInstrSpm<"ldh14", 0b00010000, IILane14>;
def LDHU14      : LoadInstrSpm<"ldhu14", 0b00010000, IILane14>;
def STH14       : StoreInstrSpm<"sth14", 0b00010101, IILane14>;
def LDB14       : LoadInstrSpm<"ldb14", 0b00010000, IILane14>;
def LDBU14      : LoadInstrSpm<"ldbu14", 0b00010000, IILane14>;
def STB14       : StoreInstrSpm<"stb14", 0b00010101, IILane14>;

// Lane 15
def LDW15       : LoadInstrSpm<"ldw15", 0b00010000, IILane15>;
def STW15       : StoreInstrSpm<"stw15", 0b00010101, IILane15>;
def LDH15       : LoadInstrSpm<"ldh15", 0b00010000, IILane15>;
def LDHU15      : LoadInstrSpm<"ldhu15", 0b00010000, IILane15>;
def STH15       : StoreInstrSpm<"sth15", 0b00010101, IILane15>;
def LDB15       : LoadInstrSpm<"ldb15", 0b00010000, IILane15>;
def LDBU15      : LoadInstrSpm<"ldbu15", 0b00010000, IILane15>;
def STB15       : StoreInstrSpm<"stb15", 0b00010101, IILane15>;

//===----------------------------------------------------------------------===//
//                      Return/Call instructions
//===----------------------------------------------------------------------===//

def RET       : ReturnInstr<"return", 0b00100110, IIBranch>;

//===----------------------------------------------------------------------===//
//                      Branch and Call instructions
//===----------------------------------------------------------------------===//

defm B        : BranchInstr<"br", "brf", 0b00000000, brcond, IIBranch>;

def GOTO      : JumpInstr<"goto", 0b00000000, br, IIBranch>;

let isCall = 1, Defs = [Lr] in {
def CALL      : InstVEX<(outs), (ins i32imm:$offset),
                        "call $$l0.0 = $offset",
                        [(VEXPseudoCall imm:$offset)], IIBranch>;
}

let isCall = 1, Defs = [Lr] in {
    def ICALL      : InstVEX<(outs), (ins i32imm:$offset),
    "icall $$l0.0 = $offset",
    [(VEXPseudoCall imm:$offset)], IIBranch>;
}

//===----------------------------------------------------------------------===//
//                       Non-Instruction Patterns
//===----------------------------------------------------------------------===//

//def : Pat<(mul GPRegs:$lhs, GPRegs:$rhs), (ADDr (MPYLUr $lhs, $rhs), (MPYHSr $lhs, $rhs))>;
//def : Pat<(mul GPRegs:$lhs, GPRegs:$rhs), (ADDr (MPYLUi $lhs, $rhs), (MPYHSi $lhs, $rhs))>;

def : Pat<(select GPRegs:$cond, GPRegs:$s1, GPRegs:$s2),
            (SLCTr (MTB GPRegs:$cond), GPRegs:$s1, GPRegs:$s2)>;
def : Pat<(select GPRegs:$cond, GPRegs:$s1, imm32:$s2),
            (SLCTi (MTB GPRegs:$cond), GPRegs:$s1, imm32:$s2)>;

//def : Pat<(select GPRegs:$cond, GPRegs:$s1, imm32:$s2),
//         (SLCTFr (not (MTB GPRegs:$cond)), GPRegs:$s1, imm32:$s2)>;
//def : Pat<(select GPRegs:$cond, GPRegs:$s1, imm32:$s2),
//          (SLCTFi (not (MTB GPRegs:$cond)), GPRegs:$s1, imm32:$s2)>;

// 1-to-32-bit extension
def : Pat<(i32 (anyext (i1 BrRegs:$src))), (MFB BrRegs:$src)>;
def : Pat<(i32 (zext (i1 BrRegs:$src))), (MFB BrRegs:$src)>;
def : Pat<(i32 (sext (i1 BrRegs:$src))), (MFB BrRegs:$src)>;

// Shift and add Instructions
def : Pat<(add (shl GPRegs:$lhs, (i32 1)), GPRegs:$rhs), (SH1ADDr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 2)), GPRegs:$rhs), (SH2ADDr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 3)), GPRegs:$rhs), (SH3ADDr GPRegs:$lhs, GPRegs:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 4)), GPRegs:$rhs), (SH4ADDr GPRegs:$lhs, GPRegs:$rhs)>;

def : Pat<(add (shl GPRegs:$lhs, (i32 1)), i32:$rhs), (SH1ADDi GPRegs:$lhs, i32:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 2)), i32:$rhs), (SH2ADDi GPRegs:$lhs, i32:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 3)), i32:$rhs), (SH3ADDi GPRegs:$lhs, i32:$rhs)>;
def : Pat<(add (shl GPRegs:$lhs, (i32 4)), i32:$rhs), (SH4ADDi GPRegs:$lhs, i32:$rhs)>;

// truncs
def : Pat<(i32 (extloadi1 ADDR:$addr)), (LDBU ADDR:$addr)>;
def : Pat<(i32 (extloadi8 ADDR:$addr)), (LDBU ADDR:$addr)>;
def : Pat<(i32 (extloadi16 ADDR:$addr)), (LDHU ADDR:$addr)>;

def : Pat<(i32 (zextloadi1 ADDR:$addr)), (LDBU ADDR:$addr)>;
def : Pat<(i32 (zextloadi8 ADDR:$addr)), (LDBU ADDR:$addr)>;
def : Pat<(i32 (zextloadi16 ADDR:$addr)), (LDHU ADDR:$addr)>;

def : Pat<(i32 (sextloadi1 ADDR:$addr)), (LDB ADDR:$addr)>;
def : Pat<(i32 (sextloadi8 ADDR:$addr)), (LDB ADDR:$addr)>;
def : Pat<(i32 (sextloadi16 ADDR:$addr)), (LDH ADDR:$addr)>;

def : Pat<(i32 (VEXWrapper tglobaladdr:$dst)), (MOVi tglobaladdr:$dst)>;
def : Pat<(i32 (VEXWrapper texternalsym:$dst)), (MOVi texternalsym:$dst)>;
def : Pat<(i32 (VEXWrapper externalsym:$dst)), (MOVi texternalsym:$dst)>;
def : Pat<(i32 (VEXWrapper tblockaddress:$dst)), (MOVi tblockaddress:$dst)>;

def : Pat<(i1 (trunc GPRegs:$src)), (MTB GPRegs:$src)>;

//def : Pat<(zext BrRegs:$node), (MFB BrRegs:$node)>;

//def : Pat<(i32 (zext i8:$node)), (MOVi GPRegs:$node)>;

def : Pat<(brcond i32:$cond, bb:$offset), (BR (MTB i32:$cond), bb:$offset)>;

// Calls
def : Pat<(VEXPseudoCall (VEXWrapper tglobaladdr:$dst)),
            (CALL tglobaladdr:$dst)>;

def : Pat<(VEXPseudoCall (i32 tglobaladdr:$dst)),
          (CALL tglobaladdr:$dst)>;

def : Pat<(VEXPseudoCall (i32 texternalsym:$dst)),
          (CALL texternalsym:$dst)>;

def : Pat<(VEXPseudoCall (VEXWrapper texternalsym:$dst)),
            (CALL texternalsym:$dst)>;

def : Pat<(VEXPseudoCall Lr),
            (CALL Lr)>;

// TODO: Is this correct?
// Tail Call

def : Pat<(VEXPseudoTailCall (VEXWrapper tglobaladdr:$dst)),
            (PSEUDO_TCALL tglobaladdr:$dst)>;

def : Pat<(VEXPseudoTailCall (i32 tglobaladdr:$dst)),
            (PSEUDO_TCALL tglobaladdr:$dst)>;

def : Pat<(VEXPseudoTailCall (VEXWrapper tglobaladdr:$dst)),
            (PSEUDO_TCALL tglobaladdr:$dst)>;

def : Pat<(VEXPseudoTailCall (VEXWrapper texternalsym:$dst)),
            (PSEUDO_TCALL texternalsym:$dst)>;

//include "VEXInstrVIS.td"
//include "VEXInstrAliases.td"
