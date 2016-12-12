//===-- VEXMachineFunctionInfo.h - Private data used for VEX ----*- C++ -*-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the VEX specific subclass of MachineFunctionInfo.
//
//===----------------------------------------------------------------------===//



#ifndef DATEREUSEINFO_H
#define DATEREUSEINFO_H

#include "SPMVariable.h"

#define DEBUG_TYPE "datareuseinfo"


namespace llvm {

class DataReuseInfo {

    std::vector<SPMVariable> Variables;
    unsigned NumSPMs;
    std::vector<unsigned> MemoriesOffsets;
    unsigned IssueWidth;

    unsigned GlobalMemUnits;

public:
    DataReuseInfo() : GlobalMemUnits(2) {
        Variables.resize(0);
        MemoriesOffsets.resize(0);
    }

    void setGlobalMemUnits (unsigned Units) {
        GlobalMemUnits = Units;
    }

    void setNumSPMs (unsigned SPMs) {
        MemoriesOffsets.resize(SPMs);
        NumSPMs = SPMs;
    }

    void PropagateCallRegistersForVariables() {
        for (SPMVariable &var : Variables) {
            var.TransferPropagationCallRegisters();
            var.ResetInfo();
        }
    }

    void resetVariables() {
        Variables.resize(0);
    }

    void setIssueWidth (unsigned issuewidth) {
        IssueWidth = issuewidth;
    }

    unsigned getNumSPMs() { return NumSPMs; }
    std::vector<SPMVariable> getVariables() const { return Variables; }

    unsigned getAvailableOffset(unsigned Memory, int Size);

    bool AddVariable(SPMVariable Var);
    bool AddVariable(std::string Name, unsigned Register, MachineBasicBlock::iterator Inst, const GlobalValue* GV);
    void RemoveVariable(int Position);
    bool RemoveVariable(SPMVariable Var);
    bool RemoveVariable(std::string Name);
    bool UpdateVariable(SPMVariable& Var);
    bool FindVariable(std::string Name);
    void UpdateDataType(std::string Name, unsigned DataType);

    unsigned getVarOffsetInSPM(SPMVariable &Var);

    unsigned getOffsetAndUpdateMemories(SPMVariable &Var, unsigned NumberOfSPMs, unsigned OffsetSize);

    SPMVariable getVariable(MachineBasicBlock::iterator MI);

    unsigned AllocateSPMs(SPMVariable &Var);

    void AddOffset(std::string Name, unsigned Register, unsigned Offset, MachineInstr *Inst, MachineBasicBlock* MBB);
    void AddMemInstRef(std::string Name, MachineBasicBlock::iterator newInst);

    typedef std::vector<SPMVariable>::iterator iterator;
    typedef std::vector<SPMVariable>::const_iterator const_iterator;

    SPMVariable             &front() { return Variables.front(); }
    const SPMVariable       &front() const { return Variables.front(); }
    SPMVariable             &back() { return *--end(); }
    const SPMVariable       &back() const { return *--end(); }

    iterator            var_begin() { return Variables.begin(); }
    const_iterator      var_begin() const { return Variables.begin(); }
    iterator            var_end() { return Variables.end(); }
    const_iterator      var_end() const { return Variables.end(); }

    iterator            begin() { return var_begin(); }
    const_iterator      begin() const { return var_begin(); }
    iterator            end() { return var_end(); }
    const_iterator      end() const { return var_end(); }

};
    
}


#endif
