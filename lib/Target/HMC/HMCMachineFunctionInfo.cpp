//===-- HMCMachineFunctionInfo.cpp - Private data used for HMC ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "HMCMachineFunctionInfo.h"

#include "HMCInstrInfo.h"
#include "HMCSubtarget.h"
#include "llvm/IR/Function.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"

using namespace llvm;

// class HMCCallEntry.
HMCCallEntry::HMCCallEntry(const StringRef &N){
#ifndef NDEBUG
    Name = N;
    Val = nullptr;
#endif
}

HMCCallEntry::HMCCallEntry(const GlobalValue *V){
#ifndef NDEBUG
    Val = V;
#endif
}

bool HMCCallEntry::isConstant(const MachineFrameInfo *) const{
    return false;
}

bool HMCCallEntry::isAliased(const MachineFrameInfo *) const{
    return false;
}

bool HMCCallEntry::mayAlias(const MachineFrameInfo *) const{
    return false;
}

void HMCCallEntry::printCustom(raw_ostream &O) const{
    O << "HMCCallEntry: ";
#ifndef NDEBUG
    if(Val)
        O << Val->getName();
    else
        O << Name;
#endif
}

HMCFunctionInfo::~HMCFunctionInfo(){
    for(StringMap<const HMCCallEntry *>::iterator
        I = ExternalCallEntries.begin(), E = ExternalCallEntries.end(); I != E;
        ++I)
        delete I->getValue();
    
    for (const auto &Entry : GlobalCallEntries)
        delete Entry.second;
}

void HMCFunctionInfo::anchor() {}


