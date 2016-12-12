//===-- VEXMCTargetDesc.cpp - VEX Target Descriptions -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides VEX specific target descriptions.
//
//===----------------------------------------------------------------------===//

#include "VEXMCTargetDesc.h"
#include "VEXBaseInfo.h"

#include "llvm/MC/MachineLocation.h"
#include "llvm/MC/MCCodeGenInfo.h"
#include "llvm/MC/MCELFStreamer.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCSymbol.h"

#include "llvm/ADT/STLExtras.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/Support/TargetRegistry.h"

#include "InstPrinter/VEXInstPrinter.h"
#include "VEXTargetStreamer.h"
#include "VEXMCAsmInfo.h"

#include "llvm/ADT/DenseSet.h"

using namespace llvm;

#define GET_INSTRINFO_MC_DESC
#include "VEXGenInstrInfo.inc"

#define GET_SUBTARGETINFO_MC_DESC
//#include "VEXSubtargetInfo.cpp"
#include "VEXGenSubtargetInfo.inc"

#define GET_REGINFO_MC_DESC
#include "VEXGenRegisterInfo.inc"

//void collectAllInsnClasses (ConfigInfo Config, DenseSet<unsigned> &allInsnClasses) {
//    
//    std::map<std::string,unsigned> NameToBitsMap = Config.NameToBitsMap;
//    
//    SmallVector<StringRef, 16> UnitList = {"Alu", "Branch",
//        "Load", "Store",
//        "Multiply", "All",
//        "AddOtherType1", "AddOtherType2",
//        "AddOtherType3", "AddOtherType4",
//        "AddOtherType5", "AddOtherType6",
//        "AddOtherType7", "AddOtherType8",
//        "AddOtherType9", "AddOtherType10" };
//    
//    unsigned UnitBitValue;
//    for (unsigned i = 0; i < 6; ++i) {
//        // Conduct bitwise or.
//        std::string UnitName = UnitList[i];
//        assert(NameToBitsMap.count(UnitName));
//        UnitBitValue = NameToBitsMap[UnitName];
//    
//        if (UnitBitValue != 0)
//            allInsnClasses.insert(UnitBitValue);
//    }
//    
//    unsigned size = allInsnClasses.size();
//    
//}
//
//void generateDFA (VEXDFA &D, DenseSet<unsigned> &allInsnClasses) {
//
//    const VEXState *Initial = &D.newState();
//    Initial->isInitial = true;
//    Initial->stateInfo.insert(0x0);
//    SmallVector<const VEXState*, 32> WorkList;
//    std::map<std::set<unsigned>, const VEXState*> Visited;
//    
//    WorkList.push_back(Initial);
//    
//    //
//    // Worklist algorithm to create a DFA for processor resource tracking.
//    // C = {set of InsnClasses}
//    // Begin with initial node in worklist. Initial node does not have
//    // any consumed resources,
//    //     ResourceState = 0x0
//    // Visited = {}
//    // While worklist != empty
//    //    S = first element of worklist
//    //    For every instruction class C
//    //      if we can accommodate C in S:
//    //          S' = state with resource states = {S Union C}
//    //          Add a new transition: S x C -> S'
//    //          If S' is not in Visited:
//    //             Add S' to worklist
//    //             Add S' to Visited
//    //
//    int size = allInsnClasses.size();
//    while (!WorkList.empty()) {
//        const VEXState *current = WorkList.pop_back_val();
//        for (DenseSet<unsigned>::iterator CI = allInsnClasses.begin(),
//             CE = allInsnClasses.end(); CI != CE; ++CI) {
//            unsigned InsnClass = *CI;
//            
//            std::set<unsigned> NewStateResources;
//            //
//            // If we haven't already created a transition for this input
//            // and the state can accommodate this InsnClass, create a transition.
//            //
//            if (!current->hasTransition(InsnClass) &&
//                current->canAddInsnClass(InsnClass)) {
//                const VEXState *NewState;
//                current->AddInsnClass(InsnClass, NewStateResources);
//                assert(!NewStateResources.empty() && "New states must be generated");
//                
//                //
//                // If we have seen this state before, then do not create a new state.
//                //
//                //
//                auto VI = Visited.find(NewStateResources);
//                if (VI != Visited.end())
//                    NewState = VI->second;
//                else {
//                    NewState = &D.newState();
//                    NewState->stateInfo = NewStateResources;
//                    Visited[NewStateResources] = NewState;
//                    WorkList.push_back(NewState);
//                }
//                
//                current->addTransition(InsnClass, NewState);
//            }
//        }
//    }
//}

// Select the VEX Architecture Feature for the given triple and cpu name
// The function will be called at command 'llvm-objdump -d' for VEX elf input
// FIXME:  Is this really necessary?

static StringRef selectVEXArchFeature(const Triple TT, StringRef CPU){
    std::string VEXArchFeature;

    if(CPU.empty() || CPU == "generic"){
        Triple TheTriple(TT);
//        if(TheTriple.getArch() == Triple::vex
//           || TheTriple.getArch() == Triple::vexnew)
            if(CPU.empty() || CPU == "vex_I")
                VEXArchFeature = "+vexI";
            else if (CPU == "VEX_II")
                VEXArchFeature = "+vexII";
    }
    return VEXArchFeature;
}

static MCInstrInfo *createVEXMCInstrInfo(){
    MCInstrInfo *X = new MCInstrInfo();
    InitVEXMCInstrInfo(X);  // defined in VEXGenRegisterInfo.inc
    return X;
}

static MCRegisterInfo *createVEXMCRegisterInfo(const Triple &TT) {
    MCRegisterInfo *X = new MCRegisterInfo();
    InitVEXMCRegisterInfo(X, VEX::Lr);   // defined in VEXGenRegisterInfo.inc
    return X;
}

static MCSubtargetInfo *createVEXMCSubtargetInfo(const Triple &TT, StringRef CPU,
                                                 StringRef FS) {
    std::string ArchFS = selectVEXArchFeature(TT, CPU);
    if(!FS.empty())
        if(ArchFS.empty())
            ArchFS = ArchFS + "," + FS.str();
        else
            ArchFS = FS;
    
//    // ********************************************
//    struct ConfigInfo Config;
//    DenseSet<unsigned> allInsnClasses;
//    VEXDFA D;
//    
//    // Read File
//    ConfigureMachineModel(Config.IssueWidth, Config.Resources, Config.Delays, Config.NumRegisters, Config.NameToBitsMap);
//    UpdateItinerariesTables(Config.Delays, Config.NameToBitsMap);
//    // Get Info on Instruction Classes
//    collectAllInsnClasses(Config, allInsnClasses);
//    // Generate DFA with correct transitions
//    generateDFA(D, allInsnClasses);
//    D.UpdateTables();
//    
//    // ********************************************
    
//    errs () << "VEXDFAStateInputTable[][2] = {";
//    for (unsigned i = 0; i < 64; ++i) {
//        errs() << "{" <<VEXDFAStateInputTable[i][0] << ", " << VEXDFAStateInputTable[i][1] <<"},";
//    }
//    errs () << "};\n";
//    
//    errs () << "VEXDFAStateEntryTable[] = {";
//    for (unsigned i = 0; i < 64; ++i) {
//        errs() << "" << VEXDFAStateEntryTable[i] << ", ";
//    }
//    errs () << "};\n";
    
    return createVEXMCSubtargetInfoImpl(TT, CPU, ArchFS); // defined in VEXGenRegisterInfo.inc
}

static MCAsmInfo *createVEXMCAsmInfo(const MCRegisterInfo &MRI, const Triple &TT){

    MCAsmInfo *MAI = new VEXMCAsmInfo(TT);
    unsigned stack_pointer = MRI.getDwarfRegNum(VEX::Reg1, true);

    MCCFIInstruction Inst = MCCFIInstruction::createDefCfa(0, stack_pointer, 0);
    MAI->addInitialFrameState(Inst);

    return MAI;
}

static MCCodeGenInfo *createVEXMCCodeGenInfo(const Triple &TT, Reloc::Model RM,
                                              CodeModel::Model CM,
                                             CodeGenOpt::Level OL) {
    MCCodeGenInfo *X = new MCCodeGenInfo();

    if(CM == CodeModel::JITDefault)
        RM = Reloc::Static;
    else if(RM == CodeModel::Default)
        RM = Reloc::PIC_;
    X->initMCCodeGenInfo(RM,CM, OL);    // defined in lib/MC/MCCodeGenInfo.cpp
    return X;
}

static MCTargetStreamer *createAsmTargetStreamer(MCStreamer &S,
                                                 formatted_raw_ostream &OS,
                                                 MCInstPrinter *InstPrint,
                                                 bool isVerboseAsm) {
  return new VEXTargetAsmStreamer(S, OS);
}

static MCInstPrinter *createVEXMCInstPrinter(const Triple &T,
                                             unsigned SyntaxVariant,
                                             const MCAsmInfo &MAI,
                                             const MCInstrInfo &MII,
                                             const MCRegisterInfo &MRI){
    return new VEXInstPrinter(MAI, MII, MRI);
}

//LLVMInitializeVEXTargetMC
extern "C" void LLVMInitializeVEXTargetMC(){

    for (Target *T : {&TheVEXTarget}) {
    // Register the MC asm info.
    RegisterMCAsmInfoFn X(*T, createVEXMCAsmInfo);

    // Register the MC codegen Info.
    TargetRegistry::RegisterMCCodeGenInfo(*T, createVEXMCCodeGenInfo);

    // Register the MC instruction info
    TargetRegistry::RegisterMCInstrInfo(*T, createVEXMCInstrInfo);

    // Register the MC Register Info
    TargetRegistry::RegisterMCRegInfo(*T, createVEXMCRegisterInfo);

    // Register the MC SubtargetInfo
    TargetRegistry::RegisterMCSubtargetInfo(*T, createVEXMCSubtargetInfo);

    // Register the MCStreamer (needed to modify the way a string is writen into memory
    // Register the asm target streamer.
    TargetRegistry::RegisterAsmTargetStreamer(*T, createAsmTargetStreamer);

    // Register the MC InstPrinter
    TargetRegistry::RegisterMCInstPrinter(*T, createVEXMCInstPrinter);
    
    }

}
