#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"

using namespace llvm;

int main(){
    
    LLVMContext &context = getGlobalContext();
    Module* module = new Module("top", context);
    
    IRBuilder<> builder(context);
    
    FunctionType  *funcType = FunctionType::get(builder.getVoidTy(), false);
    Function *mainFunc = Function::Create(funcType, Function::ExternalLinkage, "main", module);
    
    BasicBlock *entry = BasicBlock::Create(context, "entrypoint", mainFunc);
    builder.SetInsertPoint(entry);
    
    Value *helloWorld = builder.CreateGlobalStringPtr("hello world!\n");
    
    std::vector<llvm::Type *> putsArgs;
    putsArgs.push_back(builder.getInt8Ty()->getPointerTo());
    ArrayRef<Type*> argsRef(putsArgs);
    
    FunctionType *putsType = FunctionType::get(builder.getInt32Ty(), argsRef, false);
    Constant *putsFunc = module->getOrInsertFunction("puts", putsType);
    
    builder.CreateCall(putsFunc, helloWorld);
    builder.CreateRetVoid();
    
    module->dump();
    
}