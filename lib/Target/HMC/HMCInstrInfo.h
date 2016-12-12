//===-- HMCInstrInfo.h - HMC Instruction Information ----------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the HMC implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef HMCINSTRUCTIONINFO_H
#define HMCINSTRUCTIONINFO_H

#include "HMC.h"
#include "HMCRegisterInfo.h"
#include "HMCMachineFunctionInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/Target/TargetInstrInfo.h"

#define GET_INSTRINFO_HEADER
#include "HMCGenInstrInfo.inc"

namespace llvm{

    class HMCInstrInfo : public HMCGenInstrInfo{
        const HMCRegisterInfo RI;

    protected:
        const HMCSubtarget &Subtarget;
        
    public:
        explicit HMCInstrInfo(const HMCSubtarget &STI);
        
        /// getRegisterInfo - TargetInstrInfo is a superset of MRegister info. As
        /// such, whenever a client has an instance of instruction info, it should
        /// always be able to get register info as well (through this method).
        ///
        
        const HMCSubtarget &getSubtarget() const { return Subtarget; }
        
        const HMCRegisterInfo &getRegisterInfo() const { return RI; }

        void copyPhysReg(MachineBasicBlock &MBB,
                         MachineBasicBlock::iterator MI, DebugLoc DL,
                         unsigned DestReg, unsigned SrcReg,
                         bool KillSrc) const;
        
        bool expandPostRAPseudo (MachineBasicBlock::iterator MI) const;

        void loadRegFromStackSlot(MachineBasicBlock &MBB,
                                  MachineBasicBlock::iterator MI,
                                  unsigned DestReg, int FrameIndex,
                                  const TargetRegisterClass *RC,
                                  const TargetRegisterInfo *TRI) const;

        void storeRegToStackSlot(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator MI,
                                 unsigned SrcReg, bool isKill, int FrameIndex,
                                 const TargetRegisterClass *RC,
                                 const TargetRegisterInfo *TRI) const;
        
        // Use in EmitPrologue to adjust SP by FrameSize bytes and save
        void makeFrame(unsigned SP, int64_t FrameSize,
                                     MachineBasicBlock &MBB,
                                     MachineBasicBlock::iterator I) const;

        // Adjust SP by Amount bytes
        void adjustStackPtr(HMCFunctionInfo *HMCFI, unsigned SP, uint64_t Amount,
                            MachineBasicBlock &MBB, MachineBasicBlock::iterator I)
        const;

        void insertNoop(MachineBasicBlock &MBB,
                                            MachineBasicBlock::iterator MI) const;

        unsigned InsertBranch(MachineBasicBlock &MBB, MachineBasicBlock *TBB,
                                MachineBasicBlock *FBB, ArrayRef<MachineOperand> Cond,
                                DebugLoc DL) const override;

        unsigned RemoveBranch(MachineBasicBlock &MBB) const override;

        bool AnalyzeBranch(MachineBasicBlock &MBB,
                           MachineBasicBlock *&TBB,
                           MachineBasicBlock *&FBB,
                           SmallVectorImpl< MachineOperand > &Cond,
                           bool AllowModify=false) const override;

        void BuildCondBr(MachineBasicBlock &MBB,
                         MachineBasicBlock *TBB, DebugLoc DL,
                         ArrayRef<MachineOperand> Cond) const;

        bool ReverseBranchCondition(SmallVectorImpl<MachineOperand> &Cond) const override;

        bool isSchedulingBoundary(const MachineInstr *MI,
                                  const MachineBasicBlock *MBB,
                                  const MachineFunction &MF) const override;

        // Used by the VLIW Scheduler.
        DFAPacketizer* CreateTargetScheduleState(const TargetSubtargetInfo &STI) const;
        
        /// CreateTargetPostRAHazardRecognizer - Return the postRA hazard recognizer
        /// to use for this target when scheduling the DAG.
//        ScheduleHazardRecognizer *CreateTargetPostRAHazardRecognizer(const InstrItineraryData *II,
//                                                                                   const ScheduleDAG *DAG) const;

        // Default implementation of CreateTargetMIHazardRecognizer.
//        ScheduleHazardRecognizer *CreateTargetMIHazardRecognizer( const InstrItineraryData *II,
//                                                                               const ScheduleDAG *DAG) const;

//        // Default implementation of CreateTargetHazardRecognizer.
//        // Default implementation of CreateTargetRAHazardRecognizer.
//        ScheduleHazardRecognizer *CreateTargetHazardRecognizer(const TargetSubtargetInfo *STI,
//                                                               const ScheduleDAG *DAG) const override;
        
//        /// CreateTargetPostRAHazardRecognizer - Return the postRA hazard recognizer
//        /// to use for this target when scheduling the DAG.
//        ScheduleHazardRecognizer *
//            CreateTargetPostRAHazardRecognizer(const TargetSubtargetInfo *STI,
//                                                   const ScheduleDAG *DAG) const ;

    };
    
}

#endif
