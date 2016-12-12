//===-- HMCInstrFormats.td - HMC Instruction Formats ---*- tablegen -*-===//

class InstHMC<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass itin = IIAlu>
          : Instruction {
  field bits<32> Inst;

  let Namespace = "HMC";
  let Size = 4;

  bits<8> op;
  let Inst{31-24} = op;               // Top two bits are the 'op' field

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;

  let Itinerary = itin;

  let DecoderNamespace = "HMC";
  field bits<32> SoftFail = 0;
}

// Pseudo instructions (don't have encoding information)
class Pseudo<dag outs, dag ins, list<dag> pattern, string asmstr = "">
: InstHMC<outs, ins, asmstr,  pattern> {
    let isCodeGenOnly  = 1;
    let isPseudo = 1;
}

//class BaseReturnReg<bits<8> OpVal, dag outs, dag ins, string asmstr, pattern>
//: HMCInst<outs, ins, asmstr, pattern


//===----------------------------------------------------------------------===//
// Format TYPE 1 instruction classes in the HMC
//===----------------------------------------------------------------------===//

// TYPE 1 instructions
// class ArithLogicInstr<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isCommR = 0, bit isCommI = 0>
//    : InstHMC<outs, ins, asmstr, pattern, Itin> {
//   bits<6>  s1;
//   
//   bits<6>  dst;
//   
//   let Inst{16-11} = s1;
//   let Inst{22-17} = dst;
// }

class ArithLogic_r<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isComm>
   : InstHMC<outs, ins, asmstr, pattern, Itin> {
  bits<8> op;
  bits<6>  s2;
  
  let op = OpVal;
  let Inst{10-5} = s2;
  
  let isCommutable = isComm;
  
}

class ArithLogic_i<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isComm>
   : InstHMC<outs, ins, asmstr, pattern, Itin> {
  bits<8>  op;
  bits<9>  imm;
  
  let op = OpVal;
  let Inst{10-2} = imm;
  
  let isCommutable = isComm;
}

// TYPE 1 instructions
// class MOVInstr<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin>
// : InstHMC<outs, ins, asmstr, pattern, Itin> {
//     bits<6>  s1;
//     
//     bits<6>  dst;
//     
//     let Inst{16-11} = s1;
//     let Inst{22-17} = dst;
// }

class MOV_r<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin>
: InstHMC<outs, ins, asmstr, pattern, Itin> {
    bits<8> op;
    bits<6>  s2;
    
    let op = OpVal;
    let Inst{10-5} = s2;
    
    let isCommutable = 0;
}

class MOV_i<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin>
: InstHMC<outs, ins, asmstr, pattern, Itin> {
    bits<8>  op;
    bits<9>  imm;
    
    let op = OpVal;
    let Inst{10-2} = imm;
    
    let isCommutable = 0;
}

// TYPE 1 instructions
// class SHIFTInstr<dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isCommR = 0, bit isCommI = 0>
// : InstHMC<outs, ins, asmstr, pattern, Itin> {
// bits<6>  s1;
// 
// bits<6>  dst;
// 
// let Inst{16-11} = s1;
// let Inst{22-17} = dst;
// }

class SHIFT_r<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isComm>
: InstHMC<outs, ins, asmstr, pattern, Itin> {
bits<8> op;
bits<6>  s2;

let op = OpVal;
let Inst{10-5} = s2;

let isCommutable = isComm;

}

class SHIFT_i<bits<8> OpVal, dag outs, dag ins, string asmstr, list<dag> pattern, InstrItinClass Itin, bit isComm>
: InstHMC<outs, ins, asmstr, pattern, Itin> {
bits<8>  op;
bits<9>  imm;

let op = OpVal;
let Inst{10-2} = imm;

let isCommutable = isComm;
}



