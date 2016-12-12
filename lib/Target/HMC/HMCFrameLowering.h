//===-- HMCFrameLowering.h - Define frame lowering for Cpu0 ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//
//===----------------------------------------------------------------------===//

#ifndef HMC_FRAMEINFO_H
#define HMC_FRAMEINFO_H

#include "HMC.h"

#include "llvm/Target/TargetFrameLowering.h"

namespace llvm {

class HMCSubtarget;

class HMCFrameLowering : public TargetFrameLowering {
    
    unsigned ScratchArea;

protected:

public:
    explicit HMCFrameLowering()
    :   ScratchArea(16), TargetFrameLowering(StackGrowsDown, 32, 0, 32)     // Is it 32?
    {
    }
    
    // This method returns the number of bytes that is reserved for the Scratch Area.
    // A 16-byte region provided as scratch storage for procedures called by the current procedure
    // so that each procedure may use the 16 bytes at the top of this own frame as scratch memory.
    unsigned getScratchArea() const { return ScratchArea; }
 
    /// emitProlog/emitEpilog - These methods insert prolog and epilog code into
    /// the function.
    void emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB) const override;
    void emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB) const override;
    
    void eliminateCallFramePseudoInstr(MachineFunction &MF,
                                       MachineBasicBlock &MBB,
                                       MachineBasicBlock::iterator I) const override;
    
    bool spillCalleeSavedRegisters(MachineBasicBlock &MBB,
                                   MachineBasicBlock::iterator MI,
                                   const std::vector<CalleeSavedInfo> &CSI,
                                   const TargetRegisterInfo *TRI) const override;
    bool restoreCalleeSavedRegisters(MachineBasicBlock &MBB,
                                     MachineBasicBlock::iterator MI,
                                     const std::vector<CalleeSavedInfo> &CSI,
                                     const TargetRegisterInfo *TRI) const override;
    
    /// targetHandlesStackFrameRounding - Returns true if the target is
    /// responsible for rounding up the stack frame (probably at emitPrologue
    /// time).
    bool targetHandlesStackFrameRounding() const override { return true; }
    
    bool hasFP(const MachineFunction &MF) const override;
    bool hasReservedCallFrame(const MachineFunction &MF) const override;
    
    int getFrameIndexOffset(const MachineFunction &MF,
                                              int FI) const override;

};
    
} // End llvm namespace

#endif
