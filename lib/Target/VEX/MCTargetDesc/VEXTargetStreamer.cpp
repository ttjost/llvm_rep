//===-- VEXTargetStreamer.cpp - VEX Target Streamer ----------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "VEXTargetStreamer.h"
#include "InstPrinter/VEXInstPrinter.h"
#include "llvm/Support/FormattedStream.h"

using namespace llvm;

VEXTargetStreamer::VEXTargetStreamer(MCStreamer &S) : MCTargetStreamer(S) {}

void VEXTargetStreamer::anchor() {}

void VEXTargetStreamer::EmitBytes(StringRef Data) {}


VEXTargetAsmStreamer::VEXTargetAsmStreamer(MCStreamer &S,
                                           formatted_raw_ostream &OS)
    : VEXTargetStreamer(S), OS(OS) {}

void VEXTargetAsmStreamer::EmitBytes(StringRef Data) {

        OS << (unsigned)(unsigned char)Data[0] << "Testesssssssssssssss";

}


VEXTargetElfStreamer::VEXTargetElfStreamer(MCStreamer &S)
    : VEXTargetStreamer(S) {}

//void VEXTargetElfStreamer::EmitBytes(StringRef Data){


//}
