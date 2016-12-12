//===-- HMCISelLowering.h - HMC DAG Lowering Interface --------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that HMC uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#ifndef HMCISELLOWERING_H
#define HMCISELLOWERING_H

#include "HMC.h"
#include "llvm/CodeGen/CallingConvLower.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/IR/Function.h"
#include "llvm/Target/TargetLowering.h"
#include <deque>

namespace llvm {
    
    struct FunctionInfo {
        std::multimap<std::string, unsigned> info;
    };
    
    namespace HMCISD {
        enum NodeType{
            
            // Start the numbering from where ISD NodeType finishes.
            FIRST_NUMBER = ISD::BUILTIN_OP_END,
            
            //JmpLink,
            
            THREADPOINTER,
            
            RET,
            
            PSEUDO_RET,
            MAX,
            MAXU,
            MIN,
            MINU,

            ADDCG,
            DIVS,
            
            // Used for ISD::SDIV and ISD::UDIV Instructions
            ORC,
            SH1ADD,
            MTB,
            
            SLCT,
            MOV,
            
            MPYLL,
            MPYLLU,
            MPYLH,
            MPYLHU,
            MPYHH,
            MPYHHU,
            MPYL,
            MPYLU,
            MPYH,
            MPYHU,
            MPYHS,

            PSEUDO_CALL,
            PSEUDO_TAILCALL,

            WRAPPER,
//            BR,
//            BRF,

            DYNALLOC,
            
            SYNC,

            // HMC Vector Instructions
            VEC_ADD,
            
            UNKNOWN
            
        };
    }

//===--------------------------------------------------------------------===//
// TargetLowering Implementation
//===--------------------------------------------------------------------===//
class HMCFunctionInfo;
class HMCSubtarget;

//@ Class HMCTargetLowering
class HMCTargetLowering : public TargetLowering{

public:
    explicit HMCTargetLowering(const TargetMachine &TM,
                               const HMCSubtarget &STI);
    
    static const HMCTargetLowering *create(const HMCTargetMachine &TM,
                                           const HMCSubtarget &STI);
    
    // getTargetNodeName - This method returns the name of a target specific
    // DAG node.
    const char *getTargetNodeName(unsigned Opcode) const override;

    virtual bool useSoftFloat() const override { return true; }
    
    FunctionInfo* getFunctionReturns() const {
        return FunctionReturns.get();
    }
    
    FunctionInfo* getFunctionArguments() const {
        return FunctionArguments.get();
    }
    
    FunctionInfo* getFunctionCalled() const {
        return FunctionCalled.get();
    }
    
    void addFunctionArgument(std::string Function, unsigned numArguments, bool IsVarArg = false) const {
        if (FunctionArguments->info.find(Function) == FunctionArguments->info.end() || IsVarArg)
            FunctionArguments->info.insert(std::pair<std::string, unsigned>(Function, numArguments));
    }
    
    void addFunctionCalled(std::string Function, unsigned numArguments, bool IsVarArg = false) const {
        if (FunctionCalled->info.find(Function) == FunctionCalled->info.end()) {
            if (IsVarArg) {
                FunctionCalled->info.insert(std::pair<std::string, unsigned>(Function, 8));
            } else {
                FunctionCalled->info.insert(std::pair<std::string, unsigned>(Function, numArguments));
            }
        }
    }
    
    void addFunctionReturn(std::string Function, unsigned numReturns) const {
        if (FunctionReturns->info.find(Function) != FunctionReturns->info.end())
            assert(FunctionReturns->info.find(Function)->second == numReturns && "Number of returns do not match. Something is wrong");
        else
            FunctionReturns->info.insert(std::pair<std::string, unsigned>(Function, numReturns));
    }
    
protected:
    /// ByValArgInfo - Byval argument information.
    struct ByValArgInfo{
        unsigned FirstIdx;  // Index of the first register used.
        unsigned NumRegs;   // Number of registers used for this argument.
        unsigned Address;   // Offset of the stack are used to pass this argument.
        
        ByValArgInfo() : FirstIdx(0), NumRegs(0), Address(0) {}
    };
    
protected:
    // Subtarget Info
    const HMCSubtarget &Subtarget;
    
private:
    
    std::unique_ptr<FunctionInfo> FunctionReturns;
    std::unique_ptr<FunctionInfo> FunctionArguments;
    std::unique_ptr<FunctionInfo> FunctionCalled;

    
#if 0
    // Create a TargetConstantPool node.
    SDValue getTargetNode(ConstantPoolSDNode *N, EVT Ty, SelectionDAG &DAG,
                          unsigned Flag) const;
#endif
    
    SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;
    
    /// getConstraintType - Given a constraint letter, return the type of
    /// constraint it is for this target.
    TargetLowering::ConstraintType
        getConstraintType(const std::string &Constraint) const;
    
    std::pair<unsigned, const TargetRegisterClass *>
        getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                                                    const std::string &Constraint,
                                                    MVT VT) const;
    
    bool isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const;

    // Custom Lowering of Instructions
    
    // Lower Operand specifics
    SDValue LowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerJumpTable(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerExternalSymbol(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerVASTART(SDValue Op, SelectionDAG &DAG) const;
    
    SDValue LowerConstant(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerSETCC(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerMUL(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerDIVISION(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerSDIV(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerUDIV(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerSREM(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerUREM(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerADDSUBWithFlags(SDValue Op, SelectionDAG &DAG) const;
    
    SDValue LowerLOAD(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerSTORE(SDValue Op, SelectionDAG &DAG) const;
    
    SDValue LowerMULHS(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerMULHU(SDValue Op, SelectionDAG &DAG) const;

    SDValue LowerADDVec(SDValue Op, SelectionDAG &DAG) const;

    SDValue
    LowerCall(CallLoweringInfo &CLI,
                SmallVectorImpl<SDValue> &InVals) const override;
    
    bool IsEligibleForTailCallOptimization(SDValue Callee,
                                           CallingConv::ID CalleeCC,
                                           bool isVarArg,
                                           bool isCalleeStructRet,
                                           bool isCallerStructRet,
                                           const SmallVectorImpl<ISD::OutputArg> &Outs,
                                           const SmallVectorImpl<SDValue> &OutVals,
                                           const SmallVectorImpl<ISD::InputArg> &Ins,
                                           SelectionDAG& DAG) const ;
    
    //- must exist even without function all
    SDValue
    LowerFormalArguments(SDValue Chain,
                         CallingConv::ID CallConv, bool IsVarArg,
                         const SmallVectorImpl<ISD::InputArg> &Ins,
                         SDLoc dl, SelectionDAG &DAG,
                         SmallVectorImpl<SDValue> &InVals) const override;
    
    SDValue
    LowerReturn(SDValue Chain,
                CallingConv::ID CallConv, bool IsVarArg,
                const SmallVectorImpl<ISD::OutputArg> &Outs,
                const SmallVectorImpl<SDValue> &OutVals,
                SDLoc dl, SelectionDAG &DAG) const override;
    
    
    void copyByValRegs(SDValue Chain, SDLoc DL, std::vector<SDValue> &OutChains, SelectionDAG &DAG,
                       const ISD::ArgFlagsTy &Flags, SmallVectorImpl<SDValue> &InVals,
                       const Argument *FuncArg, unsigned FirstReg, unsigned LastReg,
                       const CCValAssign &VA,
                       MachineRegisterInfo &MRI) const;
    
    // Used in FormalArguments to Store register in stack when is a variadic function
    void writeVarArgRegs(std::vector<SDValue> &OutChains,
                         SDValue Chain, SDLoc DL,
                         SelectionDAG &DAG,
                         CCState &State,
                         MachineRegisterInfo &MRI) const;
    
    void passByValArg(SDValue Chain, SDLoc DL,
                      SmallVector<std::pair<unsigned, SDValue>, 10> RegsToPass,
                      SmallVectorImpl<SDValue> &MemOpChains, SDValue StackPtr,
                      MachineFrameInfo *MFI, SelectionDAG &DAG, SDValue Arg, unsigned FirstReg,
                      unsigned LastReg, const ISD::ArgFlagsTy &Flags,
                      const CCValAssign &VA) const;
    
    void HandleByVal(CCState *State, unsigned &Size,
                     unsigned Align) const;
    
    SDValue LowerRETURNADDR(SDValue Op, SelectionDAG &DAG) const;
    
    SDValue LowerFRAMEADDR(SDValue Op, SelectionDAG &DAG) const;
    
    //SDValue LowerBRCOND(SDValue Op, SelectionDAG &DAG) const;
    
    SDValue PerformDAGCombine(SDNode *N, DAGCombinerInfo &DCI) const;

    SDValue CombineMinMaxLegacy(SDLoc DL, EVT VT, SDValue lhs, SDValue rhs,
                          SDValue True, SDValue False,
                          SDValue CC, SelectionDAG &DAG) const;
    
    /// Returns true if the target allows unaligned memory accesses of the
    /// specified type. Returns whether it is "fast" in the last argument.
    bool allowsMisalignedMemoryAccesses(EVT VT, unsigned AS, unsigned Align,
                                        bool *Fast) const override;
    
};

}

#endif

