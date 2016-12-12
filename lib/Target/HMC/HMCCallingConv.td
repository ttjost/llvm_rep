//===-- HMCCallingConv.td - Calling Conventions HMC ----*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the HMC architectures.
//
//===----------------------------------------------------------------------===/

def RetCC_HMC : CallingConv<[
    CCIfType<[i32], CCAssignToReg<[Reg3, Reg4]>>
]>;

def CC_HMC_Address : CallingConv<[
  // Handles byval parameters.
  CCIfByVal<CCPassByVal<4, 4>>,
  CCIfType<[i8, i16], CCPromoteToType<i32>>,
//  CCIfSRet<CCAssignToReg<[Reg2]>>,
  CCAssignToReg<[Reg3, Reg4, Reg5, Reg6, Reg7, Reg8, Reg9, Reg10]>,
  CCAssignToStack<4, 4>,

// Integer arguments are passed in integer registers.
CCIfType<[i64], CCAssignToRegWithShadow<[Reg3, Reg5, Reg7, Reg9],
                                        [Reg4, Reg6, Reg8, Reg10]>>
]>;

// It should also include LinkRegister which is represented by Reg64.
//def CSR: CalleeSavedRegs<(add Lr, (sequence "Reg%u", 57, 6))>;
def CSR: CalleeSavedRegs<(add Reg57, Reg58, Reg59, Reg60, Reg61, Reg62, Reg63, Lr)>;

