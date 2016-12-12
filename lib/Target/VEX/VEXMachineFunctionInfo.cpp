//===-- VEXMachineFunctionInfo.cpp - Private data used for VEX ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "VEXMachineFunctionInfo.h"

#include "VEXInstrInfo.h"
#include "VEXSubtarget.h"
#include "llvm/IR/Function.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"

using namespace llvm;

// class VEXCallEntry.
VEXCallEntry::VEXCallEntry(const StringRef &N){
#ifndef NDEBUG
    Name = N;
    Val = nullptr;
#endif
}

VEXCallEntry::VEXCallEntry(const GlobalValue *V){
#ifndef NDEBUG
    Val = V;
#endif
}

bool VEXCallEntry::isConstant(const MachineFrameInfo *) const{
    return false;
}

bool VEXCallEntry::isAliased(const MachineFrameInfo *) const{
    return false;
}

bool VEXCallEntry::mayAlias(const MachineFrameInfo *) const{
    return false;
}

void VEXCallEntry::printCustom(raw_ostream &O) const{
    O << "VEXCallEntry: ";
#ifndef NDEBUG
    if(Val)
        O << Val->getName();
    else
        O << Name;
#endif
}

VEXFunctionInfo::~VEXFunctionInfo(){
    for(StringMap<const VEXCallEntry *>::iterator
        I = ExternalCallEntries.begin(), E = ExternalCallEntries.end(); I != E;
        ++I)
        delete I->getValue();
    
    for (const auto &Entry : GlobalCallEntries)
        delete Entry.second;
}

void VEXFunctionInfo::anchor() {}


