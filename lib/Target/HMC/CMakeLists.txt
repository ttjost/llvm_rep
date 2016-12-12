# Run This in QTCreator:
# -DCMAKE_INSTALL_PREFIX='~/llvm' -DLLVM_TARGETS_TO_BUILD=HMC ~/Dropbox/Universidade/Mestrado/llvm

set (LLVM_TARGET_DEFINITIONS HMC.td)

# Generate HMCGEnRegisterInfo.inc and HMCGenInstrInfo.inc which included by
#  your hand code C++ files.
# HMCGenRegisterInfo.inc came from HMCRegisterInfo.td, HMCGenInstrInfo.inc
#  came from HMCInstrInfo.td.

tablegen(LLVM HMCGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM HMCGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM HMCGenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM HMCGenPseudoLowering.inc -gen-pseudo-lowering)
tablegen(LLVM HMCGenDFAPacketizer.inc -gen-dfa-packetizer)
tablegen(LLVM HMCGenDAGISel.inc -gen-dag-isel)
tablegen(LLVM HMCGenCallingConv.inc -gen-callingconv)
tablegen(LLVM HMCGenCodeEmitter.inc -gen-emitter)
tablegen(LLVM HMCGenAsmWriter.inc -gen-asm-writer)

# HMCCommomTableGen must be defined
add_public_tablegen_target(HMCCommonTableGen)

# HMCCodeGen should match with LLVMBuild.txt HMCCodeGen
add_llvm_target(HMCCodeGen
  HMCTargetMachine.cpp
  HMCFrameLowering.cpp
  HMCInstrInfo.cpp
  HMCISelLowering.cpp
  HMCMachineFunctionInfo.cpp
  HMCRegisterInfo.cpp
  HMCSubtarget.cpp
  HMCMachineScheduler.cpp
  HMCSelectionDAGInfo.cpp
  HMCAsmPrinter.cpp
  HMCMCInstLower.cpp
  HMCISelDAGToDAG.cpp
  HMCVLIWPacketizer.cpp
  HexagonMachineScheduler.cpp
  HMCTreeHeightReduction.cpp
  )

# Should match with "subdirectories = MCTargetDesc TargetInfo" in LLVMBuild.txt
add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
add_subdirectory(InstPrinter)

