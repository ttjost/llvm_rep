//===-- HMCTargetStreamer.cpp - HMC Target Streamer ----------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "HMCTargetStreamer.h"
#include "InstPrinter/HMCInstPrinter.h"
#include "llvm/Support/FormattedStream.h"

using namespace llvm;

HMCTargetStreamer::HMCTargetStreamer(MCStreamer &S) : MCTargetStreamer(S) {}

void HMCTargetStreamer::anchor() {}

void HMCTargetStreamer::EmitBytes(StringRef Data) {}


HMCTargetAsmStreamer::HMCTargetAsmStreamer(MCStreamer &S,
                                           formatted_raw_ostream &OS)
    : HMCTargetStreamer(S), OS(OS) {}

void HMCTargetAsmStreamer::EmitBytes(StringRef Data) {

        OS << (unsigned)(unsigned char)Data[0] << "Testesssssssssssssss";

}


HMCTargetElfStreamer::HMCTargetElfStreamer(MCStreamer &S)
    : HMCTargetStreamer(S) {}

//void HMCTargetElfStreamer::EmitBytes(StringRef Data){


//}
