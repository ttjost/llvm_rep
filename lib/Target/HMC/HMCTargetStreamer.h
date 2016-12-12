//===-- HMCTargetStreamer.h - HMC Target Streamer ----------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef HMCTARGETSTREAMER_H
#define HMCTARGETSTREAMER_H

#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCELFStreamer.h"


namespace llvm {

class HMCTargetStreamer : public MCTargetStreamer {
    virtual void anchor();

public:
    HMCTargetStreamer(MCStreamer &S);
    void EmitBytes(StringRef Data);

};

class HMCTargetAsmStreamer : public HMCTargetStreamer {
    formatted_raw_ostream &OS;

public:
    HMCTargetAsmStreamer(MCStreamer &S, formatted_raw_ostream &OS);
    
    void EmitBytes(StringRef Data);
};

class HMCTargetElfStreamer : public HMCTargetStreamer {

public:
    HMCTargetElfStreamer(MCStreamer &S);
};

}

#endif // HMCTARGETSTREAMER_H
