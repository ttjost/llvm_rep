//
//  HMCTargetMachine.h
//  LLVM
//
//  Created by Tiago Trevisan Jost on 4/16/15.
//
//

#ifndef LLVM_HMCTARGETMACHINE_H
#define LLVM_HMCTARGETMACHINE_H

//#include "HMCConfig.h"

#include "HMCSubtarget.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"

namespace llvm {
    
    class formatted_raw_ostream;
    class HMCRegisterInfo;
    
class HMCTargetMachine : public LLVMTargetMachine{
    
private:
    bool isNewScheduling;

    HMCSubtarget Subtarget;
    
    mutable StringMap<std::unique_ptr<HMCSubtarget>> SubtargetMap;

    std::unique_ptr<TargetLoweringObjectFile> TLOF;

public:
    HMCTargetMachine(const Target &T, const Triple TT, StringRef CPU,
                      StringRef FS, const TargetOptions &Options,
                      Reloc::Model RM, CodeModel::Model CM,
                      CodeGenOpt::Level OL, bool isNewScheduling);
    ~HMCTargetMachine() override;

    const HMCSubtarget *getSubtargetImpl() const {
        return &Subtarget;
    }
    
    const HMCSubtarget *getSubtargetImpl(const Function &) const override {
        return &Subtarget;
    }

    // \brief Reset the subtarget for the HMC target.
    void resetSubtarget(MachineFunction *MF);
    
    // Pass Pipeline Configuration
    virtual TargetPassConfig *createPassConfig(PassManagerBase &PM);
    
    bool isNewSchedulingAlgorithm() const { return isNewScheduling; }

    //bool isVLIWScheduling() const { return EnableVLIWScheduling; }

    TargetLoweringObjectFile *getObjFileLowering() const override {
      return TLOF.get();
    }

};
 
// HMCRegTargetMachine - HMC (Normal Scheduling) Target Machine
class HMCNormalTargetMachine : public HMCTargetMachine{
    virtual void anchor();
public:
    HMCNormalTargetMachine(const Target &T, const Triple TT,
                           StringRef CPU, StringRef FS, const TargetOptions &Options,
                           Reloc::Model RM, CodeModel::Model CM,
                           CodeGenOpt::Level OL);
};
    
// HMCRegTargetMachine - HMC (New Scheduling) Target Machine
class HMCNewTargetMachine : public HMCTargetMachine{
    virtual void anchor();
public:
    HMCNewTargetMachine(const Target &T, const Triple TT,
                        StringRef CPU, StringRef FS, const TargetOptions &Options,
                        Reloc::Model RM, CodeModel::Model CM,
                        CodeGenOpt::Level OL);
};
    
}


#endif
