//===-- VEXRegisterInfo.cpp - VEX Register Information -== --------------===//
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

#include "VEXRegisterInfo.h"

#include "VEX.h"
#include "VEXSubtarget.h"
#include "VEXMachineFunctionInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"


#define DEBUG_TYPE "vex-register"

#define GET_REGINFO_TARGET_DESC
#include "VEXGenRegisterInfo.inc"

using namespace llvm;

cl::opt<bool> is32Reg("is32Reg",
                            cl::Hidden, cl::desc("Enable 32 Registers instead of 64"));

VEXRegisterInfo::VEXRegisterInfo(const VEXSubtarget &ST)
    : VEXGenRegisterInfo(VEX::Lr), Subtarget(ST) {
        DEBUG(errs() << "Register Info\n");
}

//===----------------------------------------------------------------------===//
// Callee Saved Registers methods
//===----------------------------------------------------------------------===//
// VEX Callee Saved Registers
// In VEXCallConv.td
// def CSR: CalleeSavedRegs<(add Lr, (sequece "Reg%u", 57, 6))>
// llc create CSR_SaveList and CSR_RegMask from above defined.
const uint16_t* VEXRegisterInfo::
getCalleeSavedRegs(const MachineFunction *MF) const{
    if (is32Reg) {
        static const MCPhysReg CSR_List[] = { VEX::Reg25, VEX::Reg26, VEX::Reg27, VEX::Reg28, VEX::Reg29, VEX::Reg30, VEX::Reg31, VEX::Lr, 0 };
        return CSR_List;
    }
    return CSR_SaveList;
}

const uint32_t*
VEXRegisterInfo::getCallPreservedMask(CallingConv::ID) const {
    return CSR_RegMask;
}

const TargetRegisterClass *VEXRegisterInfo::getPointerRegClass(const MachineFunction &MF,
                                              unsigned Kind) const {
    return &VEX::GPRegsRegClass;
}

// pure virtual method
// @getReserved Regs
BitVector VEXRegisterInfo::
getReservedRegs(const MachineFunction &MF) const {
// @getReservedRegs body
    // FIXME : Verify if this is correct
//    static const uint16_t ReservedVEXRegs[] = {
//        VEX::Reg0, VEX::Lr, VEX::Reg1, VEX::Reg2, VEX::Reg3,
//        VEX::Reg4, VEX::Reg5, VEX::Reg6, VEX::Reg7, VEX::Reg8,
//        VEX::Reg9, VEX::Reg10
//    };
    // We don't need to reserve registers Reg3 to Reg10. We can still use them.
    std::vector<uint16_t> ReservedVEXRegs = {
            VEX::Reg0, VEX::Lr, VEX::Reg1
    };
    
    if (is32Reg) {
        for (unsigned i = VEX::Reg32; i < VEX::NUM_TARGET_REGS; ++i)
            ReservedVEXRegs.push_back(i);
    }

    BitVector Reserved(getNumRegs());
    typedef TargetRegisterClass::iterator RegIter;

    for(unsigned I = 0; I < ReservedVEXRegs.size(); ++I)
        Reserved.set(ReservedVEXRegs[I]);

    return Reserved;
}

//@EliminateFrameIndex
// - If no EliminateFrameIndex(), it will hang on run.
// pure virtual method
// FrameIndex represent objects inside an abstract stack.
// We must replace FrameIndex with an stack/frame pointer.
// direct reference.
void VEXRegisterInfo::
eliminateFrameIndex(MachineBasicBlock::iterator II, int SPAdj,
                    unsigned FIOperandNum, RegScavenger *RS) const {

    assert(SPAdj == 0 && "Unexpected");

    MachineInstr &MI = *II;
    MachineBasicBlock &MBB = *MI.getParent();
    MachineFunction &MF = *MBB.getParent();
    const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();
    DebugLoc dl = MI.getDebugLoc();

    int FrameIndex = MI.getOperand(FIOperandNum).getIndex();

    unsigned BasePtr = VEX::Reg1;
    
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

    if(MI.getOpcode() == VEX::ADDi){
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
            BuildMI(MBB, std::next(II), dl, TII.get(VEX::SUBi), DstReg)
                    .addReg(DstReg).addImm(-Offset);
        else
            BuildMI(MBB, std::next(II), dl, TII.get(VEX::ADDi), DstReg)
                    .addReg(DstReg).addImm(Offset);
        return;
    }
    MI.getOperand(FIOperandNum).ChangeToRegister(BasePtr, false);
    MI.getOperand(FIOperandNum + 1).ChangeToImmediate(Offset);
}

// pure virtual method
unsigned VEXRegisterInfo::
getFrameRegister(const MachineFunction &MF) const{
    const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();

    // FIXME : Is there a frame pointer register?
    //return TFI->hasFP(MF) ? (VEX::Reg1) : (VEX::Reg1);
    return VEX::Reg1;
}


// We only need to change the allocation order and
// call the target-independent getRegAllocationHints function
void VEXRegisterInfo::
    getRegAllocationHints(unsigned VirtReg,
                           ArrayRef<MCPhysReg> Order,
                           SmallVectorImpl<MCPhysReg> &Hints,
                           const MachineFunction &MF,
                           const VirtRegMap *VRM) const {
    
//    Order.
    TargetRegisterInfo::getRegAllocationHints(VirtReg, Order, Hints, MF, VRM);
        
    
}

