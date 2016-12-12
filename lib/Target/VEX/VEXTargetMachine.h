//
//  VEXTargetMachine.h
//  LLVM
//
//  Created by Tiago Trevisan Jost on 4/16/15.
//
//

#ifndef LLVM_VEXTARGETMACHINE_H
#define LLVM_VEXTARGETMACHINE_H

//#include "VEXConfig.h"

#include "VEXSubtarget.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "DataReuseInfo.h"

namespace llvm {
    
    class formatted_raw_ostream;
    class VEXRegisterInfo;
    
class VEXTargetMachine : public LLVMTargetMachine{
    
private:
    bool isNewScheduling;

    VEXSubtarget Subtarget;
    
    mutable StringMap<std::unique_ptr<VEXSubtarget>> SubtargetMap;

    std::unique_ptr<TargetLoweringObjectFile> TLOF;

    std::unique_ptr<DataReuseInfo> DataInfo;

public:
    VEXTargetMachine(const Target &T, const Triple TT, StringRef CPU,
                      StringRef FS, const TargetOptions &Options,
                      Reloc::Model RM, CodeModel::Model CM,
                      CodeGenOpt::Level OL, bool isNewScheduling);
    ~VEXTargetMachine() override;

    const VEXSubtarget *getSubtargetImpl() const {
        return &Subtarget;
    }
    
    const VEXSubtarget *getSubtargetImpl(const Function &) const override {
        return &Subtarget;
    }

    // \brief Reset the subtarget for the VEX target.
    void resetSubtarget(MachineFunction *MF);
    
    // Pass Pipeline Configuration
    virtual TargetPassConfig *createPassConfig(PassManagerBase &PM);
    
    bool isNewSchedulingAlgorithm() const { return isNewScheduling; }

    //bool isVLIWScheduling() const { return EnableVLIWScheduling; }

    TargetLoweringObjectFile *getObjFileLowering() const override {
      return TLOF.get();
    }

    DataReuseInfo *getDataReuseInfo() const {
      return DataInfo.get();
    }
};
 
// VEXRegTargetMachine - VEX (Normal Scheduling) Target Machine
class VEXNormalTargetMachine : public VEXTargetMachine{
    virtual void anchor();
public:
    VEXNormalTargetMachine(const Target &T, const Triple TT,
                           StringRef CPU, StringRef FS, const TargetOptions &Options,
                           Reloc::Model RM, CodeModel::Model CM,
                           CodeGenOpt::Level OL);
};
    
// VEXRegTargetMachine - VEX (New Scheduling) Target Machine
class VEXNewTargetMachine : public VEXTargetMachine{
    virtual void anchor();
public:
    VEXNewTargetMachine(const Target &T, const Triple TT,
                        StringRef CPU, StringRef FS, const TargetOptions &Options,
                        Reloc::Model RM, CodeModel::Model CM,
                        CodeGenOpt::Level OL);
};
    
}


#endif
