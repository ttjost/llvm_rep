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
// // Instruction Itinerary classes used for VEX
// //===----------------------------------------------------------------------===//
// def IIAlu       : InstrItinClass;
// def IIBranch    : InstrItinClass;
// def IIMul       : InstrItinClass;
// def IILoad      : InstrItinClass;
// def IIStore     : InstrItinClass;

// //===----------------------------------------------------------------------===//
// // VEX Generic instruction itineraries.
// //===----------------------------------------------------------------------===//
// // http://llvm.org/docs/doxygen/html/structllvm_1_1InstrStage.html

// //                          FIXME:
// //      The latency of each class should be changed here.
// //
// //

// def VEXGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
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

//===----------------------------------------------------------------------===//
// Instruction Itinerary classes used for VEX
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

def IILane0     : InstrItinClass;
def IILane1     : InstrItinClass;
def IILane2     : InstrItinClass;
def IILane3     : InstrItinClass;
def IILane4     : InstrItinClass;
def IILane5     : InstrItinClass;
def IILane6     : InstrItinClass;
def IILane7     : InstrItinClass;
def IILane8     : InstrItinClass;
def IILane9     : InstrItinClass;
def IILane10    : InstrItinClass;
def IILane11    : InstrItinClass;
def IILane12    : InstrItinClass;
def IILane13    : InstrItinClass;
def IILane14    : InstrItinClass;
def IILane15    : InstrItinClass;

//===----------------------------------------------------------------------===//
// VEX Generic instruction itineraries.
//===----------------------------------------------------------------------===//
// http://llvm.org/docs/doxygen/html/structllvm_1_1InstrStage.html

//                          FIXME:
//      The latency of each class should be changed here.
//
//

//def VEXGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
//InstrItinData<IIMul              , [InstrStage<1,  [IUnit1, IUnit2]>]>,
//InstrItinData<IILoad             , [InstrStage<1,  [IUnit0]>]>,
//InstrItinData<IIStore            , [InstrStage<1,  [IUnit0]>]>,
//InstrItinData<IIBranch           , [InstrStage<1,  [IUnit3]>]>,
//InstrItinData<IIAlu              , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
//InstrItinData<IIAll              , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>
//]>;

def rVEX2IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit1]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>
]>;

def rVEX4IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit2]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>
]>;

def rVEX8IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
                                                  IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit2, IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def rVEX8Issue2CycleSPMItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
                                                  IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit2, IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<2,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<2,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<2,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<2,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<2,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<2,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<2,  [IUnit7]>]>
]>;

def rVEX4Issue2MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit2]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>
]>;

def rVEX8Issue2MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
                                                  IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit2, IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0, IUnit1]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def rVEX8IssueGenericItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<2,  [IUnit1, IUnit3, IUnit5, IUnit7]>]>,
InstrItinData<IILoad        , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<4,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<2,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<2,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit7]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def Simple2IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit1]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>
]>;

def Simple4IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit2]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>
]>;

def Simple4Issue4MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit2]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit3]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>
]>;


def Simple8IssueItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
                                                 IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit2, IUnit3, IUnit4,
                                               IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
                                               IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit7]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def Simple8Issue2MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit2, IUnit3, IUnit4,
IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit7]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def Simple8Issue4MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit2, IUnit3, IUnit4,
IUnit5, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit7]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;

def Simple8Issue8MemItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7], [], [
InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit1, IUnit3, IUnit5, IUnit7, IUnit2, IUnit4, IUnit0, IUnit6]>]>,
InstrItinData<IILoad        , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IIStore       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
IUnit4, IUnit5, IUnit6, IUnit7]>]>,
InstrItinData<IIBranch      , [InstrStage<1,  [IUnit7]>]>,

// ScratchPad Memory Instructions
// We separate them according to the their position.
// Each lane has its own Itinerary, therefore,
// we should define a diferent itinerary for each one of them.
InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>
]>;



def rVEX2IssueModel : SchedMachineModel {
    let IssueWidth = 2;
    let LoadLatency = 2;
    let Itineraries = rVEX2IssueItineraries;
}

def rVEX4IssueModel : SchedMachineModel {
    let IssueWidth = 4;
    let LoadLatency = 2;
    let Itineraries = rVEX4IssueItineraries;
}

def rVEX8IssueModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 2;
    let Itineraries = rVEX8IssueItineraries;
}

def rVEX8Issue2CycleSPMModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 2;
    let Itineraries = rVEX8Issue2CycleSPMItineraries;
}

def rVEX4Issue2MemModel : SchedMachineModel {
    let IssueWidth = 4;
    let LoadLatency = 2;
    let Itineraries = rVEX4Issue2MemItineraries;
}

def rVEX8Issue2MemModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 2;
    let Itineraries = rVEX8Issue2MemItineraries;
}

def rVEXGenericModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 2;
    let Itineraries = rVEX8IssueGenericItineraries;
}

def Simple2IssueModel : SchedMachineModel {
    let IssueWidth = 2;
    let LoadLatency = 1;
    let Itineraries = Simple2IssueItineraries;
}

def Simple4IssueModel : SchedMachineModel {
    let IssueWidth = 4;
    let LoadLatency = 1;
    let Itineraries = Simple4IssueItineraries;
}

def Simple8IssueModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 1;
    let Itineraries = Simple8IssueItineraries;
}

def Simple8Issue2MemModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 1;
    let Itineraries = Simple8Issue2MemItineraries;
}

def Simple4Issue4MemModel : SchedMachineModel {
    let IssueWidth = 4;
    let LoadLatency = 1;
    let Itineraries = Simple4Issue4MemItineraries;
}

def Simple8Issue4MemModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 1;
    let Itineraries = Simple8Issue4MemItineraries;
}

def Simple8Issue8MemModel : SchedMachineModel {
    let IssueWidth = 8;
    let LoadLatency = 1;
    let Itineraries = Simple8Issue8MemItineraries;
}

// def Simple16Issue2Mem16SPMItineraries : ProcessorItineraries<[IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15], [], [
//    InstrItinData<IIAll         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IIAlu         , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IICmpBr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IICmpGr       , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IISelect      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IIMultiply    , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IILoad        , [InstrStage<1,  [IUnit8, IUnit9]>]>,
//    InstrItinData<IILoadLr      , [InstrStage<1,  [IUnit8, IUnit9]>]>,
//    InstrItinData<IIStore       , [InstrStage<1,  [IUnit8, IUnit9]>]>,
//    InstrItinData<IIStoreLr     , [InstrStage<1,  [IUnit8, IUnit9]>]>,
//    InstrItinData<IICpGrBr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IICpBrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IICpLrGr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                    IUnit4, IUnit5, IUnit6, IUnit7,
//                                                    IUnit8, IUnit9, IUnit10, IUnit11,
//                                                    IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IICpGrLr      , [InstrStage<1,  [IUnit0, IUnit1, IUnit2, IUnit3,
//                                                   IUnit4, IUnit5, IUnit6, IUnit7,
//                                                   IUnit8, IUnit9, IUnit10, IUnit11,
//                                                   IUnit12, IUnit13, IUnit14, IUnit15]>]>,
//    InstrItinData<IIBranch      , [InstrStage<1,  [IUnit15]>]>,

//    // ScratchPad Memory Instructions
//    // We separate them according to the their position.
//    // Each lane has its own Itinerary, therefore,
//    // we should define a diferent itinerary for each one of them.
//    InstrItinData<IILane0       , [InstrStage<1,  [IUnit0]>]>,
//    InstrItinData<IILane1       , [InstrStage<1,  [IUnit1]>]>,
//    InstrItinData<IILane2       , [InstrStage<1,  [IUnit2]>]>,
//    InstrItinData<IILane3       , [InstrStage<1,  [IUnit3]>]>,
//    InstrItinData<IILane4       , [InstrStage<1,  [IUnit4]>]>,
//    InstrItinData<IILane5       , [InstrStage<1,  [IUnit5]>]>,
//    InstrItinData<IILane6       , [InstrStage<1,  [IUnit6]>]>,
//    InstrItinData<IILane7       , [InstrStage<1,  [IUnit7]>]>,
//    InstrItinData<IILane8       , [InstrStage<1,  [IUnit8]>]>,
//    InstrItinData<IILane9       , [InstrStage<1,  [IUnit9]>]>,
//    InstrItinData<IILane10       , [InstrStage<1,  [IUnit10]>]>,
//    InstrItinData<IILane11       , [InstrStage<1,  [IUnit11]>]>,
//    InstrItinData<IILane12       , [InstrStage<1,  [IUnit12]>]>,
//    InstrItinData<IILane13       , [InstrStage<1,  [IUnit13]>]>,
//    InstrItinData<IILane14       , [InstrStage<1,  [IUnit14]>]>,
//    InstrItinData<IILane15       , [InstrStage<1,  [IUnit15]>]>
// ]>;

// def Simple16Issue2Mem16SPMModel : SchedMachineModel {
//     let IssueWidth = 16;
//     let LoadLatency = 1;
//     let Itineraries = Simple16Issue2Mem16SPMItineraries;
// }

