//===-- HMCMachineFunctionInfo.h - Private data used for HMC ----*- C++ -*-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the HMC specific subclass of MachineFunctionInfo.
//
//===----------------------------------------------------------------------===//

#ifndef HMCMACHINEFUNCTION_H
#define HMCMACHINEFUNCTION_H

#include "llvm/ADT/StringMap.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/CodeGen/PseudoSourceValue.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/Target/TargetMachine.h"
#include <map>
#include <string>
#include <utility>

#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "HMC-machinefunction"

namespace llvm {
    
    /// brief A class derived from PseudoSourceValue that represents a GOT entry
    /// resolved by lazy-binding.
    
    class HMCCallEntry : public PseudoSourceValue{
        
    public:
        explicit HMCCallEntry(const StringRef &N);
        explicit HMCCallEntry(const GlobalValue *V);
        bool isConstant(const MachineFrameInfo *) const override;
        bool isAliased(const MachineFrameInfo *) const override;
        bool mayAlias(const MachineFrameInfo *) const override;
        
    private:
        void printCustom(raw_ostream &O) const override;
#ifndef NDEBUG
        std::string Name;
        const GlobalValue *Val;
#endif
    };
    
    // HMCFunctionInfo - This class is derived from MachineFunction private
    // HMC target-specific information for each MachineFunction;
    class HMCFunctionInfo : public MachineFunctionInfo {
    public:
        HMCFunctionInfo (MachineFunction &MF)
        : MF(MF), VarArgsFrameIndex(0),
          MaxCallFrameSize(0), IsVarArgFunction(false),
          EmitNOAT(false){
            DEBUG(errs() << "Machine Function");
        }
        ~HMCFunctionInfo();
        
        int getVarArgsFrameIndex() const {return VarArgsFrameIndex; }
        void setVarArgsFrameIndex(int index) { VarArgsFrameIndex = index; IsVarArgFunction = true;}
        bool isVarArgFunction() { return IsVarArgFunction; }
        
        bool getEmitNOAT() const { return EmitNOAT; }
        void setEmitNOAT() { EmitNOAT = true; }

        unsigned getSRetReturnReg() const { return SRetReturnReg; }
        void setSRetReturnReg(unsigned Reg) { SRetReturnReg = Reg; }

    private:
        virtual void anchor();

        bool EmitNOAT;

        MachineFunction& MF;
        
        // VarArgsFrameIndex - FrameIndex for start of varargs area.
        int VarArgsFrameIndex;
        bool IsVarArgFunction;
        
        unsigned MaxCallFrameSize;

        /// SRetReturnReg - Some subtargets require that sret lowering includes
        /// returning the value of the returned struct in a register. This field
        /// holds the virtual register into which the sret argument is passed.
        unsigned SRetReturnReg;
        
        // HMCCallEntry maps.
        StringMap<const HMCCallEntry *> ExternalCallEntries;
        ValueMap<const GlobalValue *, const HMCCallEntry *> GlobalCallEntries;
        
        
    };
    
}




#endif
