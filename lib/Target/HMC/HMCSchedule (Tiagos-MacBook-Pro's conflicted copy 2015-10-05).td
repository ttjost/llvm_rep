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
// // Functional units
// //===----------------------------------------------------------------------===//
// def IUnit0    : FuncUnit;
// def IUnit1    : FuncUnit;
// def IUnit2    : FuncUnit;
// def IUnit3    : FuncUnit;
// def IUnit4    : FuncUnit;
// def IUnit5    : FuncUnit;
// def IUnit6    : FuncUnit;
// def IUnit7    : FuncUnit;
// def IUnit8    : FuncUnit;
// def IUnit9    : FuncUnit;
// def IUnit10    : FuncUnit;
// def IUnit11    : FuncUnit;
// def IUnit12    : FuncUnit;
// def IUnit13    : FuncUnit;
// def IUnit14    : FuncUnit;
// def IUnit15    : FuncUnit;

// //===----------------------------------------------------------------------===//
// // Instruction Itinerary classes used for HMC
// //===----------------------------------------------------------------------===//
// def IIAlu       : InstrItinClass;
// def IIBranch    : InstrItinClass;
// def IIMul       : InstrItinClass;
// def IILoad      : InstrItinClass;
// def IIStore     : InstrItinClass;

// //===----------------------------------------------------------------------===//
// // HMC Generic instruction itineraries.
// //===----------------------------------------------------------------------===//
// // http://llvm.org/docs/doxygen/html/structllvm_1_1InstrStage.html

// //                          FIXME:
// //      The latency of each class should be changed here.
// //
// //

// def HMCGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
//                                                   IUnit4, IUnit5, IUnit6, IUnit7,
//                                                   IUnit8, IUnit9, IUnit10, IUnit11,
//                                                   IUnit12, IUnit13, IUnit14, IUnit15], [], [
// InstrItinData<IIMul              , [InstrStage<1,  [IUnit1, IUnit2]>]>,
// InstrItinData<IILoad             , [InstrStage<1,  [IUnit0]>]>,
// InstrItinData<IIStore            , [InstrStage<1,  [IUnit0]>]>,
// InstrItinData<IIBranch           , [InstrStage<1,  [IUnit3]>]>,
// InstrItinData<IIAlu              , [InstrStage<1,  [IUnit1, IUnit2, IUnit0, IUnit3,
//                                                     IUnit4, IUnit5, IUnit6, IUnit7,
//                                                     IUnit8, IUnit9, IUnit10, IUnit11,
//                                                     IUnit12, IUnit13, IUnit14, IUnit15]>]>
// ]>;


//===----------------------------------------------------------------------===//
// Functional units
//===----------------------------------------------------------------------===//

class FuncUnit;

def IUnit0    : FuncUnit;
def IUnit1    : FuncUnit;
def IUnit2    : FuncUnit;
def IUnit3    : FuncUnit;

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
def IICpGrBr    : InstrItinClass;
def IICpBrGr    : InstrItinClass;
def IICpLrGr    : InstrItinClass;
def IICpGrLr    : InstrItinClass;
def IISpill     : InstrItinClass;
def IIBranch    : InstrItinClass;
def IIMul       : InstrItinClass;

//===----------------------------------------------------------------------===//
// HMC Generic instruction itineraries.
//===----------------------------------------------------------------------===//
// http://llvm.org/docs/doxygen/html/structllvm_1_1InstrStage.html

//                          FIXME:
//      The latency of each class should be changed here.
//
//

//def HMCGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
//InstrItinData<IIMul              , [InstrStage<1,  [IUnit1, IUnit2]>]>,
//InstrItinData<IILoad             , [InstrStage<1,  [IUnit0]>]>,
//InstrItinData<IIStore            , [InstrStage<1,  [IUnit0]>]>,
//InstrItinData<IIBranch           , [InstrStage<1,  [IUnit3]>]>,
//InstrItinData<IIAlu              , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
//InstrItinData<IIAll              , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
//]>;

def HMCGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
InstrItinData<IIAll         , [InstrStage<,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IIAlu         , [InstrStage<0,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IISpill       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
InstrItinData<IIMul         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
]>;
