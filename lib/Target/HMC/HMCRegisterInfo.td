//===----------------------------------------------------------------------===//
//  Declarations that describe the HMC register file
//===----------------------------------------------------------------------===//


class HMCReg<bits<16> Enc, string n, list<Register> subregs = [] > : Register<n> {
  let HWEncoding = Enc;
  let Namespace = "HMC";
  let SubRegs = subregs;
}

let Namespace = "HMC" in {
    foreach I = 0-64 in
        def sub#I       : SubRegIndex<32, !shl(I,5)>;
}

// Defining class for Registers

// Registers are identified with 5-bit ID numbers.
// Gr - 32-bit integer general purpose registers
class HMCGPR<bits<16> Enc, string n> : HMCReg<Enc, n>;

// Br - 32-bit branch registers
class Br<bits<16> Enc, string n> : HMCReg<Enc, n>;

// Class for Link Register
class Lr<bits<16> Enc, string n> : HMCReg<Enc, n>;

// Defining General Purpose registers
// TODO: Make parametrizable
// TODO: General purpose Registers
foreach I = 0-2057 in
  def Reg#I : HMCGPR<I, "r0."#I>, DwarfRegNum<[I]>;

// Branch Registers
foreach I = 0-7 in
  def BrReg#I : Br<I, "b0."#I >, DwarfRegNum<[!add(I, 2058)]>;
  
// Define Link Register
def Lr    :  Lr<0, "l0.0">, DwarfRegNum<[2066]>;


def GPRegs : RegisterClass<"HMC", [i32], 32, (add Lr, (sequence "Reg%u", 0, 2057))>;

// We need to set Size to 32. Otherwise, LLVM will set to 0 causing problems
// with in Register Allocation Pass.
def BrRegs  : RegisterClass<"HMC", [i1], 32, (sequence "BrReg%u", 0, 7)> {
    let Size = 32;
}

def LrReg   : RegisterClass<"HMC", [i32], 32, (add Lr)> {
}


let SubRegIndices = [sub0, sub1, sub2, sub3], CoveredBySubRegs = 1 in {
    foreach I = 0-511 in
        def HMCReg128_#I : HMCReg<!shl(I,2), "HMCReg"#I, [!cast<Register>("Reg"#!add(!shl(I,2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,2), 1), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,2), 2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,2), 3), 10))]>;
}

let SubRegIndices = [sub0, sub1, sub2, sub3, sub4, sub5, sub6, sub7], CoveredBySubRegs = 1 in {
    foreach I = 0-255 in
    def HMCReg256_#I : HMCReg<!shl(I,3), "HMCReg"#I, [!cast<Register>("Reg"#!add(!shl(I,3), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 1), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 3), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 5), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 6), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,3), 7), 10))]>;
}

let SubRegIndices = [sub0, sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9, sub10, sub11, sub12, sub13, sub14, sub15], CoveredBySubRegs = 1 in {
    foreach I = 0-127 in
    def HMCReg512_#I : HMCReg<!shl(I,4), "HMCReg"#I, [!cast<Register>("Reg"#!add(!shl(I,4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 1), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 3), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 5), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 6), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 7), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 8), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 9), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 10), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 11), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 12), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 13), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 14), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 15), 10))]>;
}

//let SubRegIndices = [sub0, sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9, sub10, sub11, sub12, sub13, sub14, sub15,
//                    sub16, sub17, sub18, sub19, sub20, sub21, sub22, sub23, sub24, sub25, sub26, sub27, sub28, sub29, sub30, sub31], CoveredBySubRegs = 1 in {
//    foreach I = 0-63 in
//    def HMCReg1024_#I : HMCReg<!shl(I,4), "HMCReg"#I, [!cast<Register>("Reg"#!add(!shl(I,4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 1), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 3), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 5), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 6), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 7), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 8), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 9), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 10), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 11), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 12), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 13), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 14), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 15), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 16), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 17), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 18), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 19), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 20), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 21), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 22), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 23), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 24), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 25), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 26), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 27), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 28), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 29), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 30), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 31), 10))]>;
//}

//let SubRegIndices = [sub0, sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9, sub10, sub11, sub12, sub13, sub14, sub15], CoveredBySubRegs = 1 in {
//    foreach I = 0-31 in
//    def HMCReg2048_#I : HMCReg<!shl(I,4), "HMCReg"#I, [!cast<Register>("Reg"#!add(!shl(I,4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 1), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 2), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 3), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 4), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 5), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 6), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 7), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 8), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 9), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 10), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 11), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 12), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 13), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 14), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 15), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 16), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 17), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 18), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 19), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 20), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 21), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 22), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 23), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 24), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 25), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 26), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 27), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 28), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 29), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 30), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 31), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 32), 10)),!cast<Register>("Reg"#!add(!add(!shl(I,4), 33), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 2), 34)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 35), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 36), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 37), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 38), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 39), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 40), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 41), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 42), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 43), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 44), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 45), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 45), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 47), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 48), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 49), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 50), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 51), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 52), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 53), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 54), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 55), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 56), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 57), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 58), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 59), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 60), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 61), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 62), 10)), !cast<Register>("Reg"#!add(!add(!shl(I,4), 63), 10))]>;
//}

def HMCRegs128 : RegisterClass<"HMC", [v4i32], 128, (sequence "HMCReg128_%u", 0, 511)> {
}

def HMCRegs256 : RegisterClass<"HMC", [v8i32], 256, (sequence "HMCReg256_%u", 0, 255)> {
}

def HMCRegs512 : RegisterClass<"HMC", [v16i32], 512, (sequence "HMCReg512_%u", 0, 127)> {
}

//def HMCRegs1024 : RegisterClass<"HMC", [v32i32], 1024, (sequence "HMCReg1024_%u", 0, 63)> {
//}

//def HMCRegs2048 : RegisterClass<"HMC", [v64i32], 2048, (sequence "HMCReg2048_%u", 0, 31)> {
//}


