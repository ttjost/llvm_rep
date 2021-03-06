//===-------- VEXSubtarget.h - VEX Subtarget  -------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef VEXSUBTARGET_H
#define VEXSUBTARGET_H

#include "VEXFrameLowering.h"
#include "VEXISelLowering.h"
#include "VEXInstrInfo.h"
#include "VEXSelectionDAGInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/MC/MCInstrItineraries.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <string>
#include <memory>


#define GET_SUBTARGETINFO_HEADER
//#include "VEXSubtargetInfo.cpp"
#include "VEXGenSubtargetInfo.inc"

namespace llvm{

struct BBsInfo {
    std::map<StringRef, unsigned> BBInfo;
    std::map<StringRef, unsigned> numberOfNodes;
};
    
class StringRef;

class VEXTargetMachine;

    class VEXSubtarget : public VEXGenSubtargetInfo {
        
    public:
        
        enum VEXABIEnum{
            ABI32
        };
        
    protected:
        enum VEXArchEnum{
            rvex_2issue,
            rvex_4issue,
            rvex_8issue,
            rvex_generic,
            simple_2issue,
            simple_4issue,
            simple_8issue
        };
        
        VEXArchEnum VEXArchVersion;
        
        VEXABIEnum VEXABI;
        
        unsigned AllocationOrder;
        
        // Tells whether is the new Scheduling Algorithm to be used
        // Used for my dissertation (Tiago)
        bool isNewScheduling;
        bool EnableVLIWScheduling;

        InstrItineraryData InstrItins;
        
        // Relocation Model
        Reloc::Model RM;
        
        Triple TargetTriple;
        
        const VEXSelectionDAGInfo TSInfo;
        
        VEXInstrInfo InstrInfo;
        VEXFrameLowering FrameLowering;
        VEXTargetLowering TLInfo;

        // Measure the height of each BB
        std::unique_ptr<BBsInfo> OptBBHeights;
        std::unique_ptr<BBsInfo> SchedBBHeights;

//        VEXTargetMachine &TM;
        
    public:

        BBsInfo* getOptBBHeights() const {
            OptBBHeights.get();
        }

        BBsInfo* getSchedBBHeights() const {
            SchedBBHeights.get();
        }

        unsigned getTargetABI() const { return VEXABI; }
        
        ///This constructor initializes the data members to match that
        /// of the specified triple
        VEXSubtarget(const Triple &TT, const std::string &CPU,
                     const std::string &FS, bool little, bool EnableVLIWScheduling,
                     Reloc::Model _RM, VEXTargetMachine &_TM);

        
        //- Virtual function, must have
        // ParseSubtargetFeatures - Parses features string settin specified
        // subtarget options. Definition of function is auto generated by tblgen
        void ParseSubtargetFeatures(StringRef CPU, StringRef FS);
        
        bool isrVEX_2Issue() const { return VEXArchVersion == rvex_2issue; }
        bool isrVEX_4Issue() const { return VEXArchVersion == rvex_4issue; }
        bool isrVEX_8Issue() const { return VEXArchVersion == rvex_8issue; }
        bool isSimple_2Issue() const { return VEXArchVersion == simple_2issue; }
        bool isSimple_4Issue() const { return VEXArchVersion == simple_4issue; }
        bool isSimple_8Issue() const { return VEXArchVersion == simple_8issue; }
        
        const InstrItineraryData *getInstrItineraryData() const { return &InstrItins; }

        const
        unsigned RotateRegisterOrder() const {
//            AllocationOrder = (AllocationOrder + 1)%2;
            return AllocationOrder;
        }
        
        bool abiUsesSoftFloat() const;
        
        // FIXME : Why is StackAlignment 8 ????
        //unsigned stackAlignment() const {   return 8;   }
        unsigned stackAlignment() const {   return 32;   }
        
        VEXSubtarget &initializeSubtargetDependencies(StringRef CPU,
                                                      StringRef FS);
        
        const VEXSelectionDAGInfo *getSelectionDAGInfo() const { return &TSInfo; }
        
        const VEXInstrInfo *getInstrInfo() const { return &InstrInfo; }
        
        const TargetFrameLowering *getFrameLowering() const {
            return &FrameLowering;
        }
        
        const VEXRegisterInfo *getRegisterInfo() const override {
            return &InstrInfo.getRegisterInfo();
        }
        
        const VEXTargetLowering *getTargetLowering() const override { return &TLInfo; }

        bool enableMachineScheduler() const override;
        
        // We need to disable the Default Scheduler
        // If we don't do that, poor VLIW Code is generated
        bool enableMachineSchedDefaultSched() const override { return false; }
        
//        bool enablePostRAScheduler() const override {
//            return true;
//        }
//        bool enablePostMachineScheduler() const override { return true; }
        
    };
}

#endif

