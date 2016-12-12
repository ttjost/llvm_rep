//===-- HMCFrameLowering.cpp - HMC Frame Information --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the HMC implementation of TargetFrameLowering class.
//
//===----------------------------------------------------------------------===//

#include "HMCFrameLowering.h"

#include "HMCInstrInfo.h"
#include "HMCMachineFunctionInfo.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Target/TargetOptions.h"

#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

#define DEBUG_TYPE "HMC-framelower"

// ---------------------------------------------------------------------------
//                                  FIXME
// ---------------------------------------------------------------------------
//  Verify this part to describe with precision how Prologue, Epilogue
//  and CALL should be implemented. Fix this in order to describe HMC properly.

// - emitPrologue() and emitEpilogue() must exist for main().

//===----------------------------------------------------------------------===//
//
// Stack Frame Processing methods
// +----------------------------+
//
// The Stack is allocated decrementing the stack pointer on
// the first instruction of a function prologue. Once decremented,
// all stack references are done thought a positive offset
// from the stack/frame pointer, so the stack is considering
// to grow up! Otherwise terrible hacks would have to be made
// to get this stack ABI compliant :)
//
// The stack frame required by the ABI (after call):
// Offset
//
// 0            -----------
// 4            Args to pass
// .            saved $reg (some register)
// .            Alloca allocations
// .            Local Area
// .            CPU "Callee Saved" Registers
// .            saved FP
// .            saved RA
// StackSize    -----------
//
// Offset  - offset from sp after stack allocation on function prologue
//
// The sp is the stack pointer subtracted/added from the stack size
// at the Prologue/Epilogue
//
// References to the precious stack (to obtain arguments) are done
// with offsets that exceeds the stack size: (stacksize+(4*(num_arg - 1)))
//
// Examples:
// - reference to the actual stack frame
//   for any local area var there is something like : FI >= 0, StackOffset : 4
//      stw REGX, 4(SP)
//
// - reference to previous stack frame
//   suppose there's a load to the 5th arguments : FI < 0, StackOffset: 16.
//      The emitted instruction will be something like:
//          ldw REGX, 16+StackSize(SP)
//
// Since the total stack size is unknown on LowerFormalArguments, all
// stack references (ObjectOffset) created to reference the function
// arguments, are negative numbers. This way, on eliminateFrameIndex it's
// possible to detect those references and the offsets are adjusted to
// their real location.
//
//===----------------------------------------------------------------------===//

//- Must have, hasFP() is pure virtual of parent
//  hasFP - Return true if the specified function should have a dedicated frame
//  pointer register. This is true if the function has variable sized allocas or
//  if frame pointer elimination is disabled.

bool HMCFrameLowering::hasReservedCallFrame(const MachineFunction &MF) const {
    return !MF.getFrameInfo()->hasVarSizedObjects();
}

/// getFrameIndexOffset - Returns the displacement from the frame register to
/// the stack frame of the specified index. This is the default implementation
/// which is overridden for some targets.
int HMCFrameLowering::getFrameIndexOffset(const MachineFunction &MF,
                                             int FI) const {
    const MachineFrameInfo *MFI = MF.getFrameInfo();
    // We only need to Reserve the Scratch Area when we use the Stack.
    // Otherwise, wrong offset might be generated in function that
    // uses more than 8 parameters (i. e. from the Caller's Stack).
    //unsigned ScratchArea = MFI->getStackSize() == 0 ? 0 : getScratchArea();
    unsigned ObjectOffset = MFI->getObjectOffset(FI);
    return MFI->getObjectOffset(FI) +  MFI->getStackSize() -
    getOffsetOfLocalArea() + MFI->getOffsetAdjustment() /*+ ScratchArea*/;
}

void HMCFrameLowering::emitPrologue(MachineFunction &MF,
                                    MachineBasicBlock &MBB) const {
    DEBUG(errs() << "EmitPrologue\n");

    assert(&MF.front() == &MBB && "Shrink-wrapping not yet supported");
    
    MachineBasicBlock::iterator MBBI = MBB.begin();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    HMCFunctionInfo *HMCFI = MF.getInfo<HMCFunctionInfo>();

    const HMCInstrInfo &TII = *static_cast<const HMCInstrInfo *>(MF.getSubtarget().getInstrInfo());
    const HMCRegisterInfo *RegInfo = static_cast<const HMCRegisterInfo *>(MF.getSubtarget().getRegisterInfo());
    
    DebugLoc DL = MBBI != MBB.end() ? MBBI->getDebugLoc() : DebugLoc();
    
    // Get the number of bytes to allocate from the FrameInfo.
    uint64_t StackSize = MFI->getStackSize();
    
    // No need to allocate space on the stack
    if (StackSize == 0 && !MFI->adjustsStack() && !MFI->hasCalls() && !HMCFI->isVarArgFunction()) return;
    
    DEBUG(errs() << "StackSize is not 0: " << StackSize << "   " << MF.getName() << "\n");

    uint64_t NumBytes = 0;
    
    MachineModuleInfo &MMI = MF.getMMI();
    const MCRegisterInfo *MRI = MMI.getContext().getRegisterInfo();
    
    // "Calculate" Stack Size. Note that the correct value of the stack
    // is not really this one. We should always RoundUpToAlignment in 32 bytes.
    // We do this because Variadic Functions should place registers in stack
    // in a way that 16 bytes are its on stack and the rest is on the ScratchPad
    // of the Caller.
    // IMPORTANT: Do not forget that we should always align to 32 bytes.
    StackSize = RoundUpToAlignment(StackSize + getScratchArea(), 32);
    if (HMCFI->isVarArgFunction())
        StackSize -= 12;
    MFI->setStackSize(StackSize);
    
    TII.adjustStackPtr(HMCFI, HMC::Reg1, -RoundUpToAlignment(StackSize, 32), MBB, MBBI);
    
    const std::vector<CalleeSavedInfo> &CSI = MFI->getCalleeSavedInfo();
    
    // emit ".cfi_def_cfa_offset StackSize"
    // Is that really necessary???
    unsigned CFIIndex = MMI.addFrameInst(MCCFIInstruction::createDefCfaOffset(nullptr, -StackSize));
    BuildMI(MBB, MBBI, DL, TII.get(TargetOpcode::CFI_INSTRUCTION)).addCFIIndex(CFIIndex);
    
    if(CSI.size()) {
        // Find the instruction past the last instruction that saves
        // a callee-saved register to the stack.
        for (unsigned i = 0; i < CSI.size(); ++i){
            ++MBBI;
            
            // Iterate over list of callee-saved registers and emit .cfi_offset directives
            for (std::vector<CalleeSavedInfo>::const_iterator I = CSI.begin(),
                 E = CSI.end(); I != E ; ++I){
                uint64_t Offset = MFI->getObjectOffset(I->getFrameIdx());
                unsigned Reg = I->getReg();
                unsigned DReg = MRI->getDwarfRegNum(Reg, true);
                // Reg is in HMCRegs
                unsigned CFIIndex = MMI.addFrameInst(
                        MCCFIInstruction::createOffset(nullptr, true, Offset));
                BuildMI(MBB, MBBI, DL, TII.get(TargetOpcode::CFI_INSTRUCTION))
                        .addCFIIndex(CFIIndex);
            }
        }
    }
    
//    if (hasFP(MF)){
//        // Calculated required stack adjustment
//        uint64_t FrameSize = StackSize - 2;
//        NumBytes = FrameSize - HMCFI

//    }
    
}

void HMCFrameLowering::emitEpilogue(MachineFunction &MF,
                                       MachineBasicBlock &MBB) const {
    DEBUG(errs() << "EmitEpilogue\n");
//    MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
//    
//    MachineFrameInfo *MFI = MF.getFrameInfo();
//    const HMCInstrInfo &TII = *static_cast<const HMCInstrInfo *>(MF.getSubtarget().getInstrInfo());
//    
//    DebugLoc dl = MBBI->getDebugLoc();
//    uint64_t StackSize = MFI->getStackSize();
//    
////    if(StackSize){
////        BuildMI(MBB, MBBI, dl, TII.get(HMC::RET)).addReg(HMC::Reg1).addReg(HMC::Reg1).addImm(MFI->getStackSize()).addReg(HMC::Lr);
////    }else{
////        BuildMI(MBB, MBBI, dl, TII.get(HMC::RET)).addReg(HMC::Reg1).addReg(HMC::Reg1).addImm(0).addReg(HMC::Lr);
////    }
////    MBB.erase(MBBI);
    
}

// FIXME: Can we eliminate these in favour of generic code?
bool
HMCFrameLowering::spillCalleeSavedRegisters(MachineBasicBlock &MBB,
                                               MachineBasicBlock::iterator MI,
                                               const std::vector<CalleeSavedInfo> &CSI,
                                               const TargetRegisterInfo *TRI) const {
    return false;
//    if (CSI.empty())
//        return true;

//    MachineFunction *MF = MBB.getParent();
//    MachineBasicBlock *EntryBlock = MF->begin();
//    const TargetInstrInfo *TII = MF->getSubtarget().getInstrInfo();

//    // Registers Lr and other called saved registers
//    // need to be saved with a STORE instruction during emitPrologue
//    for (unsigned i = 0, e = CSI.size(); i != e; ++i){
//        // Add the callee-saved register as live-in.
//        // TODO: Do I need to omit this procedure for Link Register?
//        unsigned Reg = CSI[i].getReg();
//        bool IsRAAndRetAddrIsTaken = Reg != HMC::Lr;

//        if(!IsRAAndRetAddrIsTaken){
//            EntryBlock->addLiveIn(Reg);
//            const TargetRegisterClass *RC = TRI->getMinimalPhysRegClass(Reg);
//            TII->storeRegToStackSlot(MBB, MI, Reg, true, CSI[i].getFrameIdx(), RC, TRI);
////            if (emitFrameMoves) {
////                auto Store = MI;
////                --Store;
////                XFI->getSpillLabels().push_back(std::make_pair(Store, *it));
////            }
//        }
//    }

//    return true;
}

bool
HMCFrameLowering::restoreCalleeSavedRegisters(MachineBasicBlock &MBB,
                                                 MachineBasicBlock::iterator MI,
                                                 const std::vector<CalleeSavedInfo> &CSI,
                                                 const TargetRegisterInfo *TRI) const {

    return false;

//    MachineFunction *MF = MBB.getParent();
//    const TargetInstrInfo &TII = *MF->getSubtarget().getInstrInfo();
//    bool AtStart = MI == MBB.begin();
//    MachineBasicBlock::iterator BeforeI = MI;

//    if (!AtStart)
//        --BeforeI;

//    for (unsigned i = 0, e = CSI.size(); i != e; ++i){
//        unsigned Reg = CSI[i].getReg();

//        assert(Reg != HMC::Lr && "Link register is always handled in emitEpilogue");

//        const TargetRegisterClass *RC = TRI->getMinimalPhysRegClass(Reg);
//        TII.loadRegFromStackSlot(MBB, MI, Reg, CSI[i].getFrameIdx(), RC, TRI);
//        assert(MI != MBB.begin() &&
//                "loadRegFromStackSlot did not insert any code!");
//        // Insert in reverse order. loadRegFromStackSlot can insert multiple
//        // instructions.
//        if (AtStart)
//            MI = MBB.begin();
//        else {
//            MI = BeforeI;
//            ++MI;
//        }
//    }
//    return true;
}

void HMCFrameLowering::
eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator I) const {
  MachineInstr &MI = *I;

  if (MI.getOpcode() == HMC::ADJCALLSTACKDOWN) {
    // TODO: add code
  } else if (MI.getOpcode() == HMC::ADJCALLSTACKUP) {
    // TODO: add code
  } else {
    llvm_unreachable("Cannot handle this call frame pseudo instruction");
  }
  MBB.erase(I);
}

//// This function is called immediately before the insertion of
//// Prolog and Epilog code. We need to explicitly tell the function
//// that Link Register needs to be saved for the function.
//// This only needs to happen when we have a call to another
//// function. If we don't we mark as unused and save an instruction
//// on being added.
//void
//HMCFrameLowering::processFunctionBeforeCalleeSavedScan
//                  (MachineFunction &MF, RegScavenger *RS) const {

//    MachineRegisterInfo &MRI = MF.getRegInfo();

//    // Needs to mark Link Register used only when
//    // the function calls another function
//    if (MF.getFrameInfo()->hasCalls())
//      MRI.setPhysRegUsed(HMC::Lr);
//    else {
//      MRI.setPhysRegUnused(HMC::Lr);
//    }
//}

bool HMCFrameLowering::hasFP(const MachineFunction &MF) const{
    return false;
//    const MachineFrameInfo *MFI = MF.getFrameInfo();
//    return MF.getTarget().Options.DisableFramePointerElim(MF) ||
//            MFI->hasVarSizedObjects() || MFI->isFrameAddressTaken();
}


