//===- HMC.td - Describe the HMC Target Machine ---------*- tblgen -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
// This is the top level entry point for the HMC target.
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//
// Target-independent interfaces
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Register File Description
//===----------------------------------------------------------------------===//

include "HMCRegisterInfo.td"
include "HMCSchedule.td"
include "HMCInstrInfo.td"

//===----------------------------------------------------------------------===//
// Calling Convention Description
//===----------------------------------------------------------------------===//

include "HMCCallingConv.td"

//===----------------------------------------------------------------------===//
// Instruction Descriptions
//===----------------------------------------------------------------------===//

def     HMCInstrInfo    :   InstrInfo;

// Without this will have error: 'hmc' is not a recognized processor for
//  this target (ignoring processor)
//===----------------------------------------------------------------------===//
// HMC Subtarget features                                                    //
//===----------------------------------------------------------------------===//

//def NoFeature     : SubtargetFeature<"hmc", "HMCArchVersion", "HMC", "HMC ISA Support", []>;

//===----------------------------------------------------------------------===//
// HMC supported processors.
//===----------------------------------------------------------------------===//
class Proc<string Name, SchedMachineModel Model, list<SubtargetFeature> Features>
: ProcessorModel<Name, Model, Features>;

def: Proc<"simple-64issue", Simple64Issue64MemModel, []>;

//def: Proc<"simple-32issue", Simple32Issue32MemModel, []>;

def HMCAsmParser : AsmParser {
    let ShouldEmitMatchRegisterName = 0;
}

def HMCAsmParserVariant : AsmParserVariant {
    int Variant = 0;
    // Recognize hard coded registers.
    string RegisterPrefix = "$";
}

//===----------------------------------------------------------------------===//
// Target Declaration
//===----------------------------------------------------------------------===//

def HMC : Target {
    let InstructionSet = HMCInstrInfo;
}
