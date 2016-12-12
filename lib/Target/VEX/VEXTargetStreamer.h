//===-- VEXTargetStreamer.h - VEX Target Streamer ----------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef VEXTARGETSTREAMER_H
#define VEXTARGETSTREAMER_H

#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCELFStreamer.h"


namespace llvm {

class VEXTargetStreamer : public MCTargetStreamer {
    virtual void anchor();

public:
    VEXTargetStreamer(MCStreamer &S);
    void EmitBytes(StringRef Data);

};

class VEXTargetAsmStreamer : public VEXTargetStreamer {
    formatted_raw_ostream &OS;

public:
    VEXTargetAsmStreamer(MCStreamer &S, formatted_raw_ostream &OS);
    
    void EmitBytes(StringRef Data);
};

class VEXTargetElfStreamer : public VEXTargetStreamer {

public:
    VEXTargetElfStreamer(MCStreamer &S);
};

}

#endif // VEXTARGETSTREAMER_H
