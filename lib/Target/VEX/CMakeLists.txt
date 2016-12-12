# Run This in QTCreator:
# -DCMAKE_INSTALL_PREFIX='~/llvm' -DLLVM_TARGETS_TO_BUILD=VEX ~/Dropbox/Universidade/Mestrado/llvm

set (LLVM_TARGET_DEFINITIONS Vex.td)

# Generate VEXGEnRegisterInfo.inc and VEXGenInstrInfo.inc which included by
#  your hand code C++ files.
# VEXGenRegisterInfo.inc came from VEXRegisterInfo.td, VEXGenInstrInfo.inc
#  came from VEXInstrInfo.td.

tablegen(LLVM VEXGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM VEXGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM VEXGenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM VEXGenPseudoLowering.inc -gen-pseudo-lowering)
tablegen(LLVM VEXGenDFAPacketizer.inc -gen-dfa-packetizer)
tablegen(LLVM VEXGenDAGISel.inc -gen-dag-isel)
tablegen(LLVM VEXGenCallingConv.inc -gen-callingconv)
tablegen(LLVM VEXGenCodeEmitter.inc -gen-emitter)
tablegen(LLVM VEXGenAsmWriter.inc -gen-asm-writer)

# VEXCommomTableGen must be defined
add_public_tablegen_target(VEXCommonTableGen)

# VEXCodeGen should match with LLVMBuild.txt VEXCodeGen
add_llvm_target(VEXCodeGen
  SPMVariable.cpp
  DataReuseInfo.cpp
  VEXDataReuseTracking.cpp
  VEXTargetMachine.cpp
  VEXFrameLowering.cpp
  VEXInstrInfo.cpp
  VEXISelLowering.cpp
  VEXMachineFunctionInfo.cpp
  VEXRegisterInfo.cpp
  VEXSubtarget.cpp
  VEXMachineScheduler.cpp
  VEXSelectionDAGInfo.cpp
  VEXAsmPrinter.cpp
  VEXMCInstLower.cpp
  VEXISelDAGToDAG.cpp
  VEXModifyBranches.cpp
  VEXVLIWPacketizer.cpp
  HexagonMachineScheduler.cpp
  VEXTreeHeightReduction.cpp
  VEXReorderFunctions.cpp
  VEXSchedulerMonitor.cpp
  )

# Should match with "subdirectories = MCTargetDesc TargetInfo" in LLVMBuild.txt
add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
add_subdirectory(InstPrinter)

