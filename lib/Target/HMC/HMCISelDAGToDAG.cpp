//===-- HMCISelDAGToDAG.cpp - Top-level interface for HMC representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//  This file defines an instruction selector for the HMC Target
//
//===----------------------------------------------------------------------===//

#include "HMCISelDAGToDAG.h"
#include "HMC.h"

#include "HMCMachineFunctionInfo.h"
#include "HMCRegisterInfo.h"
#include "HMCSubtarget.h"
#include "HMCTargetMachine.h"
#include "MCTargetDesc/HMCBaseInfo.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Type.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/CodeGen/SelectionDAGNodes.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "HMC-isel"

//===----------------------------------------------------------------------===//
// Instruction Selector Implementation
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// HMCDAGToDAGISel - HMC specific code to select HMC machine
// instructions for SelectionDAG operations.
//===----------------------------------------------------------------------===//

bool HMCDAGToDAGISel::runOnMachineFunction(MachineFunction &MF){
    DEBUG(errs() << "Testing the debug message\n\n");
    bool Ret = SelectionDAGISel::runOnMachineFunction(MF);
    DEBUG(errs() << "Testing the debug message\n\n");

    return Ret;
}


bool HMCDAGToDAGISel::SelectAddr(SDValue Addr, SDValue &Base, SDValue &Offset) {
    
    SDLoc dl(Addr);
    const DataLayout &DLayout = CurDAG->getDataLayout();
    
    if (FrameIndexSDNode *FIN = dyn_cast<FrameIndexSDNode>(Addr)) {
        Base = CurDAG->getTargetFrameIndex(FIN->getIndex(), TLI->getPointerTy(DLayout));
        Offset = CurDAG->getTargetConstant(0, dl, MVT::i32);
        return true;
    }
    if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
        Addr.getOpcode() == ISD::TargetGlobalAddress ||
        Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
        return false;  // direct calls.
    
    if (CurDAG->isBaseWithConstantOffset(Addr)) {
        if (ConstantSDNode *CN = dyn_cast<ConstantSDNode>(Addr.getOperand(1))) {
            if (isInt<13>(CN->getSExtValue())) {
                if (FrameIndexSDNode *FIN =
                    dyn_cast<FrameIndexSDNode>(Addr.getOperand(0))) {
                    // Constant offset from frame ref.
                    Base =
                    CurDAG->getTargetFrameIndex(FIN->getIndex(), TLI->getPointerTy(DLayout));
                } else {
                    Base = Addr.getOperand(0);
                }
                Offset = CurDAG->getTargetConstant(CN->getZExtValue(), dl, MVT::i32);
                return true;
            }
        }
    }
    
    Base = Addr;
    Offset = CurDAG->getTargetConstant(0, dl, Addr.getValueType());
    return true;
}

// Select instructions not customized!
// Used for expanded, promoted and normal instructions
SDNode * HMCDAGToDAGISel::Select(SDNode *Node){

    unsigned Opcode = Node->getOpcode();

    DEBUG(errs() << "Selecting New node\n");

    // Dump information about the Node being selected
    DEBUG(errs() << "Selecting: "; Node->dump(CurDAG); errs() << "\n");

    // If we have a custom node, we already have selected!
    if(Node->isMachineOpcode()){
        Node->setNodeId(-1);
        return nullptr;
    }

    // See if subclasses can handle this node
    std::pair<bool, SDNode*> Ret = selectNode(Node);
    DEBUG(errs() << "Finished Selecting\n");
    if(Ret.first)
        return Ret.second;
    // Select the default instruction
    SDNode *ResNode = SelectCode(Node);
    
    if(ResNode == NULL || ResNode == Node)
        DEBUG(Node->dump(CurDAG));
    else
        DEBUG(ResNode->dump(CurDAG));
    
    return ResNode;

}


std::pair<bool, SDNode*> HMCDAGToDAGISel::selectNode(SDNode *Node){
    
    unsigned Opcode = Node->getOpcode();

    SDLoc DL(Node);

    // Instruction Selection not handled by the auto-generated
    // tablegen selection should be handled here.
    SDNode *Result;

    EVT NodeTy = Node->getValueType(0);
    unsigned MultOpc;

    switch(Opcode){
        case ISD::MUL: {
            DEBUG(errs() << "Selecting node mult.");
//                mpylu LO_REGISTER = rs, rt
//                mpyhs aux = rs, rt
//                add LO_REGISTER = LO_REGISTER, aux
//                  SDValue LHS = Node->getOperand(1);
//                  SDValue RHS = Node->getOperand(2);

//                  MultOpc = HMC::MPYLU
        }
        break;
            
//        case ISD::SDIV: {
//            DEBUG(errs() << "Selecting SDIV Node");
//            
//
//            return std::make_pair(true, SLCTRes.getNode());
//        }
//        break;
            
        case ISD::Constant: {
//        if (N->getValueType(0) == MVT::i1) {
//          SDNode* Result = 0;
//          int32_t Val = cast<ConstantSDNode>(N)->getSExtValue();
//          if (Val == -1) {
//            Result = CurDAG->getMachineNode(Hexagon::TFR_PdTrue, dl, MVT::i1);
//          } else if (Val == 0) {
//            Result = CurDAG->getMachineNode(Hexagon::TFR_PdFalse, dl, MVT::i1);
//          }
//          if (Result) {
//            ReplaceUses(N, Result);
//            return Result;
//          }
//        }
//            if (Node->getValueType(0) != MVT::i1){
//                DEBUG(errs() << "NOT i1 constant\n");
//                break;
//            } else {
//                DEBUG(errs() << "This is a i1 constant\n");
//                int32_t Val = cast<ConstantSDNode>(Node)->getSExtValue();
//                if (Val == 0) {
//                    SDValue Reg0 = CurDAG->getRegister(HMC::Reg0, MVT::i32);
//                    SDNode* Result = CurDAG->SelectNodeTo(Node, HMC::MTB, Node->getValueType(0), Reg0);
//                    return std::make_pair(true, Result);
//                }
//            }
        }
        default: break;
    }

    return std::make_pair(false, nullptr);

}

void HMCDAGToDAGISel::processFunctionAfterISel(MachineFunction &MF){

//    MachineRegisterInfo *MRI = &MF.getRegInfo();

//    for(MachineFunction::iterator MFI = MF.begin(), MFE = MF.end(); MFI != MFE ; ++MFI)
//        for(MachineBasicBlock::iterator I = MFI->begin(), E = MFI->end(); I != E; ++I)
//            if (I->getOperand(1))

}

// createHMCISelDag - This pass converts a legalized DAG into a
// HMC-specific DAG, ready for instruction scheduling.
FunctionPass *llvm::createHMCISelDag(HMCTargetMachine &TM){
    return new HMCDAGToDAGISel(TM);
}
