//===-- HMCTreeHeightReduction.cpp - Tree Height Reduction Pass -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Implements the a Tree Height reduction pass for the HMC target.
//
// Reference: "Incremental For High Tree Height Reduction Level Synthesis"
//
//===----------------------------------------------------------------------===//
//  Created by Tiago Trevisan Jost on 4/17/16.


#include "HMC.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include <deque>
#include <vector>
#include <map>

#define DEBUG_TYPE "HMC-thr"

using namespace llvm;

namespace {
    
class HMCTreeHeightReductionPass : public BasicBlockPass {

    // We have two vectors with the same content. However, we sort them differently
    // Here we create a vector in order to properly sort the heights of the tree;
    std::multimap<unsigned, Instruction *> HeightsByLevel;
    std::map<Instruction *, unsigned> HeightsByInstrOrder;

    std::vector<Instruction *> Roots;
    std::deque<Value *> Leaves;

public:
    static char ID;
    
    HMCTreeHeightReductionPass() : BasicBlockPass(ID) {
    }
    
    const char *getPassName() const override {
        return "HMC Tree Height Reduction Pass";
    }
    
    /// Iterate over the functions and promote the computation of interesting
    // sext instructions.
    bool runOnBasicBlock(BasicBlock &BB) override;
    
    void computeNodes(BasicBlock &BB);
    void computeNode(Instruction* I);
    void computeLeaves();
    void updateLeaves();
    
    void computeHeights();
    void computeHeight(Instruction* I);
    
    bool isValidOperation(Instruction* I);

    // Huffman Optimization for Tree Height Reduction
    void BalanceTree(Instruction *I);
    bool isLeaf(Instruction *I);
    void removeUnrelatedNodes();
    void FindRoots();
    
};
    
}

bool HMCTreeHeightReductionPass::isValidOperation(Instruction* I) {

    if (!isa<BinaryOperator>(I))
        return false;

    BinaryOperator* AluInst = cast<BinaryOperator>(I);

    if (AluInst->getOpcode() == Instruction::Add)
        return true;

    return false;
}

void HMCTreeHeightReductionPass::computeLeaves() {
    
    DEBUG(dbgs() << "***** Computing Leaves *****\n");
    
    std::map<Instruction *, unsigned> tempHeightsByInstrOrder;

    for (std::map<Instruction *, unsigned>::iterator it = HeightsByInstrOrder.begin();
         it != HeightsByInstrOrder.end(); ++it) {
        
        Instruction *I = it->first;

        DEBUG(dbgs() << "***** Num operands " << I->getNumOperands());
        DEBUG(I->dump());
        DEBUG(dbgs() << "***** Num operands " << I->getNumOperands());

        Instruction *FirstOp;

        if (I->getNumOperands() > 0)
             FirstOp = dyn_cast<Instruction>(I->getOperand(0));
        else
            continue;

        Instruction *SecondOp;

        if (I->getNumOperands() > 1)
             SecondOp = dyn_cast<Instruction>(I->getOperand(1));

        if (FirstOp) {
            if (HeightsByInstrOrder.find(FirstOp) == HeightsByInstrOrder.end()) {
                tempHeightsByInstrOrder[FirstOp] = 0;
                
                DEBUG(dbgs() << "First Op Instruction: ");
                DEBUG(FirstOp->dump());
            }
        }
        
        if (SecondOp) {
            if (HeightsByInstrOrder.find(SecondOp) == HeightsByInstrOrder.end()) {
                tempHeightsByInstrOrder[SecondOp] = 0;

                DEBUG(dbgs() << "Second Op Instruction: ");
                DEBUG(SecondOp->dump());
            }
        }
    }

    for (std::map<Instruction *, unsigned>::iterator it = tempHeightsByInstrOrder.begin();
         it != tempHeightsByInstrOrder.end(); ++it) {
        HeightsByInstrOrder[it->first] = it->second;
    }

    DEBUG(dbgs() << "***** Finalized Computing Leaves *****\n");
    
}
void HMCTreeHeightReductionPass::computeNode(Instruction* I) {
    
    if (isValidOperation(I)) {
        
        bool isInValidChain = false;
        for (Value::use_iterator i = I->use_begin(),
             e = I->use_end(); i != e; ++i) {
            
            Instruction *Use = cast<Instruction>(i->getUser());
            if (HeightsByInstrOrder.find(Use) != HeightsByInstrOrder.end()) {
                isInValidChain = true;
            }
        }
        Instruction *FirstOp, *SecondOp;
        
        FirstOp = dyn_cast<Instruction>(I->getOperand(0));
        SecondOp = dyn_cast<Instruction>(I->getOperand(1));
        
        if (FirstOp) {
            if (isValidOperation(FirstOp)) {
                isInValidChain = true;
            }
        }
        
        if (SecondOp) {
            if (isValidOperation(SecondOp)) {
                isInValidChain = true;
            }
        }
        
        if (isInValidChain) {
            HeightsByInstrOrder[I] = 0;
            
            DEBUG(dbgs() << "Instruction: ");
            DEBUG(I->dump());
            DEBUG(dbgs() << " Height: " << HeightsByInstrOrder[I] << "\n");
        }
    }
}

void HMCTreeHeightReductionPass::computeNodes(BasicBlock &BB) {
    
    DEBUG(dbgs() << "***** Computing Nodes *****\n");
    
    for (BasicBlock::reverse_iterator It = BB.rbegin(), ItE = BB.rend(); It != ItE; ++It) {
        Instruction *Inst = &*It;
        computeNode(Inst);
    }
    DEBUG(dbgs() << "***** Finalizing Computing Nodes *****\n");
    
    computeLeaves();
}

void HMCTreeHeightReductionPass::computeHeight(Instruction* I) {
    
    unsigned max = 0;
    Instruction *FirstOp;
    Instruction *SecondOp;

    if (I->getNumOperands() > 0)
         FirstOp = dyn_cast<Instruction>(I->getOperand(0));
    else
         FirstOp = nullptr;
    
    if (I->getNumOperands() > 1)
        SecondOp = dyn_cast<Instruction>(I->getOperand(1));
    else
        SecondOp = nullptr;
    
    if (HeightsByInstrOrder[I] != 0)
        return;
    
    if (isValidOperation(I)) {
        
        if (FirstOp) {
            if (HeightsByInstrOrder.find(FirstOp) != HeightsByInstrOrder.end()) {
                if (HeightsByInstrOrder[FirstOp] == 0)
                    computeHeight(FirstOp);
                max = max > HeightsByInstrOrder[FirstOp] ? max : HeightsByInstrOrder[FirstOp];
            }
        }
        
        if (SecondOp) {
            if (HeightsByInstrOrder.find(SecondOp) != HeightsByInstrOrder.end()) {
                if (HeightsByInstrOrder[SecondOp] == 0)
                    computeHeight(SecondOp);
                max = max > HeightsByInstrOrder[SecondOp] ? max : HeightsByInstrOrder[SecondOp];
            }
        }
    }
        HeightsByInstrOrder[I] = 1 + max;
        HeightsByLevel.insert(std::pair<unsigned, Instruction *>(1 + max, I));
    
        DEBUG(dbgs() << "Instruction: ");
        DEBUG(I->dump());
        DEBUG(dbgs() << " Height: " << HeightsByInstrOrder[I] << "\n");
}

void HMCTreeHeightReductionPass::computeHeights() {
    
    DEBUG(dbgs() << "***** Computing Heights *****\n");
    
    for (std::map<Instruction *, unsigned>::iterator it = HeightsByInstrOrder.begin(); it != HeightsByInstrOrder.end(); ++it) {
        Instruction *Inst = it->first;
        computeHeight(Inst);
    }
    
    DEBUG(dbgs() << "***** Finalizing Computing Heights *****\n");
}

void HMCTreeHeightReductionPass::updateLeaves() {
    
    DEBUG(dbgs() << "***** Updating Leaves *****\n");
    
    std::multimap<unsigned, Instruction *>::iterator it = HeightsByLevel.begin();
    std::multimap<unsigned, Instruction *>::iterator itEnd = HeightsByLevel.end();

    while (it->first == 1 && it != itEnd) {
        Instruction *I = it->second;
        Leaves.push_back(cast<Instruction>(I));
        ++it;
    }
    
    DEBUG(dbgs() << "***** Finalizing Computing Heights *****\n");
    
    
}

bool HMCTreeHeightReductionPass::isLeaf(Instruction *I) {

    if (HeightsByInstrOrder[I] == 1)
        return true;
    else
        return false;
}

void HMCTreeHeightReductionPass::removeUnrelatedNodes() {
    
    unsigned LastLevel = HeightsByLevel.rbegin()->first;
    for (std::multimap<unsigned, Instruction *>::iterator it = HeightsByLevel.begin();
         it != HeightsByLevel.end();) {
        
        bool isPresented = false;
        
        if (it->first == LastLevel) {
            ++it;
            isPresented = true;
            continue;
        }
        
        for (Value::use_iterator i = (it->second)->use_begin(),
             e = (it->second)->use_end(); i != e; ++i) {
                
             Instruction *Use = cast<Instruction>(i->getUser());
             if (HeightsByInstrOrder.find(Use) != HeightsByInstrOrder.end())
                 isPresented = true;
        }
        
        if (!isPresented) {
            std::multimap<unsigned, Instruction *>::iterator tempIt = it++;
//            (tempIt->second)->dump();
            HeightsByLevel.erase(tempIt);
            HeightsByInstrOrder.erase(tempIt->second);
        } else
            ++it;
    }
    
}

void HMCTreeHeightReductionPass::BalanceTree(Instruction *I) {

    std::vector<Instruction *> WorkList;

    assert(I->getNumOperands() == 2 && "Number of Operands should be 2");
    WorkList.push_back(dyn_cast<Instruction>(I->getOperand(0)));
    WorkList.push_back(dyn_cast<Instruction>(I->getOperand(1)));

    while (!WorkList.empty()) {

        Instruction *T = WorkList.back();
        WorkList.pop_back();

        if (std::find(Roots.begin(), Roots.end(), T) != Roots.end())
            llvm_unreachable("We do not implement subtraction yet. This is not difficult to support, though");
        else
            if (!isLeaf(I) && T->getOpcode() == I->getOpcode()) {
                assert(T->getNumOperands() == 2 && "Number of Operands should be 2");
                WorkList.push_back(dyn_cast<Instruction>(T->getOperand(0)));
                WorkList.push_back(dyn_cast<Instruction>(T->getOperand(1)));
            }
    }

    IRBuilder<> Builder(I);
    Value *R1;

    while (Leaves.size() > 1) {
        Instruction *Ra1 = dyn_cast<Instruction>(Leaves.front());
        Leaves.pop_front();
        DEBUG(dbgs() << "Ra1: ");
        DEBUG(Ra1->dump());
        Instruction *Rb1 = cast<Instruction>(Leaves.front());
        Leaves.pop_front();
        DEBUG(dbgs() << "Rb1: ");
        DEBUG(Rb1->dump());
        R1 = Builder.CreateAdd(Ra1, Rb1);

        Leaves.push_back(R1);
        DEBUG(dbgs() << "Dst: ");
        DEBUG(R1->dump());
    }

    I->replaceAllUsesWith(R1);

    for (std::multimap<unsigned, Instruction *>::reverse_iterator it = HeightsByLevel.rbegin(); it != HeightsByLevel.rend(); ++it) {
        if (it->first != 1) {
            (it->second)->eraseFromParent();
        }
    }
}

void HMCTreeHeightReductionPass::FindRoots() {

    // We should search for instructions with have
    // more than one use. We still don't know how to treat them.
    // We will delete all instructions after that.
    // TODO: This should be fixed to handle instructions with multiple uses.
    for (std::multimap<unsigned, Instruction *>::iterator it = HeightsByLevel.begin(); it != HeightsByLevel.end(); ++it) {
        Instruction *I = it->second;

//        if (isLeaf(I))
//            continue;
//        
//        for (Value::use_iterator i = I->use_begin(), e = I->use_end(); i != e; ++i) {
//            
//        }
        
        if (I->getNumUses() > 1) {
            std::multimap<unsigned, Instruction *>::iterator iterator = it;
            ++iterator;
            while (iterator != HeightsByLevel.end()) {
                std::multimap<unsigned, Instruction *>::iterator tempIt = iterator;
                ++iterator;
                HeightsByLevel.erase(tempIt);
                HeightsByInstrOrder.erase(tempIt->second);
            }
            break;
        }
    }
    
    removeUnrelatedNodes();
    updateLeaves();
    
    // We sure must insert the last node as root
    if (HeightsByLevel.size() > 5) {
        Roots.push_back(HeightsByLevel.rbegin()->second);
    
        while (!Roots.empty()) {
            BalanceTree(Roots.back());
            Roots.pop_back();
        }
    }
}

bool HMCTreeHeightReductionPass::runOnBasicBlock(BasicBlock &BB) {
    
    DEBUG(dbgs() << "HMC Tree Height Reduction!\n");
    DEBUG(BB.dump());
    
    HeightsByLevel.clear();
    HeightsByInstrOrder.clear();
    Roots.clear();
    Leaves.clear();
    
    computeNodes(BB);
    computeHeights();
    
    // There is no way to improve over trees with 3 or less nodes.
    // We just leave the way it is.
    if (HeightsByLevel.size() > 5) {
        FindRoots();   
        return true;
    }
    
    return false;
}

char HMCTreeHeightReductionPass::ID = 0;

BasicBlockPass *llvm::createHMCTreeHeightReductionPass() {
    return new HMCTreeHeightReductionPass();
}

