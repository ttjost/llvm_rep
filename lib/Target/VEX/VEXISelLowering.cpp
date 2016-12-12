//===-- VEXISelLowering.cpp - VEX DAG Lowering Implementation -----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that VEX uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#include "VEXISelLowering.h"

#include "VEXMachineFunctionInfo.h"
#include "VEXTargetMachine.h"
#include "VEXSubtarget.h"

#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/CallingConvLower.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/ValueTypes.h"
#include "llvm/IR/CallingConv.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "vex-lower"

extern cl::opt<bool> EnableSPMs;

static cl::opt<bool> UseDefaultSoftFloat("use-default-sfloat",
                                        cl::Hidden, cl::init(false),
                                        cl::desc("Which soft float library should be used? LLVM default or Berkeley SoftFloat?"));

#if 0
SDValue VEXTargetLowering::getTargetNode(ConstantPoolSDNode *N, EVT Ty,
                                          SelectionDAG &DAG,
                                          unsigned Flag) const {
    return DAG.getTargetConstantPool(N->getConstVal(), Ty, N->getAlignment(),
                                     N->getOffset(), Flag);
}
#endif

const char *VEXTargetLowering::getTargetNodeName(unsigned Opcode) const {

    switch (Opcode) {

        case VEXISD::WRAPPER:       return "VEXISD::WRAPPER";
        case VEXISD::PSEUDO_RET:    return "VEXISD::PSEUDO_RET";
        case VEXISD::PSEUDO_CALL:   return "VEXISD::PSEUDO_CALL";
        case VEXISD::PSEUDO_TAILCALL:   return "VEXISD::PSEUDO_TAILCALL";


        case VEXISD::MAX:           return "VEXISD::MAX";
        case VEXISD::MAXU:          return "VEXISD::MAXU";
        case VEXISD::MIN:           return "VEXISD::MIN";
        case VEXISD::MINU:          return "VEXISD::MINU";

        case VEXISD::ADDCG:         return "VEXISD::ADDCG";
        case VEXISD::DIVS:          return "VEXISD::DIVS";

        case VEXISD::ORC:           return "VEXISD::ORC";
        case VEXISD::SH1ADD:        return "VEXISD::SH1ADD";
        case VEXISD::SLCT:          return "VEXISD::SLCT";

        case VEXISD::MPYLL:         return "VEXISD::MPYLL";
        case VEXISD::MPYLLU:        return "VEXISD::MPYLLU";
        case VEXISD::MPYLH:         return "VEXISD::MPYLH";
        case VEXISD::MPYLHU:        return "VEXISD::MPYLHU";
        case VEXISD::MPYHH:         return "VEXISD::MPYHH";
        case VEXISD::MPYHHU:        return "VEXISD::MPYHHU";
        case VEXISD::MPYL:          return "VEXISD::MPYL";
        case VEXISD::MPYLU:         return "VEXISD::MPYLU";
        case VEXISD::MPYH:          return "VEXISD::MPYH";
        case VEXISD::MPYHU:         return "VEXISD::MPYHU";
        case VEXISD::MPYHS:         return "VEXISD::MPYHS";

        default:                return NULL;
    }
}

//@VEXTargetLowering
VEXTargetLowering::VEXTargetLowering(const TargetMachine &TM,
                                     const VEXSubtarget &STI)
: TargetLowering(TM), Subtarget(STI),
    FunctionReturns(make_unique<FunctionInfo>()),
    FunctionArguments(make_unique<FunctionInfo>()),
    FunctionCalled(make_unique<FunctionInfo>()) {
    //- Set .align 2
    // It will emit .align 2 later
      setMinFunctionAlignment(1);

    setBooleanContents(ZeroOrOneBooleanContent);
    addRegisterClass(MVT::i32, &VEX::GPRegsRegClass);
    addRegisterClass(MVT::i1, &VEX::BrRegsRegClass);


    // *************************************************
    // Single-precision floating-point arithmetic.

    TM.Options.NoNaNsFPMath = true;

    if (!UseDefaultSoftFloat) {
        setLibcallName(RTLIB::FPTOSINT_F64_I32, "float64_to_int32");
        setLibcallName(RTLIB::FPROUND_F64_F32, "float64_to_float32");
        setLibcallName(RTLIB::SINTTOFP_I32_F32, "int32_to_float32");
        setLibcallName(RTLIB::SINTTOFP_I32_F64, "int32_to_float64");
        setLibcallName(RTLIB::FPTOSINT_F32_I32, "float32_to_int32");
        setLibcallName(RTLIB::FPEXT_F32_F64, "float32_to_float64");

        // Single-precision comparisons.
        setLibcallName(RTLIB::ADD_F32, "float32_add");
        setLibcallName(RTLIB::SUB_F32, "float32_sub");
        setLibcallName(RTLIB::MUL_F32, "float32_mul");
        setLibcallName(RTLIB::DIV_F32, "float32_div");

        // Double-precision floating-point arithmetic.
        setLibcallName(RTLIB::ADD_F64, "float64_add");
        setLibcallName(RTLIB::SUB_F64, "float64_sub");
        setLibcallName(RTLIB::MUL_F64, "float64_mul");
        setLibcallName(RTLIB::DIV_F64, "float64_div");

        setLibcallName(RTLIB::OEQ_F32, "float32_eq");
        setLibcallName(RTLIB::OEQ_F64, "float64_eq");

        setLibcallName(RTLIB::UNE_F32, "float32_neq");
        setLibcallName(RTLIB::UNE_F64, "float64_neq");

        setLibcallName(RTLIB::OGE_F32, "float32_ge");
        setLibcallName(RTLIB::OGE_F64, "float64_ge");

        setLibcallName(RTLIB::OLT_F32, "float32_lt");
        setLibcallName(RTLIB::OLT_F64, "float64_lt");

        setLibcallName(RTLIB::OLE_F32, "float32_le");
        setLibcallName(RTLIB::OLE_F64, "float64_le");

        setLibcallName(RTLIB::OGT_F32, "float32_gt");
        setLibcallName(RTLIB::OGT_F64, "float64_gt");

        setCmpLibcallCC(RTLIB::OEQ_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::UNE_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OLT_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OLE_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OGE_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OGT_F32, ISD::SETNE);
        setCmpLibcallCC(RTLIB::UO_F32,  ISD::SETNE);
        setCmpLibcallCC(RTLIB::O_F32,   ISD::SETEQ);

        setCmpLibcallCC(RTLIB::OEQ_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::UNE_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OLT_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OLE_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OGE_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::OGT_F64, ISD::SETNE);
        setCmpLibcallCC(RTLIB::UO_F64,  ISD::SETNE);
        setCmpLibcallCC(RTLIB::O_F64,   ISD::SETEQ);

    }
    // *************************************************

    setOperationAction(ISD::SIGN_EXTEND_INREG, MVT::i1, Expand);

    // Load extented operations for i1 types must be promoted
    for (MVT VT : MVT::integer_valuetypes()) {
        setLoadExtAction(ISD::EXTLOAD,  VT, MVT::i1,  Promote);
        setLoadExtAction(ISD::ZEXTLOAD, VT, MVT::i1,  Promote);
        setLoadExtAction(ISD::SEXTLOAD, VT, MVT::i1,  Promote);
    }

    setOperationAction(ISD::LOAD, MVT::i1, Custom);
    setOperationAction(ISD::STORE, MVT::i1, Custom);

    setOperationAction(ISD::SDIV, MVT::i32, Custom);
    setOperationAction(ISD::UDIV, MVT::i32, Custom);
    setOperationAction(ISD::SREM, MVT::i32, Custom);
    setOperationAction(ISD::UREM, MVT::i32, Custom);

    // See LowerConstant to see the reason for customizing i1 ISD::Constant
    setOperationAction(ISD::Constant, MVT::i1, Custom);
    setOperationAction(ISD::TRUNCATE, MVT::i1, Promote);
    setOperationAction(ISD::SETCC, MVT::i1, Promote);
    setOperationAction(ISD::SELECT, MVT::i1, Promote);

    setOperationAction(ISD::SELECT_CC, MVT::i1, Promote);
    setOperationAction(ISD::SELECT_CC, MVT::i8, Promote);
    setOperationAction(ISD::SELECT_CC, MVT::i16, Promote);
    setOperationAction(ISD::SELECT_CC, MVT::i32, Expand);
    setOperationAction(ISD::SELECT_CC, MVT::Other, Expand);

    setOperationAction(ISD::MUL, MVT::i16, Promote);
    setOperationAction(ISD::MUL, MVT::i32, Custom);

    setOperationAction(ISD::SETCC, MVT::v4i1, Expand);
    setOperationAction(ISD::ZERO_EXTEND, MVT::v4i32, Expand);

    setOperationAction(ISD::ADD, MVT::i1, Promote);
    setOperationAction(ISD::XOR, MVT::i1, Promote);
    setOperationAction(ISD::OR, MVT::i1, Promote);
    setOperationAction(ISD::AND, MVT::i1, Promote);

    setOperationAction(ISD::BR_JT,            MVT::Other, Expand);
    setOperationAction(ISD::BRIND,            MVT::Other, Expand);

    setOperationAction(ISD::BR_CC, MVT::i1, Expand);
    setOperationAction(ISD::BR_CC, MVT::i8, Expand);
    setOperationAction(ISD::BR_CC, MVT::i16, Promote);
    setOperationAction(ISD::BR_CC, MVT::i32, Expand);
    setOperationAction(ISD::ROTL,  MVT::i32, Expand);
    setOperationAction(ISD::ROTR,  MVT::i32, Expand);

    setOperationAction(ISD::SHL_PARTS, MVT::i32, Expand);
    setOperationAction(ISD::SRA_PARTS, MVT::i32, Expand);
    setOperationAction(ISD::SRL_PARTS, MVT::i32, Expand);

    // Lower ADDE and ADDC
    setOperationAction(ISD::ADDE, MVT::i32, Custom);
    setOperationAction(ISD::ADDC, MVT::i32, Custom);
    setOperationAction(ISD::SUBE, MVT::i32, Custom);
    setOperationAction(ISD::SUBC, MVT::i32, Custom);

//    // 64-bit operations
    setOperationAction(ISD::ADD, MVT::i64, Expand);
    setOperationAction(ISD::SUB, MVT::i64, Expand);
    setOperationAction(ISD::OR, MVT::i64, Expand);
    setOperationAction(ISD::AND, MVT::i64, Expand);
    setOperationAction(ISD::XOR, MVT::i64, Expand);
    setOperationAction(ISD::SRA, MVT::i64, Expand);
    setOperationAction(ISD::SRL, MVT::i64, Expand);

    // Lower
    setOperationAction(ISD::SMUL_LOHI, MVT::i32, Expand);
    setOperationAction(ISD::UMUL_LOHI, MVT::i32, Expand);

    setOperationAction(ISD::MULHU, MVT::i32, Custom);
    setOperationAction(ISD::MULHS, MVT::i32, Custom);
    setOperationAction(ISD::UMULO, MVT::i32, Custom);
    setOperationAction(ISD::SMULO, MVT::i32, Custom);

    setOperationAction(ISD::BSWAP, MVT::i32, Expand);

    // VASTART needs to be custom lowered to use the VarArgsFrameIndex.
    setOperationAction(ISD::VASTART, MVT::Other, Custom);

    // Use the default implementation.
    setOperationAction(ISD::VAARG, MVT::Other, Expand);
    setOperationAction(ISD::VACOPY, MVT::Other, Expand);
    setOperationAction(ISD::VAEND, MVT::Other, Expand);

    setOperationAction(ISD::GlobalAddress, MVT::i8, Promote);
    setOperationAction(ISD::GlobalAddress, MVT::i16, Promote);
    setOperationAction(ISD::GlobalAddress, MVT::i32, Custom);
    setOperationAction(ISD::ExternalSymbol, MVT::i8, Promote);
    setOperationAction(ISD::ExternalSymbol, MVT::i16, Promote);
    setOperationAction(ISD::ExternalSymbol, MVT::i32, Custom);

    setOperationAction(ISD::CTTZ,  MVT::i32, Expand);
    setOperationAction(ISD::CTPOP,  MVT::i32, Expand);
    setOperationAction(ISD::CTLZ,  MVT::i32, Expand);
    setOperationAction(ISD::CTTZ_ZERO_UNDEF  , MVT::i32  , Expand);
    setOperationAction(ISD::CTLZ_ZERO_UNDEF  , MVT::i32  , Expand);

    // Perform DAG Combination of certain instructions
    setTargetDAGCombine(ISD::SELECT);

    setStackPointerRegisterToSaveRestore(VEX::Reg1);

    // This should be enable when we implement the VLIW Packetizer
//    if (EnableSPMs)
//        setSchedulingPreference(Sched::Source);
//    else
        setSchedulingPreference(Sched::VLIW);

    // must, computeRegisterProperties - Once all of the register classes are
    //  added, this allows us to compute derived properties we expose.
    computeRegisterProperties(STI.getRegisterInfo());
}

SDValue VEXTargetLowering::LowerOperation(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "Lower Operation\n");
    switch (Op.getOpcode()) {
        case ISD::GlobalAddress:        return LowerGlobalAddress(Op, DAG);
        case ISD::ExternalSymbol:       return LowerExternalSymbol(Op, DAG);
        case ISD::Constant:             return LowerConstant(Op, DAG);
        case ISD::UMULO:
        case ISD::SMULO:
        case ISD::MULHS:                return LowerMULHS(Op, DAG);
        case ISD::MULHU:                return LowerMULHU(Op, DAG);
        case ISD::MUL:                  return LowerMUL(Op, DAG);
        case ISD::SUBE:
        case ISD::SUBC:
        case ISD::ADDE:
        case ISD::ADDC:                 return LowerADDSUBWithFlags(Op, DAG);
        case ISD::UDIV:                 return LowerUDIV(Op, DAG);
        case ISD::SDIV:                 return LowerSDIV(Op, DAG);
        case ISD::UREM:                 return LowerUREM(Op, DAG);
        case ISD::SREM:                 return LowerSREM(Op, DAG);
        case ISD::LOAD:                 return LowerLOAD(Op, DAG);
        case ISD::STORE:                return LowerSTORE(Op, DAG);
        case ISD::VASTART:              return LowerVASTART(Op, DAG);
        case ISD::RETURNADDR:         return LowerRETURNADDR(Op, DAG);
        case ISD::FRAMEADDR:          return LowerFRAMEADDR(Op, DAG);
        default:
            break;
    }

    return Op;

}

//===----------------------------------------------------------------------===//
//                       MSP430 Inline Assembly Support
//===----------------------------------------------------------------------===//

/// getConstraintType - Given a constraint letter, return the type of
/// constraint it is for this target.
TargetLowering::ConstraintType
VEXTargetLowering::getConstraintType(const std::string &Constraint) const {
    if (Constraint.size() == 1) {
        switch (Constraint[0]) {
            case 'r':
                return C_RegisterClass;
            default:
                break;
        }
    }
    return TargetLowering::getConstraintType(Constraint);
}

std::pair<unsigned, const TargetRegisterClass *>
VEXTargetLowering::getRegForInlineAsmConstraint(const TargetRegisterInfo *TRI,
                                                const std::string &Constraint,
                                                MVT VT) const {
    if (Constraint.size() == 1) {
        // GCC Constraint Letters
        switch (Constraint[0]) {
            default: break;
            case 'r':   // GENERAL_REGS
                if (VT == MVT::i32)
                    return std::make_pair(0U, &VEX::GPRegsRegClass);
                return std::make_pair(0U, &VEX::BrRegsRegClass);
        }
    }

    return TargetLowering::getRegForInlineAsmConstraint(TRI, Constraint, VT);
}

bool VEXTargetLowering::isOffsetFoldingLegal(const GlobalAddressSDNode *GA) const {
    // The VEX Target isn't yet aware of offsets.
    return false;
}

//===----------------------------------------------------------------------===//
//  Misc Lower Operation implementation
//===----------------------------------------------------------------------===//

#include "VEXGenCallingConv.inc"

//===----------------------------------------------------------------------===//
//  Lower helper functions
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//                              Auxiliar methods
//===----------------------------------------------------------------------===//
static void AnalyzeRetResult(CCState &State,
                             const SmallVectorImpl<ISD::InputArg> &Ins){
    State.AnalyzeCallResult(Ins, RetCC_VEX);
}

static void AnalyzeRetResult(CCState &State,
                             const SmallVectorImpl<ISD::OutputArg> &Outs){
    State.AnalyzeReturn(Outs, RetCC_VEX);
}

template<typename ArgT>
static void AnalyzeReturnValues(CCState &State,
                                SmallVectorImpl<CCValAssign> &RVLocs,
                                const SmallVectorImpl<ArgT> &Args){
    AnalyzeRetResult(State, Args);
}

// Value is a value that has been passed to us in the location described by VA
// (and so has type VA.getLocVT()).  Convert Value to VA.getValVT(), chaining
// any loads onto Chain.
// TODO: Is that really neccessary?
static SDValue convertLocVTToValVT(SelectionDAG &DAG, SDLoc DL,
                                   CCValAssign &VA, SDValue Chain,
                                   SDValue Value){
    // If the argument has been promoted from a smaller type,
    // insert an assertion to capture this.
    if (VA.getLocInfo() == CCValAssign::SExt)
        Value = DAG.getNode(ISD::AssertSext, DL, VA.getLocVT(), Value,
                            DAG.getValueType(VA.getValVT()));
   else if (VA.getLocInfo() == CCValAssign::ZExt)
            Value = DAG.getNode(ISD::AssertZext, DL, VA.getLocVT(), Value,
                                DAG.getValueType(VA.getValVT()));

    if (VA.isExtInLoc())
        Value = DAG.getNode(ISD::TRUNCATE, DL, VA.getValVT(), Value);
    else if (VA.getLocInfo() == CCValAssign::Indirect)
        Value = DAG.getLoad(VA.getValVT(), DL, Chain, Value,
                            MachinePointerInfo(), false, false, false, 0);
    else
//        if (VA.getLocInfo() == CCValAssign::BCvt) {
//            // If this is a short vector argument loaded from the stack,
//            // extend from i64 to full vector size and then bitcast.
//            assert(VA.getLocVT() == MVT::i64);
//            assert(VA.getValVT().isVector());
//            Value = DAG.getNode(ISD::BUILD_VECTOR, DL, MVT::v2i64,
//                                Value, DAG.getUNDEF(MVT::i64));
//            Value = DAG.getNode(ISD::BITCAST, DL, VA.getValVT(), Value);
//        } else
            assert(VA.getLocInfo() == CCValAssign::Full && "Unsupported getLocInfo");

    return Value;
}

// Value is a value of type VA.getValVT() that we need to copy into
// the location described by VA.  Return a copy of Value converted to
// VA.getValVT().  The caller is responsible for handling indirect values.
static SDValue convertValVTToLocVT(SelectionDAG &DAG, SDLoc DL,
                                   CCValAssign &VA, SDValue Value) {


    switch (VA.getLocInfo()) {
    case CCValAssign::SExt:
        return DAG.getNode(ISD::SIGN_EXTEND, DL, VA.getLocVT(), Value);
    case CCValAssign::ZExt:
        return DAG.getNode(ISD::ZERO_EXTEND, DL, VA.getLocVT(), Value);
    case CCValAssign::AExt:
        return DAG.getNode(ISD::ANY_EXTEND, DL, VA.getLocVT(), Value);
    case CCValAssign::Full:
        return Value;
    default:
        llvm_unreachable("Cannot convert type!");
    }
}

/// IsEligibleForTailCallOptimization - Check whether the call is eligible
/// for tail call optimization. Targets which want to do tail call
/// optimization should implement this function.
bool VEXTargetLowering::IsEligibleForTailCallOptimization(SDValue Callee,
                                                              CallingConv::ID CalleeCC,
                                                              bool isVarArg,
                                                              bool isCalleeStructRet,
                                                              bool isCallerStructRet,
                                                              const SmallVectorImpl<ISD::OutputArg> &Outs,
                                                              const SmallVectorImpl<SDValue> &OutVals,
                                                              const SmallVectorImpl<ISD::InputArg> &Ins,
                                                              SelectionDAG& DAG) const {
    const Function *CallerF = DAG.getMachineFunction().getFunction();
    CallingConv::ID CallerCC = CallerF->getCallingConv();
    bool CCMatch = CallerCC == CalleeCC;

    // ***************************************************************************
    //  Look for obvious safe cases to perform tail call optimization that do not
    //  require ABI changes.
    // ***************************************************************************

    // If this is a tail call via a function pointer, then don't do it!
    if (!(dyn_cast<GlobalAddressSDNode>(Callee))
        && !(dyn_cast<ExternalSymbolSDNode>(Callee))) {
        return false;
    }

    // Do not optimize if the calling conventions do not match.
    if (!CCMatch)
        return false;

    // Do not tail call optimize vararg calls.
    if (isVarArg)
        return false;

    // Also avoid tail call optimization if either caller or callee uses struct
    // return semantics.
    if (isCalleeStructRet || isCallerStructRet)
        return false;

    // In addition to the cases above, we also disable Tail Call Optimization if
    // the calling convention code that at least one outgoing argument needs to
    // go on the stack. We cannot check that here because at this point that
    // information is not available.
    return true;
}

SDValue
VEXTargetLowering::LowerRETURNADDR(SDValue Op, SelectionDAG &DAG) const {
    const VEXRegisterInfo *TRI = Subtarget.getRegisterInfo();
    MachineFunction &MF = DAG.getMachineFunction();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    MFI->setReturnAddressIsTaken(true);

    if (verifyReturnAddressArgumentIsConstant(Op, DAG))
        return SDValue();

    EVT VT = Op.getValueType();
    SDLoc dl(Op);
    unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
    if (Depth) {
        SDValue FrameAddr = LowerFRAMEADDR(Op, DAG);
        SDValue Offset = DAG.getConstant(4, dl, MVT::i32);
        return DAG.getLoad(VT, dl, DAG.getEntryNode(),
                           DAG.getNode(ISD::ADD, dl, VT, FrameAddr, Offset),
                           MachinePointerInfo(), false, false, false, 0);
    }

    // Return LR, which contains the return address. Mark it an implicit live-in.
    unsigned Reg = MF.addLiveIn(TRI->getRARegister(), getRegClassFor(MVT::i32));
    return DAG.getCopyFromReg(DAG.getEntryNode(), dl, Reg, VT);
}

SDValue
VEXTargetLowering::LowerFRAMEADDR(SDValue Op, SelectionDAG &DAG) const {
    const VEXRegisterInfo *TRI = Subtarget.getRegisterInfo();
    MachineFrameInfo *MFI = DAG.getMachineFunction().getFrameInfo();
    MFI->setFrameAddressIsTaken(true);

    EVT VT = Op.getValueType();
    SDLoc dl(Op);
    unsigned Depth = cast<ConstantSDNode>(Op.getOperand(0))->getZExtValue();
    SDValue FrameAddr = DAG.getCopyFromReg(DAG.getEntryNode(), dl,
                                           VEX::Reg1, VT);
    while (Depth--)
        FrameAddr = DAG.getLoad(VT, dl, DAG.getEntryNode(), FrameAddr,
                                MachinePointerInfo(),
                                false, false, false, 0);
    return FrameAddr;
}

SDValue
VEXTargetLowering::LowerCall(CallLoweringInfo &CLI,
            SmallVectorImpl<SDValue> &InVals) const {

    DEBUG(errs() << "LowerCall\n");

    SelectionDAG &DAG = CLI.DAG;

    const DataLayout &DLayout = DAG.getDataLayout();

    SDLoc &DL = CLI.DL;
    SmallVectorImpl<ISD::OutputArg> &Outs = CLI.Outs;
    SmallVectorImpl<SDValue> &OutVals = CLI.OutVals;
    SmallVectorImpl<ISD::InputArg> &Ins = CLI.Ins;
    SDValue Chain = CLI.Chain;
    SDValue Callee = CLI.Callee;
    CallingConv::ID CallConv = CLI.CallConv;
    bool IsVarArg = CLI.IsVarArg;
    MachineFunction &MF = DAG.getMachineFunction();
    EVT PtrVT = getPointerTy(DLayout);
    bool &IsTailCall = CLI.IsTailCall;

    VEXFunctionInfo *FuncInfo = MF.getInfo<VEXFunctionInfo>();
//    bool IsTailCall = false;

    bool IsStructRet    = (Outs.empty()) ? false : Outs[0].Flags.isSRet();

    if (IsStructRet)
        errs() << "WARNING: Functions has StructRet which is not guaranteed to work properly. Use \"-freg-struct-return\" option in clang to remove this feature\n";

    // Analyze the operands of the call, assigning locations to each operand.
    SmallVector<CCValAssign, 16> ArgLocs;
    CCState ArgCCInfo(CallConv, IsVarArg, MF, ArgLocs, *DAG.getContext());

    auto *TFL = static_cast<const VEXFrameLowering *>(Subtarget.getFrameLowering());

    // If need, arguments on stack should be place after ScratchPad Area
    //ArgCCInfo.AllocateStack(TFL->getScratchArea(), 1);

    ArgCCInfo.AnalyzeCallOperands(Outs, CC_VEX_Address);

    // Get a count of how many bytes are to be pushed on to the stack.
    unsigned NumBytes = ArgCCInfo.getNextStackOffset();

    if(IsTailCall) {
        bool StructAttrFlag =
        DAG.getMachineFunction().getFunction()->hasStructRetAttr();
        IsTailCall = IsEligibleForTailCallOptimization(Callee, CallConv,
                                                       IsVarArg, IsStructRet,
                                                       StructAttrFlag,
                                                       Outs, OutVals, Ins, DAG);
        for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
            CCValAssign &VA = ArgLocs[i];
            if (VA.isMemLoc()) {
                IsTailCall = false;
                break;
            }
        }
        if (IsTailCall) {
            DEBUG(dbgs () << "Eligible for Tail Call\n");
        } else {
            DEBUG(dbgs () <<
                  "Argument must be passed on stack. Not eligible for Tail Call\n");
        }
    }

    // Mark the start of the call.
    if (!IsTailCall)
        Chain = DAG.getCALLSEQ_START(Chain,
                                     DAG.getConstant(NumBytes, DL, PtrVT, true),
                                     DL);
//    else
//        llvm_unreachable("Target does not yet support Tail Calls.");

    // Copy argument values to their designated locations.
    SmallVector<std::pair<unsigned, SDValue>, 10> RegsToPass;
    SmallVector<SDValue, 8> MemOpChains;
    SDValue StackPtr =
            DAG.getCopyFromReg(Chain, DL, VEX::Reg1, getPointerTy(DLayout));;

    const GlobalAddressSDNode *GlobalNode = dyn_cast<GlobalAddressSDNode>(Callee);
    const ExternalSymbolSDNode *ExtSymbNode = dyn_cast<ExternalSymbolSDNode>(Callee);

    if (GlobalNode != nullptr) {
        if (GlobalNode->getGlobal()->hasName()) {
            DEBUG(dbgs() << GlobalNode->getGlobal()->getName() << ": "<< ArgLocs.size() << "\n");
            addFunctionCalled(GlobalNode->getGlobal()->getName().str(), (unsigned)ArgLocs.size(), IsVarArg);
        } else {
            DEBUG(dbgs() << "No name: "<< ArgLocs.size() << "\n");
        }
    } else {
        if (ExtSymbNode != nullptr) {
            DEBUG(dbgs() << ExtSymbNode->getSymbol() << ": "<< ArgLocs.size() << "\n");
            addFunctionCalled(std::string(ExtSymbNode->getSymbol()), (unsigned)ArgLocs.size(), IsVarArg);
        }
    }

    for (unsigned I = 0, E = ArgLocs.size(); I != E; ++I){
        CCValAssign &VA = ArgLocs[I];
        SDValue ArgValue = OutVals[I];

        if (VA.getLocInfo() == CCValAssign::Indirect) {

            if (!IsTailCall) {
            // Store the argument in a stack slot and pass its address.
            SDValue SpillSlot = DAG.CreateStackTemporary(VA.getValVT());
            int FI = cast<FrameIndexSDNode>(SpillSlot)->getIndex();
            MemOpChains.push_back(DAG.getStore(Chain, DL, ArgValue, SpillSlot,
                                               MachinePointerInfo::getFixedStack(FI),
                                               false, false, 0));
            ArgValue = SpillSlot;
            } else {
                MachineFrameInfo *MFI = DAG.getMachineFunction().getFrameInfo();
                int FI = MFI->CreateFixedObject(ArgValue.getValueSizeInBits() / 8, VA.getLocMemOffset(), false);
                SDValue FIN = DAG.getFrameIndex(FI, getPointerTy(DLayout));
                return DAG.getStore(Chain, DL, ArgValue, FIN, MachinePointerInfo(),
                                    /*isVolatile=*/ true, false, 0);
            }
        }else
            ArgValue = convertValVTToLocVT(DAG, DL, VA, ArgValue);

        if (VA.isRegLoc())
            // Queue up the argument copies and emit them at the end.
            RegsToPass.push_back(std::make_pair(VA.getLocReg(), ArgValue));
        else{
            assert(VA.isMemLoc() && "Argument not register or memory");

            ISD::ArgFlagsTy Flags = Outs[I].Flags;

            unsigned LocMemOffset = VA.getLocMemOffset();
            SDValue PtrOff = DAG.getConstant(LocMemOffset + TFL->getScratchArea(), DL, StackPtr.getValueType());
            PtrOff = DAG.getNode(ISD::ADD, DL, MVT::i32, StackPtr, PtrOff );

            if (Flags.isByVal()) {
                unsigned FirstByValReg, LastByValReg;
                unsigned ByValIdx = ArgCCInfo.getInRegsParamsProcessed();
                ArgCCInfo.getInRegsParamInfo(ByValIdx, FirstByValReg, LastByValReg);

                assert(Flags.getByValSize() &&
                       "ByVal args of size 0 should have been ignored by front-end.");
                assert(ByValIdx < ArgCCInfo.getInRegsParamsCount());
                assert(!IsTailCall &&
                       "Do not tail-call optimize if there is a byval argument.");
                passByValArg(Chain, DL, RegsToPass, MemOpChains, StackPtr, MF.getFrameInfo(), DAG, ArgValue,
                             FirstByValReg, LastByValReg, Flags, VA);
                ArgCCInfo.nextInRegsParam();
                continue;
            } else {
                // The argument is not passed by value. "Arg" is a buildin type. It is
                // not a pointer.
                MemOpChains.push_back(DAG.getStore(Chain, DL, ArgValue, PtrOff,
                                                   MachinePointerInfo(),false, false,
                                                   0));
            }
            continue;

        }
    }

    // Join the stores, which are independent of one another.
    if (!MemOpChains.empty())
        Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, MemOpChains);

    // Accept direct calls by converting symbolic call address to the
    // associated Target* opcodes.
    SDValue Glue;
    if (auto *G = dyn_cast<GlobalAddressSDNode>(Callee)) {
        Callee = DAG.getTargetGlobalAddress(G->getGlobal(), DL, MVT::i32);
        Callee = DAG.getNode(VEXISD::WRAPPER, DL, PtrVT, Callee);
    }else if (auto *E = dyn_cast<ExternalSymbolSDNode>(Callee)) {
        //llvm_unreachable("Target does not implement External Symbol yet!");
        Callee = DAG.getTargetExternalSymbol(E->getSymbol(), MVT::i32);
        Callee = DAG.getNode(VEXISD::WRAPPER, DL, PtrVT, Callee);
    } else if (IsTailCall) {
        llvm_unreachable("Target does not implement tail calls!");
    }

    // Build a sequence of copy-to-reg nodes, chained and glued together.
    if (!IsTailCall) {
        for (unsigned I = 0, E = RegsToPass.size(); I != E; ++I) {
            Chain = DAG.getCopyToReg(Chain, DL, RegsToPass[I].first,
                                     RegsToPass[I].second, Glue);
            Glue = Chain.getValue(1);
        }
    }

    // For tail calls lower the arguments to the 'real' stack slot.
    if (IsTailCall) {
        // Force all the incoming stack arguments to be loaded from the stack
        // before any new outgoing arguments are stored to the stack, because the
        // outgoing stack slots may alias the incoming argument stack slots, and
        // the alias isn't otherwise explicit. This is slightly more conservative
        // than necessary, because it means that each store effectively depends
        // on every argument instead of just those arguments it would clobber.
        //
        // Do not flag preceding copytoreg stuff together with the following stuff.
        Glue = SDValue();
        for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i) {
            Chain = DAG.getCopyToReg(Chain, DL, RegsToPass[i].first,
                                     RegsToPass[i].second, Glue);
            Glue = Chain.getValue(1);
        }
        Glue = SDValue();
    }

    // The first call operand is the chain and the second is the target address.
    SmallVector<SDValue, 8> Ops;
    Ops.push_back(Chain);
    Ops.push_back(Callee);

    // Add argument registers to the end of the list so that they are
    // known live into the call.
    for (unsigned I = 0, E = RegsToPass.size(); I != E; ++I)
        Ops.push_back(DAG.getRegister(RegsToPass[I].first,
                                      RegsToPass[I].second.getValueType()));

    // Add a register mask operand representing the call-preserved registers.
    const VEXRegisterInfo *TRI = Subtarget.getRegisterInfo();
    const uint32_t *Mask = TRI->getCallPreservedMask(CallConv);
    assert (Mask && "Missing call preserved mask for calling convention");
    Ops.push_back(DAG.getRegisterMask(Mask));

//    // Glue the call to the argument copies, if any.
    if (Glue.getNode())
        Ops.push_back(Glue);

    // Emit the Call.
    SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);

    // Even though we do not use this for tail call,
    // we still need to know how many values this function return
    // Assign locations to each value returned by this call.
    SmallVector<CCValAssign, 16> RetLocs;
    CCState RetCCInfo(CallConv, IsVarArg, MF, RetLocs, *DAG.getContext());

    AnalyzeRetResult(RetCCInfo, Ins);

    if (IsTailCall) {

        // When we have tail calls, we can assume that both callee and caller
        // have the same number of return values. This is a known property of tail calls.
        if (GlobalNode != nullptr) {
            if (GlobalNode->getGlobal()->hasName()) {
                DEBUG(dbgs() << GlobalNode->getGlobal()->getName() << ": "<< RetLocs.size() << "\n");
                addFunctionReturn(MF.getName().str(), (unsigned)RetLocs.size());
                addFunctionReturn(GlobalNode->getGlobal()->getName().str(), (unsigned)RetLocs.size());
            } else {
                DEBUG(dbgs() << "No name: "<< RetLocs.size() << "\n");
            }
        } else {
            if (ExtSymbNode != nullptr) {
                DEBUG(dbgs() << ExtSymbNode->getSymbol() << ": "<< RetLocs.size() << "\n");
                addFunctionReturn(MF.getName().str(), (unsigned)RetLocs.size());
                addFunctionReturn(std::string(ExtSymbNode->getSymbol()), (unsigned)RetLocs.size());
            }
        }

        return DAG.getNode(VEXISD::PSEUDO_TAILCALL, DL, NodeTys, Ops);
    }

    Chain = DAG.getNode(VEXISD::PSEUDO_CALL, DL, NodeTys, Ops);
    Glue = Chain.getValue(1);

    // Mark the end of the call, which is glued to the call itself.
    Chain = DAG.getCALLSEQ_END(Chain,
                               DAG.getConstant(NumBytes, DL, PtrVT, true),
                               DAG.getConstant(0, DL, PtrVT, true),
                               Glue, DL);
    Glue = Chain.getValue(1);

    // Copy all of the result registers out of their specified physreg.
    for (unsigned I = 0, E = RetLocs.size(); I != E; ++I) {
        CCValAssign &VA = RetLocs[I];

        // Copy the value out, gluing the copy to the end of the call sequence.
        SDValue RetValue = DAG.getCopyFromReg(Chain, DL, VA.getLocReg(),
                                   VA.getValVT(), Glue);
        Chain = RetValue.getValue(1);
        Glue = RetValue.getValue(2);

        // Convert the value of the return register into the value that's
        // being returned.
        InVals.push_back(convertLocVTToValVT(DAG, DL, VA, Chain, RetValue));
    }

    if (GlobalNode != nullptr) {
        if (GlobalNode->getGlobal()->hasName()) {
            DEBUG(dbgs() << GlobalNode->getGlobal()->getName() << ": "<< RetLocs.size() << "\n");
            addFunctionReturn(GlobalNode->getGlobal()->getName().str(), (unsigned)RetLocs.size());
        } else {
            DEBUG(dbgs() << "No name: "<< RetLocs.size() << "\n");
        }
    } else {
        if (ExtSymbNode != nullptr) {
            DEBUG(dbgs() << ExtSymbNode->getSymbol() << ": "<< RetLocs.size() << "\n");
            addFunctionReturn(std::string(ExtSymbNode->getSymbol()), (unsigned)RetLocs.size());
        }
    }

    return Chain;
}

// Copy byVal arg to registers and stack.
void VEXTargetLowering::passByValArg(SDValue Chain, SDLoc DL,
                                      SmallVector<std::pair<unsigned, SDValue>, 10> RegsToPass,
                                      SmallVectorImpl<SDValue> &MemOpChains, SDValue StackPtr,
                                      MachineFrameInfo *MFI, SelectionDAG &DAG, SDValue Arg, unsigned FirstReg,
                                      unsigned LastReg, const ISD::ArgFlagsTy &Flags,
                                      const CCValAssign &VA) const {
    unsigned ByValSizeInBytes = Flags.getByValSize();
    unsigned OffsetInBytes = 0; // From beginning of struct
    unsigned RegSizeInBytes = 4;
    const DataLayout &DLayout = DAG.getDataLayout();
    unsigned Alignment = std::min(Flags.getByValAlign(), RegSizeInBytes);
    EVT PtrTy = getPointerTy(DLayout), RegTy = MVT::getIntegerVT(RegSizeInBytes * 8);
    unsigned NumRegs = LastReg - FirstReg;

    if (NumRegs) {
        const ArrayRef<MCPhysReg> ArgRegs = { VEX::Reg3, VEX::Reg4, VEX::Reg5, VEX::Reg6, VEX::Reg7, VEX::Reg8, VEX::Reg9, VEX::Reg10 };
        bool LeftoverBytes = (NumRegs * RegSizeInBytes > ByValSizeInBytes);
        unsigned I = 0;

        // Copy words to registers.
        for (; I < NumRegs - LeftoverBytes; ++I, OffsetInBytes += RegSizeInBytes) {
            SDValue LoadPtr = DAG.getNode(ISD::ADD, DL, PtrTy, Arg,
                                          DAG.getConstant(OffsetInBytes, DL, PtrTy));
            SDValue LoadVal = DAG.getLoad(RegTy, DL, Chain, LoadPtr,
                                          MachinePointerInfo(), false, false, false,
                                          Alignment);
            MemOpChains.push_back(LoadVal.getValue(1));
            unsigned ArgReg = ArgRegs[FirstReg + I];
            RegsToPass.push_back(std::make_pair(ArgReg, LoadVal));
        }

        // Return if the struct has been fully copied.
        if (ByValSizeInBytes == OffsetInBytes)
            return;

        // Copy the remainder of the byval argument with sub-word loads and shifts.
        if (LeftoverBytes) {
            SDValue Val;

            for (unsigned LoadSizeInBytes = RegSizeInBytes / 2, TotalBytesLoaded = 0;
                 OffsetInBytes < ByValSizeInBytes; LoadSizeInBytes /= 2) {
                unsigned RemainingSizeInBytes = ByValSizeInBytes - OffsetInBytes;

                if (RemainingSizeInBytes < LoadSizeInBytes)
                    continue;

                // Load subword.
                SDValue LoadPtr = DAG.getNode(ISD::ADD, DL, PtrTy, Arg,
                                              DAG.getConstant(OffsetInBytes, DL, PtrTy));
                SDValue LoadVal = DAG.getExtLoad(
                                                 ISD::ZEXTLOAD, DL, RegTy, Chain, LoadPtr, MachinePointerInfo(),
                                                 MVT::getIntegerVT(LoadSizeInBytes * 8), false, false, false,
                                                 Alignment);
                MemOpChains.push_back(LoadVal.getValue(1));

                // Shift the loaded value.
                unsigned Shamt = (RegSizeInBytes - (TotalBytesLoaded + LoadSizeInBytes)) * 8;

                SDValue Shift = DAG.getNode(ISD::SHL, DL, RegTy, LoadVal,
                                            DAG.getConstant(Shamt, DL, MVT::i32));

                if (Val.getNode())
                    Val = DAG.getNode(ISD::OR, DL, RegTy, Val, Shift);
                else
                    Val = Shift;

                OffsetInBytes += LoadSizeInBytes;
                TotalBytesLoaded += LoadSizeInBytes;
                Alignment = std::min(Alignment, LoadSizeInBytes);
            }

            unsigned ArgReg = ArgRegs[FirstReg + I];
            RegsToPass.push_back(std::make_pair(ArgReg, Val));
            return;
        }
    }

    // Copy remainder of byval arg to it with memcpy.
    unsigned MemCpySize = ByValSizeInBytes - OffsetInBytes;
    SDValue Src = DAG.getNode(ISD::ADD, DL, PtrTy, Arg,
                              DAG.getConstant(OffsetInBytes, DL, PtrTy));
    SDValue Dst = DAG.getNode(ISD::ADD, DL, PtrTy, StackPtr,
                              DAG.getIntPtrConstant(VA.getLocMemOffset(), DL));
    Chain = DAG.getMemcpy(Chain, DL, Dst, Src, DAG.getConstant(MemCpySize, DL, PtrTy),
                          Alignment, /*isVolatile=*/false, /*AlwaysInline=*/false,
                          /*isTailCall=*/false,
                          MachinePointerInfo(), MachinePointerInfo());
    MemOpChains.push_back(Chain);
}


void VEXTargetLowering::copyByValRegs(SDValue Chain, SDLoc DL, std::vector<SDValue> &OutChains, SelectionDAG &DAG,
                                       const ISD::ArgFlagsTy &Flags, SmallVectorImpl<SDValue> &InVals,
                                       const Argument *FuncArg, unsigned FirstReg, unsigned LastReg,
                                       const CCValAssign &VA,
                                        MachineRegisterInfo &MRI) const {

    MachineFunction &MF = DAG.getMachineFunction();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    unsigned GPRSizeInBytes = 4;
    unsigned NumRegs = LastReg - FirstReg;
    unsigned RegAreaSize = NumRegs * GPRSizeInBytes;
    unsigned FrameObjSize = std::max(Flags.getByValSize(), RegAreaSize);

    int FrameObjOffset;
    ArrayRef<MCPhysReg> ByValArgRegs = { VEX::Reg3, VEX::Reg4, VEX::Reg5, VEX::Reg6, VEX::Reg7, VEX::Reg8, VEX::Reg9, VEX::Reg10 };

    if (RegAreaSize)
        FrameObjOffset = VA.getLocMemOffset();

    const DataLayout &DLayout = DAG.getDataLayout();
    // Create frame object.
    EVT PtrTy = getPointerTy(DLayout);
    int FI = MFI->CreateFixedObject(FrameObjSize, FrameObjOffset, true);
    SDValue FIN = DAG.getFrameIndex(FI, PtrTy);
    InVals.push_back(FIN);

    if (!NumRegs)
        return;

    // Copy arg registers.
    MVT RegTy = MVT::getIntegerVT(GPRSizeInBytes * 8);
    const TargetRegisterClass *RC = getRegClassFor(RegTy);

    for (unsigned I = 0; I < NumRegs; ++I) {
        unsigned ArgReg = ByValArgRegs[FirstReg + I];

        unsigned VReg = MF.getRegInfo().createVirtualRegister(RC);
        MRI.addLiveIn(ArgReg, VReg);
        unsigned Offset = I * GPRSizeInBytes;
        SDValue StorePtr = DAG.getNode(ISD::ADD, DL, PtrTy, FIN,
                                       DAG.getConstant(Offset, DL, PtrTy));
        SDValue Store = DAG.getStore(Chain, DL, DAG.getRegister(VReg, RegTy),
                                     StorePtr, MachinePointerInfo(FuncArg, Offset),
                                     false, false, 0);
        OutChains.push_back(Store);
    }
}

void VEXTargetLowering::writeVarArgRegs(std::vector<SDValue> &OutChains,
                                         SDValue Chain, SDLoc DL,
                                         SelectionDAG &DAG,
                                         CCState &State,
                                         MachineRegisterInfo &MRI) const {
    const ArrayRef<MCPhysReg> ArgRegs = { VEX::Reg3, VEX::Reg4, VEX::Reg5, VEX::Reg6, VEX::Reg7, VEX::Reg8, VEX::Reg9, VEX::Reg10 };
    unsigned Idx = State.getFirstUnallocated(ArgRegs);
    unsigned RegSizeInBytes = 4;
    MVT RegTy = MVT::getIntegerVT(RegSizeInBytes * 8);
    const TargetRegisterClass *RC = getRegClassFor(RegTy);
    MachineFunction &MF = DAG.getMachineFunction();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    VEXFunctionInfo *VEXFI = MF.getInfo<VEXFunctionInfo>();


    const DataLayout &DLayout = DAG.getDataLayout();
    // Offset of the first variable argument from stack pointer.
    int VaArgOffset;

//    if (ArgRegs.size() == Idx)
        VaArgOffset =
        RoundUpToAlignment(State.getNextStackOffset(), 4);

    //VaArgOffset -= 4;

    // Record the frame index of the first variable argument
    // which is a value necessary to VASTART.
    int FI = MFI->CreateFixedObject(4, VaArgOffset, true);
    VEXFI->setVarArgsFrameIndex(FI);

    for (unsigned I = Idx; I < ArgRegs.size();
         ++I, VaArgOffset += RegSizeInBytes) {
        unsigned Reg = ArgRegs[I];
        unsigned VReg = MF.getRegInfo().createVirtualRegister(RC);
        MRI.addLiveIn(Reg, VReg);
        SDValue ArgValue = DAG.getCopyFromReg(Chain, DL, VReg, RegTy);
        FI = MFI->CreateFixedObject(RegSizeInBytes, VaArgOffset, true);
        SDValue PtrOff = DAG.getFrameIndex(FI, getPointerTy(DLayout));
        SDValue Store = DAG.getStore(Chain, DL, ArgValue, PtrOff,
                                     MachinePointerInfo(), false, false, 0);
        cast<StoreSDNode>(Store.getNode())->getMemOperand()->setValue(
                                                                      (Value *)nullptr);
        OutChains.push_back(Store);
    }
}

void VEXTargetLowering::HandleByVal(CCState *State, unsigned &Size,
                                     unsigned Align) const {
    const TargetFrameLowering *TFL = Subtarget.getFrameLowering();

    assert(Size && "Byval argument's size shouldn't be 0.");

    Align = std::min(Align, TFL->getStackAlignment());

    unsigned FirstReg = 0;
    unsigned NumRegs = 0;

    if (State->getCallingConv() != CallingConv::Fast) {
        unsigned RegSizeInBytes = 4;
        const ArrayRef<MCPhysReg> IntArgRegs = { VEX::Reg3, VEX::Reg4, VEX::Reg5, VEX::Reg6, VEX::Reg7, VEX::Reg8, VEX::Reg9, VEX::Reg10 };
        // FIXME: The O32 case actually describes no shadow registers.

        // We used to check the size as well but we can't do that anymore since
        // CCState::HandleByVal() rounds up the size after calling this function.
        assert(!(Align % RegSizeInBytes) &&
               "Byval argument's alignment should be a multiple of"
               "RegSizeInBytes.");

        FirstReg = State->getFirstUnallocated(IntArgRegs);

        // If Align > RegSizeInBytes, the first arg register must be even.
        // FIXME: This condition happens to do the right thing but it's not the
        //        right way to test it. We want to check that the stack frame offset
        //        of the register is aligned.
        if ((Align > RegSizeInBytes) && (FirstReg % 2)) {
            State->AllocateReg(IntArgRegs[FirstReg]);
            ++FirstReg;
        }

        // Mark the registers allocated.
        Size = RoundUpToAlignment(Size, RegSizeInBytes);
        for (unsigned I = FirstReg; Size > 0 && (I < IntArgRegs.size());
             Size -= RegSizeInBytes, ++I, ++NumRegs)
            State->AllocateReg(IntArgRegs[I]);
    }

    State->addInRegsParamInfo(FirstReg, FirstReg + NumRegs);
}

//===----------------------------------------------------------------------===//
//             Formal Arguments Calling Convention Implementation
//===----------------------------------------------------------------------===//

// @ LowerFormalArguments {
// LowerFormalArguments - transform physical registers into virtual registers
// and generate load operations for arguments places on the stack
//
// TODO: Maybe we don't need to promote Values from i8 and i16 to i32.
// since we hace loads and store that handles these types.
//
SDValue
VEXTargetLowering::LowerFormalArguments(SDValue Chain,
                                        CallingConv::ID CallConv,
                                        bool IsVarArg,
                                        const SmallVectorImpl<ISD::InputArg> &Ins,
                                        SDLoc DL, SelectionDAG &DAG,
                                        SmallVectorImpl<SDValue> &InVals)
const {
    DEBUG(errs() << "LowerFormalArguments\n");

//    if (IsVarArg)
//        llvm_unreachable("Variable number of arguments not yet implemented!");

    //DAG.dump();
    MachineFunction &MF = DAG.getMachineFunction();
    MachineFrameInfo *MFI = MF.getFrameInfo();
    MachineRegisterInfo &MRI = MF.getRegInfo();

    VEXFunctionInfo *FuncInfo = MF.getInfo<VEXFunctionInfo>();
    Function::const_arg_iterator FuncArg =
        DAG.getMachineFunction().getFunction()->arg_begin();

    auto *TFL = static_cast<const VEXFrameLowering *>(Subtarget.getFrameLowering());

    // Used with vargs to acumulate store chains.
    std::vector<SDValue> OutChains;

    // Assign locations to all of the incoming arguments.
    SmallVector<CCValAssign, 16> ArgLocs;
    CCState CCInfo(CallConv, IsVarArg, MF, ArgLocs, *DAG.getContext());

    // If need, arguments on stack should be place after ScratchPad Area
    //CCInfo.AllocateStack(TFL->getScratchArea(), 1);

    CCInfo.AnalyzeFormalArguments(Ins, CC_VEX_Address);

    DEBUG(dbgs() << DAG.getMachineFunction().getName().str() << ": "<< ArgLocs.size() << "\n");
    addFunctionArgument(DAG.getMachineFunction().getName().str(), (unsigned)ArgLocs.size());

    unsigned NumFixedGPRs = 0;

    for (unsigned I = 0, E = ArgLocs.size(); I != E; ++I){
        SDValue ArgValue;
        CCValAssign &VA = ArgLocs[I];
        EVT LocVT = VA.getLocVT();

        ISD::ArgFlagsTy Flags = Ins[I].Flags;

        if (Flags.isByVal()) {
            assert(Ins[I].isOrigArg() && "Byval arguments cannot be implicit");
            unsigned FirstByValReg, LastByValReg;
            unsigned ByValIdx = CCInfo.getInRegsParamsProcessed();
            CCInfo.getInRegsParamInfo(ByValIdx, FirstByValReg, LastByValReg);

            assert(Flags.getByValSize() &&
                   "ByVal args of size 0 should have been ignored by front-end.");
            assert(ByValIdx < CCInfo.getInRegsParamsCount());
            copyByValRegs(Chain, DL, OutChains, DAG, Flags, InVals, &*FuncArg,
                          FirstByValReg, LastByValReg, VA, MRI);
            CCInfo.nextInRegsParam();
            continue;
        }

        if (VA.isRegLoc()) {
            // Arguments passed in registers
            const TargetRegisterClass *RC;
            switch (LocVT.getSimpleVT().SimpleTy) {
                default:
                    // Integers smaller than i32 should be promoted
                    // TOCHECK : Is that correct?
                    // TODO: Check if We need to pass any other types as argument registers
                    // For now, we only accept i8, i16 and i32 into argument registers
                    llvm_unreachable("Unexpected argument type");
                    break;

                case MVT::i8:
                    NumFixedGPRs += 1;
                    RC = &VEX::GPRegsRegClass;
                    break;

                case MVT::i16:
                    NumFixedGPRs += 1;
                    RC = &VEX::GPRegsRegClass;
                    break;

                case MVT::i32:
                    NumFixedGPRs += 1;
                    RC = &VEX::GPRegsRegClass;
                    break;
            }

            unsigned VReg = MRI.createVirtualRegister(RC);
            MRI.addLiveIn(VA.getLocReg(), VReg);
            ArgValue = DAG.getCopyFromReg(Chain, DL, VReg, LocVT);
        } else {
            assert(VA.isMemLoc() && "Argument not register or memory");
//            llvm_unreachable("Not yet implemented!");
            // Create the frame index object for this incoming parameter.
            int FI = MFI->CreateFixedObject(LocVT.getSizeInBits()/8, VA.getLocMemOffset()+TFL->getScratchArea(), true);

            // Create the SelectionDAG nodes corresponding to a load
            // from this parameter. Unpromoted ints are passed
            // as right-justified 8-byte values.
            EVT PtrVT = VA.getValVT();
            SDValue FIN = DAG.getFrameIndex(FI, PtrVT);

            ArgValue = DAG.getLoad(LocVT, DL, Chain, FIN,
                                   MachinePointerInfo::getFixedStack(FI), false, false, false, 0);
        }

        // Convert the value of the argument register into the value that's
        // being passed.
        InVals.push_back(convertLocVTToValVT(DAG, DL, VA, Chain, ArgValue));
    }

    //@Ordinary struct type: 1 {
//    for (unsigned i = 0, e = ArgLocs.size(); i != e; ++i) {
//        // The cpu0 ABIs for returning structs by value requires that we copy
//        // the sret argument into $v0 for the return. Save the argument into
//        // a virtual register so that we can access it from the return points.
//        if (Ins[i].Flags.isSRet()) {
//            unsigned Reg = FuncInfo->getSRetReturnReg();
//            if (!Reg) {
//                Reg = MF.getRegInfo().createVirtualRegister(
//                        getRegClassFor(MVT::i32));
//                FuncInfo->setSRetReturnReg(Reg);
//          }
//          SDValue Copy = DAG.getCopyToReg(DAG.getEntryNode(), DL, Reg, InVals[i]);
//          Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, Copy, Chain);
//          break;
//        }
//      }
    //@Ordinary struct type: 1 }

    if (IsVarArg) {
//        // This will point to the next argument passed via stack.
//        int FrameIndex = MFI->CreateFixedObject(4, CCInfo.getNextStackOffset(),
//                                                true);
//        FuncInfo->setVarArgsFrameIndex(FrameIndex);

        writeVarArgRegs(OutChains, Chain, DL, DAG, CCInfo, MRI);
    }

    // All stores are grouped in one node to allow the matching between
    // the size of Ins and InVals. This only happens when on varg functions
    if (!OutChains.empty()) {
        OutChains.push_back(Chain);
        Chain = DAG.getNode(ISD::TokenFactor, DL, MVT::Other, OutChains);
    }

    return Chain;

}
// @LowerFormalArguments }

//===----------------------------------------------------------------------===//
//               Return Value Calling Convention Implementation
//===----------------------------------------------------------------------===//
SDValue
VEXTargetLowering::LowerReturn(SDValue Chain,
                               CallingConv::ID CallConv,
                               bool IsVarArg,
                               const SmallVectorImpl<ISD::OutputArg> &Outs,
                               const SmallVectorImpl<SDValue> &OutVals,
                               SDLoc DL, SelectionDAG &DAG) const {
    DEBUG(errs() << "LowerReturn : \n");

    // CCValAssign - represent the assignment of the return value to a location
    SmallVector<CCValAssign, 16> RVLocs;
    MachineFunction &MF = DAG.getMachineFunction();
    const DataLayout &DLayout = DAG.getDataLayout();

    VEXFunctionInfo *FuncInfo = MF.getInfo<VEXFunctionInfo>();

    // CCState - Info about the registers and stack slot.
    CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), RVLocs,
                   *DAG.getContext());

    // Analyze return values.
    AnalyzeReturnValues(CCInfo, RVLocs, Outs);

    SDValue Flag;
    SmallVector<SDValue, 8> RetOps(1, Chain);

    // Copy the result values into the output registers.
    for (unsigned i = 0, e = RVLocs.size() ; i != e; ++i){
        CCValAssign &VA = RVLocs[i];
        SDValue RetValue = OutVals[i];

        assert(VA.isRegLoc() && "Can only return in registers!");

        RetValue = convertValVTToLocVT(DAG, DL, VA, RetValue);
        Chain = DAG.getCopyToReg(Chain, DL, VA.getLocReg(), RetValue, Flag);

        // Guarantee that all emitted copies are stuck together,
        // avoiding something bad.
        Flag = Chain.getValue(1);
        RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
    }

//    // The VEX ABIs for returning structs by value requires that we copy
//    // the sret argument into $v0 for the return. We saved the argument into
//    // a virtual register in the entry block, so now we copy the value out
//    // and into $v0.
//    if (MF.getFunction()->hasStructRetAttr()) {
//      VEXFunctionInfo *VInfo = MF.getInfo<VEXFunctionInfo>();
//      unsigned Reg = VInfo->getSRetReturnReg();

//      if (!Reg)
//        llvm_unreachable("sret virtual register not created in the entry block");
//      SDValue Val = DAG.getCopyFromReg(Chain, DL, Reg, getPointerTy(DLayout));
//      unsigned Reg3 = VEX::Reg3;

//      Chain = DAG.getCopyToReg(Chain, DL, Reg3, Val, Flag);
//      Flag = Chain.getValue(1);
//      RetOps.push_back(DAG.getRegister(Reg3, getPointerTy(DLayout)));
//    }

    RetOps[0] = Chain; // Update Chain.

    // Add the flag if we have it.
    if (Flag.getNode())
        RetOps.push_back(Flag);

    DEBUG(dbgs() << DAG.getMachineFunction().getName().str() << ": "<< RVLocs.size() << "\n");
    addFunctionReturn(DAG.getMachineFunction().getName().str(), (unsigned)RVLocs.size());

    return DAG.getNode(VEXISD::PSEUDO_RET, DL, MVT::Other, RetOps);
}

SDValue VEXTargetLowering::LowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const{

    const GlobalValue *GV = cast<GlobalAddressSDNode>(Op)->getGlobal();

    const DataLayout &DLayout = DAG.getDataLayout();
    int64_t Offset = cast<GlobalAddressSDNode>(Op)->getOffset();

    // Create TargetGlobalAddress node, folding in the constant offset.
    SDValue Result = DAG.getTargetGlobalAddress(GV, SDLoc(Op),
                                                getPointerTy(DLayout), Offset);

    return DAG.getNode(VEXISD::WRAPPER, SDLoc(Op),
                       getPointerTy(DLayout), Result);

}

SDValue VEXTargetLowering::LowerExternalSymbol(SDValue Op, SelectionDAG &DAG) const{

    SDLoc dl(Op);
    const char *Sym = cast<ExternalSymbolSDNode>(Op)->getSymbol();
    const DataLayout &DLayout = DAG.getDataLayout();
    // Create TargetGlobalAddress node, folding in the constant offset.
    SDValue Result = DAG.getTargetExternalSymbol(Sym, getPointerTy(DLayout));

    return DAG.getNode(VEXISD::WRAPPER, dl,
                       getPointerTy(DLayout), Result);
}

SDValue
VEXTargetLowering::LowerVASTART(SDValue Op, SelectionDAG &DAG) const {
    // VASTART stores the address of the VarArgsFrameIndex slot into the
    // memory location argument.
    MachineFunction &MF = DAG.getMachineFunction();
    VEXFunctionInfo *QFI = MF.getInfo<VEXFunctionInfo>();
    SDValue Addr = DAG.getFrameIndex(QFI->getVarArgsFrameIndex(), MVT::i32);
    const Value *SV = cast<SrcValueSDNode>(Op.getOperand(2))->getValue();
    return DAG.getStore(Op.getOperand(0), SDLoc(Op), Addr,
                        Op.getOperand(1), MachinePointerInfo(SV), false,
                        false, 0);
}

// For some reason, We need to handle MVT::i1 types and promote them manually.
// Not sure why this is not working automatically during tblgen phase, since
// it should automatically promote i1 to higher/handlable types.
SDValue VEXTargetLowering::LowerConstant(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "Lower Constant: \n");
    SDLoc dl(Op);
    EVT ValueType = Op.getValueType();
    uint64_t Val = cast<ConstantSDNode>(Op)->getSExtValue();

    if (ValueType == MVT::i1){
        return DAG.getConstant(Val, dl, MVT::i32);
    }
    return SDValue();
}

SDValue VEXTargetLowering::LowerLOAD(SDValue Op, SelectionDAG &DAG) const {

    assert(Op.getValueType() == MVT::i1 &&
           "Custom lowering only for i1 loads");

    // First, load 8 bits into 32 bits, then truncate to 1 bit.
    const DataLayout &DLayout = DAG.getDataLayout();
    SDLoc dl(Op);
    LoadSDNode *LD = cast<LoadSDNode>(Op);

    SDValue Chain = LD->getChain();
    SDValue BasePtr = LD->getBasePtr();
    MachineMemOperand *MMO = LD->getMemOperand();

    SDValue NewLD = DAG.getExtLoad(ISD::EXTLOAD, dl, getPointerTy(DLayout), Chain,
                                   BasePtr, MVT::i8, MMO);
    SDValue Result = DAG.getNode(ISD::TRUNCATE, dl, MVT::i1, NewLD);

    SDValue Ops[] = { Result, SDValue(NewLD.getNode(), 1) };
    return DAG.getMergeValues(Ops, dl);
}

SDValue VEXTargetLowering::LowerSTORE(SDValue Op, SelectionDAG &DAG) const {

    assert(Op.getOperand(1).getValueType() == MVT::i1 &&
           "Custom lowering only for i1 stores");

    // First, zero extend to 32 bits, then use a truncating store to 8 bits.

    SDLoc dl(Op);
    StoreSDNode *ST = cast<StoreSDNode>(Op);
    const DataLayout &DLayout = DAG.getDataLayout();
    SDValue Chain = ST->getChain();
    SDValue BasePtr = ST->getBasePtr();
    SDValue Value = ST->getValue();
    MachineMemOperand *MMO = ST->getMemOperand();

    Value = DAG.getNode(ISD::ZERO_EXTEND, dl, getPointerTy(DLayout), Value);
    return DAG.getTruncStore(Chain, dl, Value, BasePtr, MVT::i8, MMO);
}

// We should lower ADDE and ADDC instructions to ADDCG.
SDValue VEXTargetLowering::LowerADDSUBWithFlags(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "Legalizing ADDE or ADDC instruction\n");

    SDLoc dl(Op);

    bool CinFlag = Op.getOpcode() == ISD::ADDE ||  Op.getOpcode() == ISD::SUBE ? true : false;
    bool isSub = Op.getOpcode() == ISD::SUBC ||  Op.getOpcode() == ISD::SUBE ? true : false;

    SDValue lhs = Op.getOperand(0);
    SDValue rhs;
    SDVTList VTs = DAG.getVTList(Op.getValueType(), MVT::Glue);

    if (CinFlag) {

        if (isSub) {
            DEBUG(errs() << "SUBE instruction\n");
            SDValue ConstantZero = DAG.getConstant(0, dl, MVT::i32);
            rhs = DAG.getNode(ISD::SUB, dl, MVT::i32, ConstantZero, Op.getOperand(1));
        } else {
            DEBUG(errs() << "ADDE instruction\n");
            rhs = Op.getOperand(1);
        }
        SDValue Op3 = Op.getOperand(2);
        return DAG.getNode(VEXISD::ADDCG, dl, VTs, lhs, rhs, Op3);
    } else {

        if (isSub) {
            DEBUG(errs() << "SUBC instruction\n");
            SDValue ConstantZero = DAG.getConstant(0, dl, MVT::i32);
            rhs = DAG.getNode(ISD::SUB, dl, MVT::i32, ConstantZero, Op.getOperand(1));

        } else {
            DEBUG(errs() << "ADDC instruction\n");
            rhs = Op.getOperand(1);
        }
        SDValue Op3 = DAG.getConstant(0, dl, MVT::i32);
        return DAG.getNode(VEXISD::ADDCG, dl, VTs, lhs, rhs, Op3);
    }
}

// FIXME: Can we use this function to generate code for both
// half and full mult instructions?
// VEX does not natively support 64 bit instructions, so we should
// not worry about the upper part of the result.
SDValue VEXTargetLowering::LowerMUL(SDValue Op, SelectionDAG &DAG) const {

    SDLoc dl(Op);

    SDValue lhs = Op.getOperand(0);
    SDValue rhs = Op.getOperand(1);
    unsigned Opc1, Opc2;

    bool isHalfMult = Op.getOpcode() == ISD::MUL ? true : false;

    EVT ValueType = Op.getValueType();

    // TODO: Do we need to change this?
    if (ValueType == MVT::i32){
        DEBUG(errs() << "ISD::MUL with MVT::i32");
        Opc1 = VEXISD::MPYLU;
        Opc2 = VEXISD::MPYHS;
    }else{
        DEBUG(errs() << "ISD::MUL with MVT::i16");
        return DAG.getNode(VEXISD::MPYLL, dl, ValueType, lhs, rhs);
    }

    SDValue FirstPart = DAG.getNode(Opc1, dl, ValueType, lhs, rhs);
    SDValue SecondPart = DAG.getNode(Opc2, dl, ValueType, lhs, rhs);

    return DAG.getNode(ISD::ADD, dl, ValueType, FirstPart, SecondPart);
}

SDValue VEXTargetLowering::LowerMULHS(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "LowerMULHS!\n");
    SDLoc dl = SDLoc(Op.getNode());

    SDValue LHS = Op.getOperand(0);
    SDValue RHS = Op.getOperand(1);
    SDValue ShiftImm = DAG.getTargetConstant(16, dl, MVT::i32);
    SDValue MaskImm = DAG.getTargetConstant(0xFFFF, dl, MVT::i32);

    SDValue v0, v1;

    // Check whether the second operand is an immediate value
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(RHS)) {
        // If it's large, move it to a register and then modify
        if(C->getConstantIntValue()->getBitWidth() > 9) {
            SDValue v = DAG.getNode(VEXISD::MOV, dl, MVT::i32, RHS);
            v0 = DAG.getNode(ISD::AND, dl, MVT::i32, v, MaskImm);
            v1 = DAG.getNode(ISD::SRA, dl, MVT::i32, v, ShiftImm);
        }
    }
    else {
        v0 = DAG.getNode(ISD::AND, dl, MVT::i32, RHS, MaskImm);
        v1 = DAG.getNode(ISD::SRA, dl, MVT::i32, RHS, ShiftImm);
    }

    SDValue u0 = DAG.getNode(ISD::AND, dl, MVT::i32, LHS, MaskImm);
    SDValue u1 = DAG.getNode(ISD::SRA, dl, MVT::i32, LHS, ShiftImm);

    SDValue w0 = DAG.getNode(ISD::MUL, dl, MVT::i32, u0, v0);
    SDValue t1 = DAG.getNode(ISD::MUL, dl, MVT::i32, u1, v0);
    SDValue t2 = DAG.getNode(ISD::SRL, dl, MVT::i32, w0, ShiftImm);
    SDValue t = DAG.getNode(ISD::ADD, dl, MVT::i32, t1, t2);

    SDValue w1 = DAG.getNode(ISD::AND, dl, MVT::i32, t, MaskImm);
    SDValue w2 = DAG.getNode(ISD::SRA, dl, MVT::i32, t, ShiftImm);

    SDValue w3 = DAG.getNode(ISD::MUL, dl, MVT::i32, u0, v1);
    SDValue w4 = DAG.getNode(ISD::ADD, dl, MVT::i32, w3, w1);

    SDValue u1v1 = DAG.getNode(ISD::MUL, dl, MVT::i32, u1, v1);
    SDValue w4Shift = DAG.getNode(ISD::SRA, dl, MVT::i32, w4, ShiftImm);
    SDValue resA = DAG.getNode(ISD::ADD, dl, MVT::i32, u1v1, w4Shift);
    return DAG.getNode(ISD::ADD, dl, MVT::i32, resA, w2);
}

SDValue VEXTargetLowering::LowerMULHU(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "LowerMULHU!\n");
    SDLoc dl = SDLoc(Op.getNode());

    SDValue LHS = Op.getOperand(0);
    SDValue RHS = Op.getOperand(1);
    SDValue ShiftImm = DAG.getTargetConstant(16, dl, MVT::i32);
    SDValue MaskImm = DAG.getTargetConstant(0xFFFF, dl, MVT::i32);

    SDValue v0, v1;

    // Check whether the second operand is an immediate value
    if (ConstantSDNode *C = dyn_cast<ConstantSDNode>(RHS)) {
        // If it's large, move it to a register and then modify
        if(C->getConstantIntValue()->getBitWidth() > 9) {
            SDValue v = DAG.getNode(VEXISD::MOV, dl, MVT::i32, RHS);
            v0 = DAG.getNode(ISD::AND, dl, MVT::i32, v, MaskImm);
            v1 = DAG.getNode(ISD::SRL, dl, MVT::i32, v, ShiftImm);
        }
    }
    else {
        v0 = DAG.getNode(ISD::AND, dl, MVT::i32, RHS, MaskImm);
        v1 = DAG.getNode(ISD::SRA, dl, MVT::i32, RHS, ShiftImm);
    }

    SDValue u0 = DAG.getNode(ISD::AND, dl, MVT::i32, LHS, MaskImm);
    SDValue u1 = DAG.getNode(ISD::SRL, dl, MVT::i32, LHS, ShiftImm);

    SDValue w0 = DAG.getNode(ISD::MUL, dl, MVT::i32, u0, v0);
    SDValue t1 = DAG.getNode(ISD::MUL, dl, MVT::i32, u1, v0);
    SDValue t2 = DAG.getNode(ISD::SRL, dl, MVT::i32, w0, ShiftImm);
    SDValue t = DAG.getNode(ISD::ADD, dl, MVT::i32, t1, t2);

    SDValue w1 = DAG.getNode(ISD::AND, dl, MVT::i32, t, MaskImm);
    SDValue w2 = DAG.getNode(ISD::SRL, dl, MVT::i32, t, ShiftImm);

    SDValue w3 = DAG.getNode(ISD::MUL, dl, MVT::i32, u0, v1);
    SDValue w4 = DAG.getNode(ISD::ADD, dl, MVT::i32, w3, w1);

    SDValue u1v1 = DAG.getNode(ISD::MUL, dl, MVT::i32, u1, v1);
    SDValue w4Shift = DAG.getNode(ISD::SRL, dl, MVT::i32, w4, ShiftImm);
    SDValue resA = DAG.getNode(ISD::ADD, dl, MVT::i32, u1v1, w4Shift);
    return DAG.getNode(ISD::ADD, dl, MVT::i32, resA, w2);
}

SDValue VEXTargetLowering::LowerSDIV(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "ISD::SDIV Lowering\n");

    SDLoc DL(Op);

    SDVTList VTList = DAG.getVTList(MVT::i32, MVT::i1);

    SDValue Reg0 = DAG.getRegister(VEX::Reg0, MVT::i32);

    SDValue Zero = DAG.getConstant(0, DL, MVT::i32);

    SDValue Dividend = Op.getOperand(0);
    SDValue Divisor = Op.getOperand(1);
    SDValue CondCode = DAG.getCondCode(ISD::SETLT);
    SDValue CmpDividend = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                          Dividend, Reg0, CondCode);
    SDValue CmpDivisor = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                         Divisor, Reg0, CondCode);

    SDValue CondCodeEq = DAG.getCondCode(ISD::SETEQ);
    SDValue CmpEq = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                CmpDividend, CmpDivisor, CondCodeEq);

    SDValue SubDividend = DAG.getNode(ISD::SUB, DL, MVT::i32, Reg0, Dividend);
    SDValue SubDivisor = DAG.getNode(ISD::SUB, DL, MVT::i32, Reg0, Divisor);
    SDValue SlctDividend = DAG.getNode(ISD::SELECT, DL, MVT::i32,
                                           CmpDividend, SubDividend, Dividend);
    SDValue SlctDivisor = DAG.getNode(ISD::SELECT, DL, MVT::i32,
                                          CmpDivisor, SubDivisor, Divisor);

    SmallVector<SDValue, 34> ADDCGNodes;
    SmallVector<SDValue, 32> DIVSNodes;

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     SlctDividend, SlctDividend,
                                     Zero));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[0].getValue(0),
                                     ADDCGNodes[0].getValue(0),
                                     Zero));

    DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                    VTList,
                                    Reg0, SlctDivisor,
                                    ADDCGNodes[0].getValue(1)));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[1].getValue(0),
                                     ADDCGNodes[1].getValue(0),
                                     DIVSNodes[0].getValue(1)));

    for (unsigned i = 1; i < 32; i++) {
        DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                        VTList,
                                        DIVSNodes[i-1].getValue(0), SlctDivisor,
                                        ADDCGNodes[i].getValue(1)));

        ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                         VTList,
                                         ADDCGNodes[i+1].getValue(0),
                                         ADDCGNodes[i+1].getValue(0),
                                         DIVSNodes[i].getValue(1)));
    }

    SDValue ORC = DAG.getNode(VEXISD::ORC, DL, MVT::i32,
                              ADDCGNodes[33].getValue(0), Reg0);

    SDValue CondCodeRes = DAG.getCondCode(ISD::SETGE);

    SDValue CmpRes = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                 DIVSNodes[31].getValue(0),
                                 Reg0, CondCodeRes);

    SDValue SH1ADDNode = DAG.getNode(VEXISD::SH1ADD, DL,
                                     MVT::i32, ORC,
                                     CmpRes);

    SDValue SubRes = DAG.getNode(ISD::SUB, DL, MVT::i32, Reg0, SH1ADDNode);
    return DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpEq, SH1ADDNode, SubRes);
}

SDValue VEXTargetLowering::LowerUDIV(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "ISD::UDIV Lowering\n");

    SDLoc DL(Op);

    SDVTList VTList = DAG.getVTList(MVT::i32, MVT::i1);

    SDValue Reg0 = DAG.getRegister(VEX::Reg0, MVT::i32);

    SDValue Zero = DAG.getConstant(0, DL, MVT::i32);


    SDValue Dividend = Op.getOperand(0);
    SDValue Divisor = Op.getOperand(1);

    SDValue CondCode = DAG.getCondCode(ISD::SETUGE);
    SDValue CmpDividend = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                      Dividend, Divisor, CondCode);

    SDValue CondCodeDivisor = DAG.getCondCode(ISD::SETLT);
    SDValue CmpDivisor = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                     Divisor, Reg0, CondCodeDivisor);

    SDValue ShiftDividend = DAG.getNode(ISD::SRL, DL, MVT::i32,
                                        Dividend, CmpDivisor);
    SDValue ShiftDivisor = DAG.getNode(ISD::SRL, DL, MVT::i32,
                                        Divisor, CmpDivisor);

    SmallVector<SDValue, 34> ADDCGNodes;
    SmallVector<SDValue, 32> DIVSNodes;

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ShiftDividend, ShiftDividend,
                                     Zero));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[0].getValue(0),
                                     ADDCGNodes[0].getValue(0),
                                     Zero));

    DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                    VTList,
                                    Reg0, ShiftDivisor,
                                    ADDCGNodes[0].getValue(1)));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[1].getValue(0),
                                     ADDCGNodes[1].getValue(0),
                                     DIVSNodes[0].getValue(1)));

    for (unsigned i = 1; i < 32; i++) {
        DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                        VTList,
                                        DIVSNodes[i-1].getValue(0), ShiftDivisor,
                                        ADDCGNodes[i].getValue(1)));

        ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                         VTList,
                                         ADDCGNodes[i+1].getValue(0),
                                         ADDCGNodes[i+1].getValue(0),
                                         DIVSNodes[i].getValue(1)));
    }

    SDValue ORC = DAG.getNode(VEXISD::ORC, DL, MVT::i32,
                              ADDCGNodes[33].getValue(0), Reg0);

    SDValue CondCodeRes = DAG.getCondCode(ISD::SETGE);
    SDValue CmpRes = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                 DIVSNodes[31].getValue(0),
                                 Reg0, CondCodeRes);

    SDValue SH1ADDNode = DAG.getNode(VEXISD::SH1ADD, DL,
                                     MVT::i32, ORC,
                                     CmpRes);

    return DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpDivisor, CmpDividend, SH1ADDNode);
}

SDValue VEXTargetLowering::LowerSREM(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "ISD::SREM Lowering\n");

    SDLoc DL(Op);

    SDVTList VTList = DAG.getVTList(MVT::i32, MVT::i1);

    SDValue Reg0 = DAG.getRegister(VEX::Reg0, MVT::i32);

    SDValue Zero = DAG.getConstant(0, DL, MVT::i32);


    SDValue Dividend = Op.getOperand(0);
    SDValue Divisor = Op.getOperand(1);

    SDValue CondCode = DAG.getCondCode(ISD::SETLT);
    SDValue CmpDividend = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                      Dividend, Divisor, CondCode);
    SDValue CmpDivisor = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                     Divisor, Reg0, CondCode);

    SDValue SubDividend = DAG.getNode(ISD::SUB, DL, MVT::i32,
                                      Reg0, Dividend);
    SDValue SubDivisor = DAG.getNode(ISD::SUB, DL, MVT::i32,
                                     Reg0, Divisor);

    SDValue SelectDividend = DAG.getNode(ISD::SELECT, DL, MVT::i32,
                                         CmpDividend, SubDividend, Dividend);

    SDValue SelectDivisor = DAG.getNode(ISD::SELECT, DL, MVT::i32,
                                        CmpDivisor, SubDivisor, Divisor);

    SmallVector<SDValue, 34> ADDCGNodes;
    SmallVector<SDValue, 32> DIVSNodes;

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     SelectDividend, SelectDividend,
                                     Zero));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[0].getValue(0),
                                     ADDCGNodes[0].getValue(0),
                                     Zero));

    DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                    VTList,
                                    Reg0, SelectDivisor,
                                    ADDCGNodes[0].getValue(1)));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[1].getValue(0),
                                     ADDCGNodes[1].getValue(0),
                                     DIVSNodes[0].getValue(1)));

    for (unsigned i = 1; i < 32; i++) {
        DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                        VTList,
                                        DIVSNodes[i-1].getValue(0), SelectDivisor,
                                        ADDCGNodes[i].getValue(1)));

        ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                         VTList,
                                         ADDCGNodes[i+1].getValue(0),
                                         ADDCGNodes[i+1].getValue(0),
                                         DIVSNodes[i].getValue(1)));
    }

    SDValue CondCodeRes = DAG.getCondCode(ISD::SETGE);
    SDValue CmpRes = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                 DIVSNodes[31].getValue(0),
                                 Reg0, CondCodeRes);

    SDValue AddRem = DAG.getNode(ISD::ADD, DL, MVT::i32,
                                 DIVSNodes[31].getValue(0),
                                 SelectDivisor);

    SDValue SelectRem1 = DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpRes,
                                     DIVSNodes[31].getValue(0), AddRem);

    SDValue SubRem = DAG.getNode(ISD::SUB, DL, MVT::i32,
                                 Reg0, SelectRem1);

    return DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpDividend,
                       SubRem, SelectRem1);
}

SDValue VEXTargetLowering::LowerUREM(SDValue Op, SelectionDAG &DAG) const {

    DEBUG(errs() << "ISD::UREM Lowering\n");

    SDLoc DL(Op);

    SDVTList VTList = DAG.getVTList(MVT::i32, MVT::i1);

    SDValue Reg0 = DAG.getRegister(VEX::Reg0, MVT::i32);

    SDValue Zero = DAG.getConstant(0, DL, MVT::i32);

    SDValue Dividend = Op.getOperand(0);
    SDValue Divisor = Op.getOperand(1);

    SDValue CondCode = DAG.getCondCode(ISD::SETUGE);
    SDValue CmpDividend = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                      Dividend, Divisor, CondCode);

    SDValue CondCodeDivisor = DAG.getCondCode(ISD::SETLT);
    SDValue CmpDivisor = DAG.getNode(ISD::SETCC, DL, MVT::i32,
                                     Divisor, Reg0, CondCodeDivisor);

    SDValue ShiftDividend = DAG.getNode(ISD::SRL, DL, MVT::i32,
                                        Dividend, CmpDivisor);
    SDValue ShiftDivisor = DAG.getNode(ISD::SRL, DL, MVT::i32,
                                       Divisor, CmpDivisor);

    SDValue SubRem = DAG.getNode(ISD::SUB, DL, MVT::i32,
                                    Dividend, Divisor);

    SDValue SelectRem = DAG.getNode(ISD::SELECT, DL, MVT::i32,
                                    CmpDividend, SubRem, Divisor);

    SmallVector<SDValue, 34> ADDCGNodes;
    SmallVector<SDValue, 32> DIVSNodes;

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ShiftDividend, ShiftDividend,
                                     Zero));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[0].getValue(0),
                                     ADDCGNodes[0].getValue(0),
                                     Zero));

    DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                    VTList,
                                    Reg0, ShiftDivisor,
                                    ADDCGNodes[0].getValue(1)));

    ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                     VTList,
                                     ADDCGNodes[1].getValue(0),
                                     ADDCGNodes[1].getValue(0),
                                     DIVSNodes[0].getValue(1)));

    for (unsigned i = 1; i < 32; i++) {
        DIVSNodes.push_back(DAG.getNode(VEXISD::DIVS, DL,
                                        VTList,
                                        DIVSNodes[i-1].getValue(0), ShiftDivisor,
                                        ADDCGNodes[i].getValue(1)));

        ADDCGNodes.push_back(DAG.getNode(VEXISD::ADDCG, DL,
                                         VTList,
                                         ADDCGNodes[i+1].getValue(0),
                                         ADDCGNodes[i+1].getValue(0),
                                         DIVSNodes[i].getValue(1)));
    }

    SDValue CondCodeRes = DAG.getCondCode(ISD::SETGE);
    SDValue CmpRes = DAG.getNode(ISD::SETCC, DL, MVT::i1,
                                 DIVSNodes[31].getValue(0),
                                 Reg0, CondCodeRes);

    SDValue AddRem = DAG.getNode(ISD::ADD, DL, MVT::i32,
                                 DIVSNodes[31].getValue(0),
                                 ShiftDivisor);

    SDValue SelectRem1 = DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpRes,
                                     DIVSNodes[31].getValue(0), AddRem);

    return DAG.getNode(ISD::SELECT, DL, MVT::i32, CmpDivisor,
                                     SelectRem, SelectRem1);
}


SDValue CombineMinMax(SDLoc DL, EVT VT, SDValue lhs, SDValue rhs,
                      SDValue True, SDValue False,
                      SDValue CC, SelectionDAG &DAG) {

    if (!(lhs == True && rhs == False) && !(rhs == True && lhs == False))
        return SDValue();

    ISD::CondCode CCOpcode = cast<CondCodeSDNode>(CC)->get();

    switch (CCOpcode) {
        case ISD::SETULE:
        case ISD::SETULT: {
            unsigned Opc = (lhs == True) ? VEXISD::MINU : VEXISD::MAXU;
            return DAG.getNode(Opc, DL, VT, lhs, rhs);
        }
        case ISD::SETLE:
        case ISD::SETLT: {
            unsigned Opc = (lhs == True) ? VEXISD::MIN : VEXISD::MAX;
            return DAG.getNode(Opc, DL, VT, lhs, rhs);
        }
        case ISD::SETGT:
        case ISD::SETGE: {
            unsigned Opc = (lhs == True) ? VEXISD::MAX : VEXISD::MIN;
            return DAG.getNode(Opc, DL, VT, lhs, rhs);
        }
        case ISD::SETUGE:
        case ISD::SETUGT: {
            unsigned Opc = (lhs == True) ? VEXISD::MAXU : VEXISD::MINU;
            return DAG.getNode(Opc, DL, VT, lhs, rhs);
        }
        default:
            return SDValue();
    }

}

// We need this function to perform combination of DAG.
// Useful for instructions such as max and min, etc.
SDValue VEXTargetLowering::PerformDAGCombine(SDNode *N,
                                             DAGCombinerInfo &DCI) const {

    SelectionDAG &DAG = DCI.DAG;
    SDLoc DL(N);
    unsigned Opc = N->getOpcode();

    switch (Opc) {

        default:
            break;

        case ISD::SELECT:
            SDValue Cond = N->getOperand(0);

            if (Cond->getOpcode() == ISD::SETCC && Cond.hasOneUse()){
                EVT VT = N->getValueType(0);
                SDValue lhs = Cond.getOperand(0);
                SDValue rhs = Cond.getOperand(1);
                SDValue CC = Cond.getOperand(2);

                SDValue True = N->getOperand(1);
                SDValue False = N->getOperand(2);

                if (VT == MVT::i32)
                    return CombineMinMax(DL, VT, lhs, rhs, True, False, CC, DAG);
            }
    }

    return SDValue();
}


