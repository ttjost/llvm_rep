//===-- VEXInstrInfo.cpp - VEX Instruction Information ------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VEX implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#include "VEXInstrInfo.h"

#include "VEXTargetMachine.h"
#include "VEXMachineFunctionInfo.h"
#include "VEXFrameLowering.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"


#define DEBUG_TYPE "vex-instrinfo"
using namespace llvm;

#define GET_INSTRINFO_CTOR_DTOR
#include "VEXGenInstrInfo.inc"

#include "VEXGenDFAPacketizer.inc"
//#include "VEXSubtargetInfo.cpp"

cl::opt<bool> isHPSim("hp-sim",
                            cl::Hidden, cl::init(false), cl::desc("Compiling for HP Simulator"));

//@VEXInstrInfo(){
VEXInstrInfo::VEXInstrInfo(const VEXSubtarget &STI) : Subtarget(STI), RI(STI) {
    DEBUG(errs() << "InstrInfo \n");
}

// Emit instructions to copy a pair of physical registers.
void VEXInstrInfo::copyPhysReg(MachineBasicBlock &MBB,
                               MachineBasicBlock::iterator MI, DebugLoc DL,
                               unsigned DestReg, unsigned SrcReg,
                               bool KillSrc) const {

    unsigned Opc = 0;
    
    // GP Register is Destination
    if (VEX::GPRegsRegClass.contains(DestReg)){
        if(VEX::BrRegsRegClass.contains(SrcReg))
            Opc = VEX::MFB;
        else
            if(VEX::GPRegsRegClass.contains(SrcReg))
                Opc = VEX::MOVr;
            else
                Opc = VEX::MFL;
    } else
        if(VEX::BrRegsRegClass.contains(DestReg)){
            if (VEX::GPRegsRegClass.contains(SrcReg))
                Opc = VEX::MTB;
            else
                if(VEX::BrRegsRegClass.contains(SrcReg)) {
                    // I think this is a better solution.
                    MachineFunction *MF = MBB.getParent();
                    MachineRegisterInfo &MRI = MF->getRegInfo();
//                    unsigned Reg = MRI.createVirtualRegister(&VEX::GPRegsRegClass);
                    
                    // TODO: Is there a better way of doing this?
                    unsigned Reg = 0;
                    for (Reg = VEX::Reg11 ; Reg < VEX::Reg63; ++Reg) {
                        if (!MBB.isLiveIn(Reg))
                            break;
                    }
                    
                    if (!Reg)
                        llvm_unreachable("CopyPhysReg Method: There is no more Register Available.");
                    
                    BuildMI(MBB, MI, DL, get(VEX::MFB), Reg).addReg(SrcReg, getKillRegState(KillSrc));
                    BuildMI(MBB, MI, DL, get(VEX::MTB), DestReg).addReg(Reg);
                    return;
                } else
                        llvm_unreachable("Impossible to Copy from Link Register to Branch register.");
                
        } else {
            if(VEX::LrRegRegClass.contains(DestReg)) {
                if (VEX::GPRegsRegClass.contains(SrcReg))
                    Opc = VEX::MTL;
                else
                    llvm_unreachable("Impossible to Copy from Branch Register to Link register.");
            }
        }
//    BuildMI(MBB, MI, DL, get(Opc), DestReg).addReg(SrcReg, getKillRegState(KillSrc));
    BuildMI(MBB, MI, DL, get(Opc), DestReg).addReg(SrcReg);

}

bool VEXInstrInfo::expandPostRAPseudo(MachineBasicBlock::iterator MI) const {
    
    MachineBasicBlock &MBB = *MI->getParent();
    MachineFunction &MF = *MBB.getParent();
    DEBUG(errs() << "\n\n" << MI->getDesc().getOpcode() <<"\n\n");
    
    switch(MI->getDesc().getOpcode()) {
        default:
            return false;
        case VEX::PSEUDO_RET:
        {
            DEBUG(errs() << "\nReplacing PSEUDO_RET\n");
//            const VEXSubtarget* Subtarget = MF.getSubtarget<VEXSubtarget>();
//            const VEXFrameLowering* FrameLowering = Subtarget.getFrameLowering<VEXFrameLowering>();
//            int StackSize = MF.getFrameInfo()->getStackSize() == 0 ? 0 : RoundUpToAlignment(MF.getFrameInfo()->getStackSize() + 16, 32);
            int StackSize = MF.getFrameInfo()->getStackSize() == 0 ? 0 : RoundUpToAlignment(MF.getFrameInfo()->getStackSize(), 32);
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::RET)).addReg(VEX::Reg1).addReg(VEX::Reg1).addImm(StackSize).addReg(VEX::Lr);
            MBB.erase(MI);
            break;
        }
        case VEX::PSEUDO_TCALL:
        {
            DEBUG(errs() << "\nReplacing PSEUDO_TAILCALL\n");
            //            const VEXSubtarget* Subtarget = MF.getSubtarget<VEXSubtarget>();
            //            const VEXFrameLowering* FrameLowering = Subtarget.getFrameLowering<VEXFrameLowering>();
//            int StackSize = MF.getFrameInfo()->getStackSize() == 0 ? 0 : RoundUpToAlignment(MF.getFrameInfo()->getStackSize() + 16, 32);
            int StackSize = MF.getFrameInfo()->getStackSize() == 0 ? 0 : RoundUpToAlignment(MF.getFrameInfo()->getStackSize(), 32);
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::ADDi), VEX::Reg1).addReg(VEX::Reg1).addImm(StackSize);
            
            unsigned Opcode;
            if (isHPSim)
                Opcode = VEX::CALL;
            else
                Opcode = VEX::GOTO;

            BuildMI(MBB, MI, MI->getDebugLoc(), get(Opcode)).addOperand(MI->getOperand(0));
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::RET)).addReg(VEX::Reg1).addReg(VEX::Reg1).addImm(0).addReg(VEX::Lr);
            MBB.erase(MI);
            break;
        }
        case VEX::STWPseudo:
        {
            DEBUG(errs() << "\nReplacing STWPseudo with MFB and STW\n");
            MachineOperand DstReg = MI->getOperand(0);
            MachineOperand SrcReg = MI->getOperand(1);
            MachineOperand MemOperand = MI->getOperand(2);
            MachineOperand FrameIndex = MI->getOperand(3);
            assert(DstReg.isReg() && "Operand must be Register");
            assert(SrcReg.isReg() && "Operand must be Register");
            
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::MFB), DstReg.getReg()).addOperand(SrcReg);
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::STW))
                    .addOperand(DstReg)
                    .addOperand(MemOperand)
                    .addOperand(FrameIndex);
            MBB.erase(MI);
            break;
        }
        case VEX::LDWPseudo:
        {
            DEBUG(errs() << "\nReplacing LDWPseudo with MFB and STW\n");
            MachineOperand DstRegLast = MI->getOperand(0);
            MachineOperand DstRegFirst = MI->getOperand(1);
            MachineOperand FrameIndex = MI->getOperand(2);
            MachineOperand MemOperand = MI->getOperand(3);
            assert(DstRegLast.isReg() && "Operand must be Register");
            assert(DstRegFirst.isReg() && "Operand must be Register");
            
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::LDW), DstRegFirst.getReg())
                    .addOperand(FrameIndex)
                    .addOperand(MemOperand);
            DstRegFirst.setIsDef(false);
            BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::MTB), DstRegLast.getReg())
                    .addOperand(DstRegFirst);
            MBB.erase(MI);
            break;
        }
    }

    return true;
}

void VEXInstrInfo::loadRegFromStackSlot(MachineBasicBlock &MBB,
                                        MachineBasicBlock::iterator MI,
                                        unsigned DestReg, int FrameIndex,
                                        const TargetRegisterClass *RC,
                                        const TargetRegisterInfo *TRI) const {

    DebugLoc DL;

    if (MI != MBB.end()) DL = MI->getDebugLoc();

    MachineFunction &MF = *MBB.getParent();
    MachineFrameInfo &MFI = *MF.getFrameInfo();

    MachineMemOperand *MMO =
            MF.getMachineMemOperand(MachinePointerInfo::getFixedStack(FrameIndex),
                                    MachineMemOperand::MOLoad,
                                    MFI.getObjectSize(FrameIndex),
                                    MFI.getObjectAlignment(FrameIndex));

    // On the order of operands here: think [FrameIndex + 0] = SrcReg.
    if (RC == &VEX::GPRegsRegClass)
        BuildMI(MBB, MI, DL, get(VEX::LDW), DestReg)
                .addFrameIndex(FrameIndex).addImm(0)
                .addMemOperand(MMO);
    else
        // We cannot directly Spill/Fill with Branch Registers
        // First, we need to Load from Stack to a GPReg and then Move to Branch
        if (RC == &VEX::BrRegsRegClass) {
            MachineRegisterInfo &MRI = MF.getRegInfo();
            unsigned Reg = MRI.createVirtualRegister(&VEX::GPRegsRegClass);
            BuildMI(MBB, MI, DL, get(VEX::LDWPseudo), DestReg)
                    .addReg(Reg, RegState::Define)
                    .addFrameIndex(FrameIndex).addImm(0)
                    .addMemOperand(MMO);
            
        } else {
            if (RC == &VEX::LrRegRegClass) {
                BuildMI(MBB, MI, DL, get(VEX::LDWLr), DestReg)
                        .addFrameIndex(FrameIndex).addImm(0)
                        .addMemOperand(MMO);
            } else
                llvm_unreachable("Can't store this register to stack slot. Register Class Unknown.");
        }
}

void VEXInstrInfo::storeRegToStackSlot(MachineBasicBlock &MBB,
                         MachineBasicBlock::iterator MI,
                         unsigned SrcReg, bool isKill, int FrameIndex,
                         const TargetRegisterClass *RC,
                         const TargetRegisterInfo *TRI) const {

    DebugLoc DL;

    if (MI != MBB.end()) DL = MI->getDebugLoc();

    MachineFunction &MF = *MBB.getParent();
    MachineFrameInfo &MFI = *MF.getFrameInfo();

    MachineMemOperand *MMO =
            MF.getMachineMemOperand(MachinePointerInfo::getFixedStack(FrameIndex),
                                    MachineMemOperand::MOStore,
                                    MFI.getObjectSize(FrameIndex),
                                    MFI.getObjectAlignment(FrameIndex));

    // On the order of operands here: think [FrameIndex + 0] = SrcReg.
    if (RC == &VEX::GPRegsRegClass)
        BuildMI(MBB, MI, DL, get(VEX::STW))
                .addReg(SrcReg, getKillRegState(isKill))
                .addMemOperand(MMO)
                .addFrameIndex(FrameIndex).addImm(0);
    else
        // We cannot directly Spill/Fill with Branch Registers
        // First, we send to a Move From Branch and then Store in Stack
        if (RC == &VEX::BrRegsRegClass) {
            MachineRegisterInfo &MRI = MF.getRegInfo();
            unsigned DstReg = MRI.createVirtualRegister(&VEX::GPRegsRegClass);
            BuildMI(MBB, MI, DL, get(VEX::STWPseudo), DstReg)
                                .addReg(SrcReg, getKillRegState(isKill))
                                .addMemOperand(MMO)
                                .addFrameIndex(FrameIndex).addImm(0);
        } else {
            if (RC == &VEX::LrRegRegClass) {
                BuildMI(MBB, MI, DL, get(VEX::STWLr))
                        .addReg(SrcReg, getKillRegState(isKill))
                        .addMemOperand(MMO)
                        .addFrameIndex(FrameIndex).addImm(0);
            } else
                llvm_unreachable("Can't store this register to stack slot. Register Class Unknown.");
        }
}

void VEXInstrInfo::makeFrame(unsigned SP, int64_t FrameSize,
                             MachineBasicBlock &MBB,
                             MachineBasicBlock::iterator I) const {
    DebugLoc DL = I != MBB.end() ? I->getDebugLoc() : DebugLoc();
    MachineFunction &MF = *MBB.getParent();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    const BitVector Reserved = RI.getReservedRegs(MF);

}

void VEXInstrInfo::adjustStackPtr(VEXFunctionInfo *VEXFI, unsigned SP, uint64_t Amount,
                                  MachineBasicBlock &MBB, MachineBasicBlock::iterator I) const{
    
    
    DebugLoc DL = I != MBB.end() ? I->getDebugLoc() : DebugLoc();
    
    unsigned add = VEX::ADDi;
    
    // TODO : What happens when stacksize is greater than 16 bits? or even 8 bits?
    BuildMI(MBB, I, DL, get(add), SP).addReg(SP).addImm(Amount);
    
}

void VEXInstrInfo::insertNoop(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator MI) const {
    BuildMI(MBB, MI, MI->getDebugLoc(), get(VEX::NOP));
}

//===----------------------------------------------------------------------===//
// Branch Analysis
//===----------------------------------------------------------------------===//

static unsigned GetAnalyzableBrOpc(unsigned Opc) {
  return (Opc == VEX::BR || Opc == VEX::BRF || Opc == VEX::GOTO) ? Opc : 0;
}

/// GetOppositeBranchOpc - Return the inverse of the specified
/// opcode, e.g. turning BEQ to BNE.
static unsigned GetOppositeBranchOpc(unsigned Opc)
{
  switch (Opc) {
  default: llvm_unreachable("Illegal opcode!");
  case VEX::BR    : return VEX::BRF;
  case VEX::BRF    : return VEX::BR;
  }
}

static void AnalyzeCondBr(const MachineInstr* Inst, unsigned Opc,
                          MachineBasicBlock *&BB,
                          SmallVectorImpl<MachineOperand>& Cond) {
  assert(GetAnalyzableBrOpc(Opc) && "Not an analyzable branch");
  int NumOp = Inst->getNumExplicitOperands();

  // for both int and fp branches, the last explicit operand is the
  // MBB.
  BB = Inst->getOperand(NumOp-1).getMBB();
  Cond.push_back(MachineOperand::CreateImm(Opc));

  for (int i=0; i<NumOp-1; i++)
    Cond.push_back(Inst->getOperand(i));
}

bool VEXInstrInfo::AnalyzeBranch(MachineBasicBlock &MBB,
                                  MachineBasicBlock *&TBB,
                                  MachineBasicBlock *&FBB,
                                  SmallVectorImpl<MachineOperand> &Cond,
                                  bool AllowModify) const
{
  MachineBasicBlock::reverse_iterator I = MBB.rbegin(), REnd = MBB.rend();

  // Skip all the debug instructions.
  while (I != REnd && I->isDebugValue())
    ++I;

  if (I == REnd || !isUnpredicatedTerminator(&*I)) {
    // If this block ends with no branches (it just falls through to its succ)
    // just return false, leaving TBB/FBB null.
    TBB = FBB = NULL;
    return false;
  }

  MachineInstr *LastInst = &*I;
  unsigned LastOpc = LastInst->getOpcode();

  // Not an analyzable branch (must be an indirect jump).
  if (!GetAnalyzableBrOpc(LastOpc)) {
    return true;
  }

  // Get the second to last instruction in the block.
  unsigned SecondLastOpc = 0;
  MachineInstr *SecondLastInst = NULL;

  if (++I != REnd) {
    SecondLastInst = &*I;
    SecondLastOpc = GetAnalyzableBrOpc(SecondLastInst->getOpcode());

    // Not an analyzable branch (must be an indirect jump).
    if (isUnpredicatedTerminator(SecondLastInst) && !SecondLastOpc) {
      return true;
    }
  }

  // If there is only one terminator instruction, process it.
  if (!SecondLastOpc) {
    // Unconditional branch
    if (LastOpc == VEX::GOTO) {
      TBB = LastInst->getOperand(0).getMBB();
      // If the basic block is next, remove the GOTO inst
      if(MBB.isLayoutSuccessor(TBB)) {
        LastInst->eraseFromParent();
      }

      return false;
    }

    // Conditional branch
    AnalyzeCondBr(LastInst, LastOpc, TBB, Cond);
    return false;
  }

  // If we reached here, there are two branches.
  // If there are three terminators, we don't know what sort of block this is.
  if (++I != REnd && isUnpredicatedTerminator(&*I)) {
    return true;
  }

  // If second to last instruction is an unconditional branch,
  // analyze it and remove the last instruction.
  if (SecondLastOpc == VEX::GOTO) {
    // Return if the last instruction cannot be removed.
    if (!AllowModify) {
      return true;
    }

    TBB = SecondLastInst->getOperand(0).getMBB();
    LastInst->eraseFromParent();
    return false;
  }

  // Conditional branch followed by an unconditional branch.
  // The last one must be unconditional.
  if (LastOpc != VEX::GOTO) {
    return true;
  }

  AnalyzeCondBr(SecondLastInst, SecondLastOpc, TBB, Cond);
  FBB = LastInst->getOperand(0).getMBB();

  return false;
}

void VEXInstrInfo::BuildCondBr(MachineBasicBlock &MBB,
                                MachineBasicBlock *TBB, DebugLoc DL,
                                ArrayRef<MachineOperand> Cond)
  const {
  unsigned Opc = Cond[0].getImm();
  const MCInstrDesc &MCID = get(Opc);
  MachineInstrBuilder MIB = BuildMI(&MBB, DL, MCID);

  for (unsigned i = 1; i < Cond.size(); ++i)
    MIB.addReg(Cond[i].getReg());

  MIB.addMBB(TBB);
}

unsigned VEXInstrInfo::
InsertBranch(MachineBasicBlock &MBB, MachineBasicBlock *TBB,
                                MachineBasicBlock *FBB,
                                ArrayRef<MachineOperand> Cond,
                                DebugLoc DL) const {
  // Shouldn't be a fall through.
  assert(TBB && "InsertBranch must not be told to insert a fallthrough");

  // # of condition operands:
  //  Unconditional branches: 0
  //  Floating point branches: 1 (opc)
  //  Int BranchZero: 2 (opc, reg)
  //  Int Branch: 3 (opc, reg0, reg1)
  assert((Cond.size() <= 3) &&
         "# of VEX branch conditions must be <= 3!");

  // Two-way Conditional branch.
  if (FBB) {
    BuildCondBr(MBB, TBB, DL, Cond);
    BuildMI(&MBB, DL, get(VEX::GOTO)).addMBB(FBB);
    return 2;
  }

  // One way branch.
  // Unconditional branch.
  if (Cond.empty())
    BuildMI(&MBB, DL, get(VEX::GOTO)).addMBB(TBB);
  else // Conditional branch.
    BuildCondBr(MBB, TBB, DL, Cond);
  return 1;
}

unsigned VEXInstrInfo::
RemoveBranch(MachineBasicBlock &MBB) const
{
  MachineBasicBlock::reverse_iterator I = MBB.rbegin(), REnd = MBB.rend();
  MachineBasicBlock::reverse_iterator FirstBr;
  unsigned removed;

  // Skip all the debug instructions.
  while (I != REnd && I->isDebugValue())
    ++I;

  FirstBr = I;

  // Up to 2 branches are removed.
  // Note that indirect branches are not removed.
  for(removed = 0; I != REnd && removed < 2; ++I, ++removed)
    if (!GetAnalyzableBrOpc(I->getOpcode()))
      break;

  MBB.erase(I.base(), FirstBr.base());

  return removed;
}

/// ReverseBranchCondition - Return the inverse opcode of the
/// specified Branch instruction.
bool VEXInstrInfo::
ReverseBranchCondition(SmallVectorImpl<MachineOperand> &Cond) const
{
  assert( (Cond.size() && Cond.size() <= 3) &&
          "Invalid VEX branch condition!");
  Cond[0].setImm(GetOppositeBranchOpc(Cond[0].getImm()));
  return false;
}

bool VEXInstrInfo::isSchedulingBoundary(const MachineInstr *MI,
                                           const MachineBasicBlock *MBB,
                                           const MachineFunction &MF) const {
  //Implementation from HexagonInstrInfo.

  // Debug info is never a scheduling boundary. It's necessary to be explicit
  // due to the special treatment of IT instructions below, otherwise a
  // dbg_value followed by an IT will result in the IT instruction being
  // considered a scheduling hazard, which is wrong. It should be the actual
  // instruction preceding the dbg_value instruction(s), just like it is when
  // debug info is not present.
  if (MI->isDebugValue())
    return false;

  // Terminators and labels can't be scheduled around.
  if (MI->getDesc().isTerminator() || MI->isPosition() || MI->isInlineAsm() || MI->isReturn()) {
    return true;
  }

  return false;
}

// Used by the VLIW Scheduler
DFAPacketizer* VEXInstrInfo::CreateTargetScheduleState
(const TargetSubtargetInfo &STI) const{
    const InstrItineraryData *II = STI.getInstrItineraryData();
    DEBUG(errs() << "Creating the DFAPacketizer!\n");
    return static_cast<const VEXSubtarget &>(STI).createDFAPacketizer(II);
}

// CreateTargetPostRAHazardRecognizer - Return the postRA hazard recognizer
// to use for this target when scheduling the DAG.
//ScheduleHazardRecognizer *VEXInstrInfo::CreateTargetPostRAHazardRecognizer(const InstrItineraryData *II,
//                                                                            const ScheduleDAG *DAG) const {
//    
//    return new VEXHazardRecognizer(II, DAG, "PostRA");
//}
////
//// Default implementation of CreateTargetMIHazardRecognizer.
//ScheduleHazardRecognizer *VEXInstrInfo::CreateTargetMIHazardRecognizer( const InstrItineraryData *II,
//                                                                        const ScheduleDAG *DAG) const {
//    
//    return new VEXHazardRecognizer(II, DAG, "misched");
//}

//ScheduleHazardRecognizer *VEXInstrInfo::CreateTargetHazardRecognizer(const TargetSubtargetInfo *STI,
//                                                       const ScheduleDAG *DAG)  const {
//    const InstrItineraryData *II =
//        static_cast<const VEXSubtarget *>(STI)->getInstrItineraryData();
//    return new VEXHazardRecognizer(II, DAG, "SDNodes");
//}

/// CreateTargetPostRAHazardRecognizer - Return the postRA hazard recognizer
/// to use for this target when scheduling the DAG.
//ScheduleHazardRecognizer *
//VEXInstrInfo::CreateTargetPostRAHazardRecognizer(const TargetSubtargetInfo *STI,
//                                           const ScheduleDAG *DAG) const {
//    // Dummy hazard recognizer allows all instructions to issue.
//    const InstrItineraryData *II =
//        static_cast<const VEXSubtarget *>(STI)->getInstrItineraryData();
//    return new ScoreboardHazardRecognizer(II, DAG, "pre-RA-sched");
//}

