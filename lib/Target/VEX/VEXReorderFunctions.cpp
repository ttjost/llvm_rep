//===-- VEXReorderFunctions.cpp - Define TargetMachine for VEX -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Reorder functions in order to proper pass Scratchpads variables
// when calling functions
//
//===----------------------------------------------------------------------===//

#include "llvm/CodeGen/Passes.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/Casting.h"
#include "VEX.h"
#include <deque>
#include <vector>


#define DEBUG_TYPE "vex-reorder"

using namespace llvm;

namespace {

class VEXReorderFunctionsPass : public ModulePass {

    bool isMainFunction(Module::iterator F);

public:
    static char ID;
    VEXReorderFunctionsPass() : ModulePass(ID) {

    }

    const char *getPassName() const override {
        return "VEX Reorder Functions";
    }

    bool runOnModule(Module &M);
};

}

bool VEXReorderFunctionsPass::isMainFunction(Module::iterator F) {

    if (F->getName() == "main"){
        return true;
    } else {
        return false;
    }
}

bool VEXReorderFunctionsPass::runOnModule(Module &M) {

    DEBUG(M.dump());

    // Here we will perform a Breadth First Search
    // for searching the main function
    // and pushes into the FIFO.
    std::deque<Module::iterator> BFSinModule;
    std::vector<Module::iterator> AccessedFunctions;

    for (Module::iterator F = M.begin(), FE = M.end();
            F != FE; ++F) {
        if (isMainFunction(F)) {
            BFSinModule.push_back(F);
            AccessedFunctions.push_back(F);
            break;
        }
    }

    Module::iterator Func;
    while (!BFSinModule.empty()) {

        Func = BFSinModule.front();
        BFSinModule.pop_front();

        for (Function::iterator BB = Func->begin(), BBE = Func->end();
             BB != BBE; ++BB) {
            for (BasicBlock::iterator I = BB->begin(), E = BB->end();
                 I != E; ++I) {
                if (CallInst *Inst = dyn_cast<CallInst>(I)) {

                    Module::iterator CallFunc = Inst->getCalledFunction();

                    BFSinModule.push_back(CallFunc);

                    if (std::find(AccessedFunctions.begin(), AccessedFunctions.end(), CallFunc)
                            == AccessedFunctions.end())
                        AccessedFunctions.push_back(CallFunc);
                }
            }
        }

        ValueToValueMapTy VMap;
        Function *newFunc = CloneFunction(Func, VMap, false);
        M.getFunctionList().push_back(newFunc);
        Func->replaceAllUsesWith(newFunc);
        Func->eraseFromParent();
    }

    DEBUG(M.dump());
    return false;
}

char VEXReorderFunctionsPass::ID = 0;

ModulePass *llvm::createVEXReorderFunctionsPass() {
    return new VEXReorderFunctionsPass();
}

