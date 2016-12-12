# MCTargetDesc/CMakeLists.txt
add_llvm_library(LLVMHMCDesc
  HMCMCAsmInfo.cpp
  HMCMCTargetDesc.cpp
  HMCTargetStreamer.cpp
  HMCBaseInfo.cpp
  )
