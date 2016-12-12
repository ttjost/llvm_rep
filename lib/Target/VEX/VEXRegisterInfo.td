//===----------------------------------------------------------------------===//
//  Declarations that describe the VEX register file
//===----------------------------------------------------------------------===//


class VEXReg<bits<16> Enc, string n> : Register<n> {
  let HWEncoding = Enc;
  let Namespace = "VEX";
}

// Defining class for Registers

// Registers are identified with 5-bit ID numbers.
// Gr - 32-bit integer general purpose registers
class VexGPR<bits<16> Enc, string n> : VEXReg<Enc, n>;

// Br - 32-bit branch registers
class Br<bits<16> Enc, string n> : VEXReg<Enc, n>;

// Class for Link Register
class Lr<bits<16> Enc, string n> : VEXReg<Enc, n>;

// Defining General Purpose registers
// TODO: Make parametrizable
// TODO: General purpose Registers
foreach I = 0-63 in
  def Reg#I : VexGPR<I, "r0."#I>, DwarfRegNum<[I]>;

// Branch Registers
foreach I = 0-7 in
  def BrReg#I : Br<I, "b0."#I >, DwarfRegNum<[!add(I, 65)]>;
//  def BrReg#I : Br<I, "b0."#I >, DwarfRegNum<[I]>;
  
// Define Link Register
//def Lr    :  VexGPR<64, "l0.0">, DwarfRegNum<[64]>;
def Lr    :  Lr<0, "l0.0">, DwarfRegNum<[64]>;

//
// FIXME: the register order should be defined in terms of the preferred
// allocation order...
//
// This register class should not be used to hold i64 values, use the I64Regs
// register class for that. The i64 type is included here to allow i64 patterns
// using the integer instructions.
//def GPRegs : RegisterClass<"VEX", [i32], 32, (add Lr, (sequence "Reg%u", 0, 63))> {
//
//    let AltOrders = [(add GPRegs),(rotl GPRegs, 32)];
//    let AltOrderSelect = [{
//        return MF.getSubtarget<VEXSubtarget>().RotateRegisterOrder();
//  }];
//}

def GPRegs : RegisterClass<"VEX", [i32], 32, (add Lr, (sequence "Reg%u", 0, 63))>;

// We need to set Size to 32. Otherwise, LLVM will set to 0 causing problems
// with in Register Allocation Pass.
def BrRegs  : RegisterClass<"VEX", [i1], 32, (sequence "BrReg%u", 0, 7)> {
    let Size = 32;
}

def LrReg   : RegisterClass<"VEX", [i32], 32, (add Lr)> {
 //   let isAllocatable = 0;
}
