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

#ifndef SPMVARIABLE_H
#define SPMVARIABLE_H

#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/IR/GlobalValue.h"
#include <map>
#include <set>

namespace llvm {

// This class defines a variable that will be stored in one or more Scratchpads
// A variable can be either a vector/matrix or a single value. However, priority
// is always given to vectors, since ILP can be better explored with them.
class SPMVariable {

    typedef struct RegisterOffsetBBTriple {
        unsigned Register;
        std::vector<unsigned> Offsets;
        MachineInstr *Inst;
        MachineBasicBlock *MBB;
    } RegisterOffsetBBTriple;

    std::string Name;
    unsigned Flags;         // See MemOperandFlags in MachineMemOperand.h

    std::vector<MachineInstr*> PropagationInstructions;
    std::vector<unsigned> PropagationRegisters;      // Used for knowing which registers propagate the variable information
    std::vector<RegisterOffsetBBTriple> RegistersAndOffsets;

    std::vector<unsigned> PropagationCallRegisters;

    const GlobalValue *GV;

    bool Preamble;

    std::map<MachineBasicBlock*, unsigned> BaseRegs;
    std::vector<MachineBasicBlock::iterator> MemoryInstructions;

    std::vector<MachineBasicBlock::iterator> DefinitionInstructions;

    // Define whether this variable will be stored in multiple SPMs
    // Default: false
    bool MultipleStorage;

    std::vector<unsigned> Memories;
    unsigned NumMemories;
    int AllocationPriority;

    // Define whether these variable(vector) will dynamically change stored data
    // FIR application is a good example on how this can be achieved.
    bool DynamicAllocation;

    bool LoadsRequired;

    int MinimumOffset;
    unsigned totalInnerLoops;
    unsigned MinimumDistance;
    unsigned MaximumDistance;

    unsigned ConsecutiveDataPerSPM;
    unsigned OffsetsPerBB;
    unsigned NumUnits;
    unsigned InitialAddress;
    unsigned Size;
    unsigned NumElements;

    unsigned DataType;
    unsigned DataSize;

    /// Flags values. These may be or'd together.
    enum MemOperandFlags {
      /// The memory access reads data.
      MOLoad = 1,
      /// The memory access writes data.
      MOStore = 2,
      /// The memory access is volatile.
      MOVolatile = 4,
      /// The memory access is non-temporal.
      MONonTemporal = 8,
      /// The memory access is invariant.
      MOInvariant = 16,
      // Target hints allow target passes to annotate memory operations.
      MOTargetStartBit = 5,
      MOTargetNumBits = 3,
      // This is the number of bits we need to represent flags.
      MOMaxBits = 8
    };

public:
    // Variable Type
    enum MemDataType {
        MDByte = 1,
        MDByteU = 2,
        MDHalf = 3,
        MDHalfU = 4,
        MDFull = 5
    };

    SPMVariable() : Name(""), Flags(0), MultipleStorage(false), LoadsRequired(false), AllocationPriority(-1)  {
        PropagationRegisters.resize(0);
    }
    SPMVariable(std::string Name) : Name(Name),
                                  Flags(0),
                                  MultipleStorage(false),
                                  LoadsRequired(false),
                                    AllocationPriority(-1) {
        PropagationRegisters.resize(0);
    }

//    SPMVariable(std::string Name, unsigned Flags): Name(Name), Flags(Flags), MultipleStorage(false) {
//        PropagationRegisters.resize(0);
//    }
    SPMVariable(std::string Name, unsigned Register,
                MachineBasicBlock::iterator Inst,
                const GlobalValue *V) : Name(Name),
                                                    Flags(0),
                                                    OffsetsPerBB(0),
                                                    MultipleStorage(false),
                                                    LoadsRequired(false),
                                                    AllocationPriority(-1),
                                                    DataType(0),
                                                    Size (1000),
                                                    GV (V) {
        PropagationRegisters.push_back(Register);
        RegistersAndOffsets.resize(0);
        MemoryInstructions.resize(0);
        DefinitionInstructions.resize(0);
        if (Inst)
            DefinitionInstructions.push_back(Inst);
    }

    const GlobalValue *getGlobalValue() const { return GV; }

    std::string getName() const { return Name; }
    unsigned getFlags() const  { return Flags; } 
    bool isLoad() const { return Flags & MOLoad; }
    bool isStore() const { return Flags & MOStore; }
    bool isVolatile() const { return Flags & MOVolatile; }
    bool isNonTemporal() const { return Flags & MONonTemporal; }
    bool isInvariant() const { return Flags & MOInvariant; }

    bool isDefinitionInstruction(MachineBasicBlock::iterator Inst);

    bool isChar() const { return (DataType & MDByte) || (DataType & MDByteU); }
    bool isShort() const { return (DataType & MDHalf) || (DataType & MDHalfU); }
    bool isInt() const { return DataType & MDFull; }

    unsigned getDataSize() const { return DataSize; }

    void setDataSize() {
        if (DataType == MDFull)
            DataSize = 4;
        else if ((DataType == MDByte) || (DataType == MDByteU))
            DataSize = 1;
        else if ((DataType == MDHalf) || (DataType == MDHalfU))
            DataSize = 2;
    }

    void setDataType(unsigned flag) {
        DataType = flag;
        setDataSize();
    }

    void setFlags(unsigned flags) { Flags = flags; }
    void setLoad() { Flags |= MOLoad; }
    void setStore() { Flags |= MOStore; }

    void setSize(unsigned size) { Size = size; }

    void setInitialAddress(unsigned Addr) { InitialAddress = Addr; }

    bool isMultipleStorage() const { return MultipleStorage; }
    bool isDinamicallyAllocated() const  { return DynamicAllocation; }

    unsigned getMemoryUnit();
    
    void CalculateOffsetDistribution();
    
    // Return Lane and Offset for that Value in Scratchpad
    // We only need to worry about this when using Multiple Storages.
    // Otherwise, finding out Lane and Offset is straightforward.
    void CalculateLaneAndOffset(unsigned &Lane, int64_t &Offset);
    
    void setMemoryUnits(std::vector<unsigned> Units);
    void setNumElements(unsigned Elements);

    bool isNotAllocated() const { return AllocationPriority < 0; }
    
    std::vector<unsigned> getMemories() const { return Memories; }
    
    int getTotalInnerLoops() const  { return totalInnerLoops; }
    int getMinimumOffset() const  { return MinimumOffset; }
    unsigned getNumUnits() const { return NumUnits; }
    unsigned getInitialAddress() const { return InitialAddress; }
    unsigned getSize() const { return Size; }
    unsigned getNumElements() const { return NumElements; }
    unsigned getMaxOffsetPerBB() const { return OffsetsPerBB; }
    
    unsigned getConsecutiveDataPerSPM() const { return ConsecutiveDataPerSPM; } 

    bool areLoadsRequired() const { return LoadsRequired; }

    unsigned getMaximumSPMs(unsigned IssueWidth);
    
    void AddPropagationRegister(MachineInstr* Inst, unsigned Register);
    void AddPropagationCallRegister(unsigned Register);
    void AddMemoryInstruction(MachineBasicBlock::iterator MI);
    void AddDefinitionInstruction(MachineBasicBlock::iterator MI);

    void ResetInfo();

    void TransferPropagationCallRegisters();

    void AddBaseRegister(MachineBasicBlock *MBB, unsigned BaseRegister);
    unsigned FindBaseRegister(MachineBasicBlock *MBB);
                         
    unsigned getDataType() {
        return DataType;
    }

    void setPreambleInserted() { Preamble = true; }
    bool isPreambleInserted() { return Preamble; }

    std::vector<unsigned> getPropagationRegisters() const { return PropagationRegisters; }
    std::vector<MachineInstr *> getPropagationInstructions() const { return PropagationInstructions; }
    std::vector<MachineBasicBlock::iterator> getMemoryInstructions() const { return MemoryInstructions; }
    MachineBasicBlock::iterator getFirstMemoryInstruction() const;
    MachineBasicBlock::iterator getFirstMemoryInstruction(MachineBasicBlock *BB) const;

    MachineBasicBlock::iterator getFirstDefinition() const;
    std::vector<MachineBasicBlock::iterator> getDefinitionInstructions() const { return DefinitionInstructions; }

    void AddOffset(unsigned Register, unsigned Offset, MachineInstr* Inst, MachineBasicBlock* MBB);
    void UpdateOffsetInfo();

    std::vector<MachineBasicBlock *> getBasicblocks();
    
    bool operator==(const SPMVariable& rhs);

//    SPMVariable& operator=(const SPMVariable& rhs);
};
    
}

#endif
