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

//===----------------------------------------------------------------------===//
// Functional units
//===----------------------------------------------------------------------===//

class FuncUnit;

def IUnit0    : FuncUnit;
def IUnit1    : FuncUnit;
def IUnit2    : FuncUnit;
def IUnit3    : FuncUnit;
def IUnit4    : FuncUnit;
def IUnit5    : FuncUnit;
def IUnit6    : FuncUnit;
def IUnit7    : FuncUnit;
def IUnit8    : FuncUnit;
def IUnit9    : FuncUnit;
def IUnit10    : FuncUnit;
def IUnit11    : FuncUnit;
def IUnit12    : FuncUnit;
def IUnit13    : FuncUnit;
def IUnit14    : FuncUnit;
def IUnit15    : FuncUnit;
def IUnit16    : FuncUnit;
def IUnit17    : FuncUnit;
def IUnit18    : FuncUnit;
def IUnit19    : FuncUnit;
def IUnit20    : FuncUnit;
def IUnit21    : FuncUnit;
def IUnit22    : FuncUnit;
def IUnit23    : FuncUnit;
def IUnit24    : FuncUnit;
def IUnit25    : FuncUnit;
def IUnit26    : FuncUnit;
def IUnit27    : FuncUnit;
def IUnit28    : FuncUnit;
def IUnit29    : FuncUnit;
def IUnit30    : FuncUnit;
def IUnit31    : FuncUnit;
def IUnit32    : FuncUnit;
def IUnit33    : FuncUnit;
def IUnit34    : FuncUnit;
def IUnit35    : FuncUnit;
def IUnit36    : FuncUnit;
def IUnit37    : FuncUnit;
def IUnit38    : FuncUnit;
def IUnit39    : FuncUnit;
def IUnit40    : FuncUnit;
def IUnit41    : FuncUnit;
def IUnit42    : FuncUnit;
def IUnit43    : FuncUnit;
def IUnit44    : FuncUnit;
def IUnit45    : FuncUnit;
def IUnit46    : FuncUnit;
def IUnit47    : FuncUnit;
def IUnit48    : FuncUnit;
def IUnit49    : FuncUnit;
def IUnit50    : FuncUnit;
def IUnit51    : FuncUnit;
def IUnit52    : FuncUnit;
def IUnit53    : FuncUnit;
def IUnit54    : FuncUnit;
def IUnit55    : FuncUnit;
def IUnit56    : FuncUnit;
def IUnit57    : FuncUnit;
def IUnit58    : FuncUnit;
def IUnit59    : FuncUnit;
def IUnit60    : FuncUnit;
def IUnit61    : FuncUnit;
def IUnit62    : FuncUnit;
def IUnit63    : FuncUnit;
def IUnit64    : FuncUnit;

//===----------------------------------------------------------------------===//
// Instruction Itinerary classes used for HMC
//===----------------------------------------------------------------------===//
def IIAll       : InstrItinClass;
def IIAlu       : InstrItinClass;
def IICmpBr     : InstrItinClass;
def IICmpGr     : InstrItinClass;
def IISelect    : InstrItinClass;
def IIMultiply  : InstrItinClass;
def IILoad      : InstrItinClass;
def IILoadLr    : InstrItinClass;
def IIStore     : InstrItinClass;
def IIStoreLr   : InstrItinClass;
def IICpGrBr    : InstrItinClass;
def IICpBrGr    : InstrItinClass;
def IICpLrGr    : InstrItinClass;
def IICpGrLr    : InstrItinClass;
def IIBranch    : InstrItinClass;

def Simple16IssueMaxItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7, IUnit8, IUnit9, IUnit10, IUnit11,
IUnit12, IUnit13, IUnit14, IUnit15, IUnit16], [], [
   InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                                   IUnit4, IUnit5, IUnit6, IUnit7,
                                                   IUnit8, IUnit9, IUnit10, IUnit11,
                                                   IUnit12, IUnit13, IUnit14, IUnit15, IUnit16]>]>,
   InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                                   IUnit4, IUnit5, IUnit6, IUnit7,
                                                   IUnit8, IUnit9, IUnit10, IUnit11,
                                                   IUnit12, IUnit13, IUnit14, IUnit15,
                                                   IUnit16]>]>,
   InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IISelect      , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
   IUnit4, IUnit5, IUnit6, IUnit7,
   IUnit8, IUnit9, IUnit10, IUnit11,
   IUnit12, IUnit13, IUnit14, IUnit15,
   IUnit16]>]>,
   InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
   IUnit4, IUnit5, IUnit6, IUnit7,
   IUnit8, IUnit9, IUnit10, IUnit11,
   IUnit12, IUnit13, IUnit14, IUnit15]>]>,
   InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
   IUnit4, IUnit5, IUnit6, IUnit7,
   IUnit8, IUnit9, IUnit10, IUnit11,
   IUnit12, IUnit13, IUnit14, IUnit15]>]>,
   InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
   IUnit4, IUnit5, IUnit6, IUnit7,
   IUnit8, IUnit9, IUnit10, IUnit11,
   IUnit12, IUnit13, IUnit14, IUnit15]>]>,
   InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
   IUnit4, IUnit5, IUnit6, IUnit7,
   IUnit8, IUnit9, IUnit10, IUnit11,
   IUnit12, IUnit13, IUnit14, IUnit15]>]>,
   InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit16]>]>,
   InstrItinData<IIBranch      , [InstrStage<1,  [IUnit16]>]>
]>;

//def Simple32IssueMaxItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7, IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15, IUnit16, IUnit17, IUnit18, IUnit19, IUnit20,
//IUnit21, IUnit22, IUnit23, IUnit24, IUnit25, IUnit26, IUnit27, IUnit28,
//IUnit29, IUnit30, IUnit31], [], [
//InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7, IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15, IUnit16, IUnit17, IUnit18, IUnit19, IUnit20,
//IUnit21, IUnit22, IUnit23, IUnit24, IUnit25, IUnit26, IUnit27, IUnit28,
//IUnit29, IUnit30, IUnit31]>]>,
//InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15,
//IUnit16]>]>,
//InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IISelect      , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15,
//IUnit16]>]>,
//InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//IUnit4, IUnit5, IUnit6, IUnit7,
//IUnit8, IUnit9, IUnit10, IUnit11,
//IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit16]>]>,
//InstrItinData<IIBranch      , [InstrStage<1,  [IUnit16]>]>
//]>;

def Simple64Issue64MemModel : SchedMachineModel {
    let IssueWidth = 17;
    let LoadLatency = 1;
    let Itineraries = Simple16IssueMaxItineraries;
}

//def Simple32Issue32MemModel : SchedMachineModel {
//    let IssueWidth = 32;
//    let LoadLatency = 1;
//    let Itineraries = Simple32IssueMaxItineraries;
//}
