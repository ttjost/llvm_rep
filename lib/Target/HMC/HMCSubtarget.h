//===-------- HMCSubtarget.h - HMC Subtarget  -------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef HMCSUBTARGET_H
#define HMCSUBTARGET_H

#include "HMCFrameLowering.h"
#include "HMCISelLowering.h"
#include "HMCInstrInfo.h"
#include "HMCSelectionDAGInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/MC/MCInstrItineraries.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <string>
#include <memory>


#define GET_SUBTARGETINFO_HEADER
//#include "HMCSubtargetInfo.cpp"
#include "HMCGenSubtargetInfo.inc"

namespace llvm{

struct BBsInfo {
    std::map<StringRef, unsigned> BBInfo;
    std::map<StringRef, unsigned> numberOfNodes;
};
    
class StringRef;

class HMCTargetMachine;

    class HMCSubtarget : public HMCGenSubtargetInfo {
        
    public:
        
        enum HMCABIEnum{
            ABI32
        };
        
    protected:
        enum HMCArchEnum{
            simple_64issue
        };
        
        HMCArchEnum HMCArchVersion;
        
        HMCABIEnum HMCABI;
        
        unsigned AllocationOrder;
        
        // Tells whether is the new Scheduling Algorithm to be used
        // Used for my dissertation (Tiago)
        bool isNewScheduling;
        bool EnableVLIWScheduling;

        InstrItineraryData InstrItins;
        
        // Relocation Model
        Reloc::Model RM;
        
        Triple TargetTriple;
        
        const HMCSelectionDAGInfo TSInfo;
        
        HMCInstrInfo InstrInfo;
        HMCFrameLowering FrameLowering;
        HMCTargetLowering TLInfo;

        // Measure the height of each BB
        std::unique_ptr<BBsInfo> OptBBHeights;
        std::unique_ptr<BBsInfo> SchedBBHeights;

//        HMCTargetMachine &TM;
        
    public:

        BBsInfo* getOptBBHeights() const {
            OptBBHeights.get();
        }

        BBsInfo* getSchedBBHeights() const {
            SchedBBHeights.get();
        }

        unsigned getTargetABI() const { return HMCABI; }
        
        ///This constructor initializes the data members to match that
        /// of the specified triple
        HMCSubtarget(const Triple &TT, const std::string &CPU,
                     const std::string &FS, bool little, bool EnableVLIWScheduling,
                     Reloc::Model _RM, HMCTargetMachine &_TM);


        bool isSimple_64Issue() const { return HMCArchVersion == simple_64issue; }

        //- Virtual function, must have
        // ParseSubtargetFeatures - Parses features string settin specified
        // subtarget options. Definition of function is auto generated by tblgen
        void ParseSubtargetFeatures(StringRef CPU, StringRef FS);
        
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
        
        HMCSubtarget &initializeSubtargetDependencies(StringRef CPU,
                                                      StringRef FS);
        
        const HMCSelectionDAGInfo *getSelectionDAGInfo() const { return &TSInfo; }
        
        const HMCInstrInfo *getInstrInfo() const { return &InstrInfo; }
        
        const TargetFrameLowering *getFrameLowering() const {
            return &FrameLowering;
        }
        
        const HMCRegisterInfo *getRegisterInfo() const override {
            return &InstrInfo.getRegisterInfo();
        }
        
        const HMCTargetLowering *getTargetLowering() const override { return &TLInfo; }

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

