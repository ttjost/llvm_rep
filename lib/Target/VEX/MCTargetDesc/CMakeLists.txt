# MCTargetDesc/CMakeLists.txt
add_llvm_library(LLVMVEXDesc
  VEXMCAsmInfo.cpp
  VEXMCTargetDesc.cpp
  VEXTargetStreamer.cpp
  VEXBaseInfo.cpp
  )
