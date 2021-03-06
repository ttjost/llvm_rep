//===-- HMCISelDAGToDAG.h - Top-level interface for HMC representation ----*- C++ -*-===//
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

#ifndef HMCISELDAGTODAG_H
#define HMCISELDAGTODAG_H


#include "HMC.h"
#include "HMCSubtarget.h"
#include "HMCTargetMachine.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/Debug.h"

#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

//===----------------------------------------------------------------------===//
// Instruction Selector Implementation
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// HMCDAGToDAGISel - HMC specific code to select HMC machine
// instructions for SelectionDAG operations.
//===----------------------------------------------------------------------===//

namespace llvm{

#define DEBUG_TYPE "HMC-isel-h"

class HMCDAGToDAGISel : public SelectionDAGISel {
public:
    explicit HMCDAGToDAGISel(HMCTargetMachine &TM)
        : SelectionDAGISel(TM), Subtarget(nullptr){
        DEBUG(errs() << "Creating the debug message\n\n");
        }

    const char *getPassName() const override{
        DEBUG(errs() << "HMC DAG->DAG Pattern Instruction Selection\n\n");
        return "HMC DAG->DAG Pattern Instruction Selection";
    }

    bool runOnMachineFunction(MachineFunction &MF) override;

protected:
    SDNode *getGlobalBaseReg();

    // Keep a pointer to the HMCSubtarget around so that we can make
    // the right decision when generating code for different targets.
    const HMCSubtarget *Subtarget;

private:
    // Include the pieces autogenerated from the target description.
#include "HMCGenDAGISel.inc"

    // getTargetMachine - Return a reference to the TargetMachine, casted
    // to the target-specific type;
    const HMCTargetMachine &getTargetMachine(){
        return static_cast<const HMCTargetMachine &>(TM);
    }

    SDNode *Select(SDNode *Node) override;

    std::pair<bool, SDNode*> selectNode(SDNode *Node);

    // Complex Pattern for the Load and Store Address Calculation
    bool SelectAddr(SDValue Addr, SDValue &Base, SDValue &Offset);

    // getImm - Return a target constant with the specified value;
    inline SDValue getImm(const SDNode *Node, unsigned Imm){
        return CurDAG->getTargetConstant(Imm, SDLoc(Node), Node->getValueType(0));
    }

    void processFunctionAfterISel(MachineFunction &MF);

};

FunctionPass *createHMCISelDag(HMCTargetMachine &TM);

}





#endif
