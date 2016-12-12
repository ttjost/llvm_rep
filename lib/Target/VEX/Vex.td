//===- VEX.td - Describe the VEX Target Machine ---------*- tblgen -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
// This is the top level entry point for the VEX target.
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//
// Target-independent interfaces
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Register File Description
//===----------------------------------------------------------------------===//

include "VEXRegisterInfo.td"
include "VEXSchedule.td"
include "VEXInstrInfo.td"

//===----------------------------------------------------------------------===//
// Calling Convention Description
//===----------------------------------------------------------------------===//

include "VEXCallingConv.td"

//===----------------------------------------------------------------------===//
// Instruction Descriptions
//===----------------------------------------------------------------------===//

def     VEXInstrInfo    :   InstrInfo;

// Without this will have error: 'vex' is not a recognized processor for
//  this target (ignoring processor)
//===----------------------------------------------------------------------===//
// VEX Subtarget features                                                    //
//===----------------------------------------------------------------------===//

//def NoFeature     : SubtargetFeature<"VEX", "VEXArchVersion", "VEX", "VEX ISA Support", []>;

//===----------------------------------------------------------------------===//
// VEX supported processors.
//===----------------------------------------------------------------------===//
class Proc<string Name, SchedMachineModel Model, list<SubtargetFeature> Features>
: ProcessorModel<Name, Model, Features>;

def: Proc<"rvex-default", rVEX4IssueModel, []>;

def: Proc<"rvex-2issue", rVEX2IssueModel, []>;
def: Proc<"rvex-4issue", rVEX4IssueModel, []>;
def: Proc<"rvex-8issue", rVEX8IssueModel, []>;

def: Proc<"rvex-8issue-2spm", rVEX8Issue2CycleSPMModel, []>;

def: Proc<"rvex-2issue-1mem", rVEX2IssueModel, []>;
def: Proc<"rvex-4issue-1mem", rVEX4IssueModel, []>;
def: Proc<"rvex-8issue-1mem", rVEX8IssueModel, []>;

def: Proc<"rvex-4issue-2mem", rVEX4Issue2MemModel, []>;
def: Proc<"rvex-8issue-2mem", rVEX8Issue2MemModel, []>;

def: Proc<"rvex-generic", rVEXGenericModel, []>;

def: Proc<"simple-2issue", Simple2IssueModel, []>;
def: Proc<"simple-4issue", Simple4IssueModel, []>;
def: Proc<"simple-8issue", Simple8IssueModel, []>;

def: Proc<"simple-4issue-4mem", Simple4Issue4MemModel, []>;
def: Proc<"simple-8issue-4mem", Simple8Issue4MemModel, []>;
def: Proc<"simple-8issue-max", Simple8Issue8MemModel, []>;

def: Proc<"simple-8issue-2mem", Simple8Issue2MemModel, []>;



//#if CH >= CH11_1 1
def VEXAsmParser : AsmParser {
    let ShouldEmitMatchRegisterName = 0;
}

def VEXAsmParserVariant : AsmParserVariant {
    int Variant = 0;
    // Recognize hard coded registers.
    string RegisterPrefix = "$";
}
//#endif

//def: Proc<"simple-16issue-2mem-16spm", Simple16Issue2Mem16SPMModel, []>;

//def VEXInstrInfo : InstrInfo;

//===----------------------------------------------------------------------===//
// Target Declaration
//===----------------------------------------------------------------------===//

def VEX : Target {
    let InstructionSet = VEXInstrInfo;
}
