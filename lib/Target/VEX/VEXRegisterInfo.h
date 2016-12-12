//===-- VEXRegisterInfo.h - VEX Register Information Impl -----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VEX implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef VEXREGISTERINFO_H
#define VEXREGISTERINFO_H

#include "VEX.h"
#include "llvm/Target/TargetRegisterInfo.h"

#define GET_REGINFO_HEADER
#include "VEXGenRegisterInfo.inc"

namespace llvm{

class VEXSubtarget;
class TargetInstrInfo;
class Type;

class VEXRegisterInfo : public VEXGenRegisterInfo {
    
private:
    const VEXSubtarget &Subtarget;
    
public:
    VEXRegisterInfo(const VEXSubtarget &Subtarget);

    // getRegisterNumbering - Given the enum value for some register, e. g.
    // VEX:LrReg, return the number that it corresponds to (e. g. 14).
    static unsigned getRegisterNumbering(unsigned RegEnum);

    const uint16_t *getCalleeSavedRegs(const MachineFunction* MF = 0) const;
    const uint32_t *getCallPreservedMask(CallingConv::ID) const;

    BitVector getReservedRegs(const MachineFunction &MF) const;

    // stack Frame Processing methods
    void eliminateFrameIndex(MachineBasicBlock::iterator II,
                             int SPAdj, unsigned FIOperandNum,
                             RegScavenger *RS = nullptr) const;

    const TargetRegisterClass *getPointerRegClass(const MachineFunction &MF,
                                                  unsigned Kind) const;

    // Debug information queries
    unsigned getFrameRegister(const MachineFunction &MF) const;

    // Return GPR Register Class
    const TargetRegisterClass *intRegClass(unsigned Size);
    
    bool trackLivenessAfterRegAlloc(const MachineFunction &MF) const override {
        return true;
    }
    
    void getRegAllocationHints(unsigned VirtReg,
                               ArrayRef<MCPhysReg> Order,
                               SmallVectorImpl<MCPhysReg> &Hints,
                               const MachineFunction &MF,
                               const VirtRegMap *VRM) const override;

};

}


#endif
