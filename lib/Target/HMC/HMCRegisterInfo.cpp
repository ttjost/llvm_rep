//===-- HMCRegisterInfo.cpp - HMC Register Information -== --------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the HMC implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#include "HMCRegisterInfo.h"

#include "HMC.h"
#include "HMCSubtarget.h"
#include "HMCMachineFunctionInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"


#define DEBUG_TYPE "HMC-register"

#define GET_REGINFO_TARGET_DESC
#include "HMCGenRegisterInfo.inc"

using namespace llvm;

HMCRegisterInfo::HMCRegisterInfo(const HMCSubtarget &ST)
    : HMCGenRegisterInfo(HMC::Lr), Subtarget(ST) {
        DEBUG(errs() << "Register Info\n");
}

//===----------------------------------------------------------------------===//
// Callee Saved Registers methods
//===----------------------------------------------------------------------===//
// HMC Callee Saved Registers
// In HMCCallConv.td
// def CSR: CalleeSavedRegs<(add Lr, (sequece "Reg%u", 57, 6))>
// llc create CSR_SaveList and CSR_RegMask from above defined.
const uint16_t* HMCRegisterInfo::
getCalleeSavedRegs(const MachineFunction *MF) const{
    return CSR_SaveList;
}

const uint32_t*
HMCRegisterInfo::getCallPreservedMask(CallingConv::ID) const {
    return CSR_RegMask;
}

const TargetRegisterClass *HMCRegisterInfo::getPointerRegClass(const MachineFunction &MF,
                                              unsigned Kind) const {
    return &HMC::GPRegsRegClass;
}

// pure virtual method
// @getReserved Regs
BitVector HMCRegisterInfo::
getReservedRegs(const MachineFunction &MF) const {
// @getReservedRegs body
    // FIXME : Verify if this is correct
//    static const uint16_t ReservedHMCRegs[] = {
//        HMC::Reg0, HMC::Lr, HMC::Reg1, HMC::Reg2, HMC::Reg3,
//        HMC::Reg4, HMC::Reg5, HMC::Reg6, HMC::Reg7, HMC::Reg8,
//        HMC::Reg9, HMC::Reg10
//    };
    // We don't need to reserve registers Reg3 to Reg10. We can still use them.
    std::vector<uint16_t> ReservedHMCRegs = {
            HMC::Reg0, HMC::Lr, HMC::Reg1
    };

    BitVector Reserved(getNumRegs());
    typedef TargetRegisterClass::iterator RegIter;

    for(unsigned I = 0; I < ReservedHMCRegs.size(); ++I)
        Reserved.set(ReservedHMCRegs[I]);

    return Reserved;
}

//@EliminateFrameIndex
// - If no EliminateFrameIndex(), it will hang on run.
// pure virtual method
// FrameIndex represent objects inside an abstract stack.
// We must replace FrameIndex with an stack/frame pointer.
// direct reference.
void HMCRegisterInfo::
eliminateFrameIndex(MachineBasicBlock::iterator II, int SPAdj,
                    unsigned FIOperandNum, RegScavenger *RS) const {

    assert(SPAdj == 0 && "Unexpected");

    MachineInstr &MI = *II;
    MachineBasicBlock &MBB = *MI.getParent();
    MachineFunction &MF = *MBB.getParent();
    const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();
    DebugLoc dl = MI.getDebugLoc();

    int FrameIndex = MI.getOperand(FIOperandNum).getIndex();

    unsigned BasePtr = HMC::Reg1;
    
    // We need to fix the offset by subtracting 12. Otherwise,
    // variadic functions get all messed up.
    int Offset = TFI->getFrameIndexOffset(MF, FrameIndex);
    //int Offset = MF.getFrameInfo()->getObjectOffset(FrameIndex);

    // Skip the saved PC
    //Offset += 4;

//    if(TFI->hasFP(MF))
//        Offset += MF.getFrameInfo()->getStackSize();
//    else
//        Offset += 4;

    // Fold imm into offset
    Offset += MI.getOperand(FIOperandNum + 1).getImm();

    if(MI.getOpcode() == HMC::ADDi){
        // This is actually "load effective address" of the stack slot
        // instruction. We have only two-address instructions, thus we need to
        // expand it into mov + add
        const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();

        //MI.setDesc(TII.get());
        if(Offset == 0)
            return;

        // we need to materialize the offset via add instruction
        unsigned DstReg = MI.getOperand(0).getReg();
        if(Offset < 0)
            BuildMI(MBB, std::next(II), dl, TII.get(HMC::SUBi), DstReg)
                    .addReg(DstReg).addImm(-Offset);
        else
            BuildMI(MBB, std::next(II), dl, TII.get(HMC::ADDi), DstReg)
                    .addReg(DstReg).addImm(Offset);
        return;
    }
    MI.getOperand(FIOperandNum).ChangeToRegister(BasePtr, false);
    MI.getOperand(FIOperandNum + 1).ChangeToImmediate(Offset);
}

// pure virtual method
unsigned HMCRegisterInfo::
getFrameRegister(const MachineFunction &MF) const{
    const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();

    // FIXME : Is there a frame pointer register?
    //return TFI->hasFP(MF) ? (HMC::Reg1) : (HMC::Reg1);
    return HMC::Reg1;
}


// We only need to change the allocation order and
// call the target-independent getRegAllocationHints function
void HMCRegisterInfo::
    getRegAllocationHints(unsigned VirtReg,
                           ArrayRef<MCPhysReg> Order,
                           SmallVectorImpl<MCPhysReg> &Hints,
                           const MachineFunction &MF,
                           const VirtRegMap *VRM) const {
    
//    Order.
    TargetRegisterInfo::getRegAllocationHints(VirtReg, Order, Hints, MF, VRM);
        
    
}

