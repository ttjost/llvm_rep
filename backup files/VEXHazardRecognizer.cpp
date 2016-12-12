//===----- ScoreboardHazardRecognizer.cpp - Scheduler Support -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the ScoreboardHazardRecognizer class, which
// encapsultes hazard-avoidance heuristics for scheduling, based on the
// scheduling itineraries specified for the target.
//
//===----------------------------------------------------------------------===//

#include "VEXHazardRecognizer.h"
#include "VEX.h"
#include "VEXInstrInfo.h"
#include "llvm/CodeGen/ScheduleDAG.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/CodeGen/ScoreboardHazardRecognizer.h"
#include "llvm/CodeGen/ScheduleDAG.h"
#include "llvm/MC/MCInstrItineraries.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetInstrInfo.h"

using namespace llvm;

#define DEBUG_TYPE "VEX-hazard-recognizer"

static cl::opt<bool> EnableRVEX("enable-rvex",
                                cl::Hidden, cl::desc("Enable VLIW Scheduling"));

VEXHazardRecognizer::VEXHazardRecognizer(const InstrItineraryData *II,
                           const ScheduleDAG *SchedDAG,
                           const char *ParentDebugType) :
  ScheduleHazardRecognizer(), DAG(SchedDAG), ItinData(II), IssueWidth(0),
  IssueCount(0) {



  // Determine the maximum depth of any itinerary. This determines the depth of
  // the scoreboard. We always make the scoreboard at least 1 cycle deep to
  // avoid dealing with the boundary condition.
  unsigned ScoreboardDepth = 1;
  if (ItinData && !ItinData->isEmpty()) {
    for (unsigned idx = 0; ; ++idx) {
      if (ItinData->isEndMarker(idx))              //FIXME werkt soms niet
         break;

      const InstrStage *IS = ItinData->beginStage(idx);
      const InstrStage *E = ItinData->endStage(idx);

      // if ((IS->getCycles() == 0) && (IS->getNextCycles() == 0))   // FIXME om isEndMarker() op te vangen
      //   break;
      unsigned CurCycle = 0;
      unsigned ItinDepth = 0;
      for (; IS != E; ++IS) {
        unsigned StageDepth = CurCycle + IS->getCycles();
        if (ItinDepth < StageDepth) ItinDepth = StageDepth;
        CurCycle += IS->getNextCycles();
      }

      // Find the next power-of-2 >= ItinDepth
      while (ItinDepth > ScoreboardDepth) {
        ScoreboardDepth *= 2;
        // Don't set MaxLookAhead until we find at least one nonzero stage.
        // This way, an itinerary with no stages has MaxLookAhead==0, which
        // completely bypasses the scoreboard hazard logic.
        MaxLookAhead = ScoreboardDepth;
      }
    }
  }

  ReservedScoreboard.reset(ScoreboardDepth);
  RequiredScoreboard.reset(ScoreboardDepth);

  // If MaxLookAhead is not set above, then we are not enabled.
  if (!isEnabled())
    DEBUG(dbgs() << "Disabled scoreboard hazard recognizer\n");
  else {
    // A nonempty itinerary must have a SchedModel.
    IssueWidth = ItinData->SchedModel.IssueWidth;
    DEBUG(dbgs() << "Using scoreboard hazard recognizer: Depth = "
          << ScoreboardDepth << '\n');
  }
}

void VEXHazardRecognizer::Reset() {
  IssueCount = 0;
  RequiredScoreboard.reset();
  ReservedScoreboard.reset();
  Hazards.clear();
}

bool VEXHazardRecognizer::atIssueLimit() const {
  if (IssueWidth == 0)
    return false;

  return IssueCount == IssueWidth;
}

bool VEXHazardRecognizer::isDataHazard(SUnit const* SU) {
  const MachineInstr *instr = SU->getInstr();

  if (!instr) {
    return false;
  }
  for (auto const& op : instr->uses()) {
    for (auto const& haz : Hazards) {
      if(op.isReg() && op.getReg() == haz.Register) {
        return true;
      }
    }
  }
  return false;
}

void VEXHazardRecognizer::updateDataHazard(SUnit const* SU) {
  
    const MachineInstr *instr = SU->getInstr();

    if (!instr) {
      return;
    }
    
    if (!EnableRVEX)
        return;
    
    uint8_t stalls;

    switch (instr->getDesc().getSchedClass()) {
    case VEX::Sched::IIBranch:
    case VEX::Sched::IILoad:
    case VEX::Sched::IIMultiply:
    case VEX::Sched::IICmpBr:
    case VEX::Sched::IICpGrBr:
    case VEX::Sched::IICpGrLr:
        stalls = 2;
        break;
    case VEX::Sched::IILoadLr:
    case VEX::Sched::IIStoreLr:
        stalls = 3;
        break;
    default:
        stalls = 0;
  }

    if (stalls == 0) {
        return;
    }

    for (auto const &op : instr->defs()) {
    #ifndef NDEBUG
        for (auto const &haz : Hazards) {
            assert(op.getReg() != haz.Register && "Defining register should not be in hazards.");
        }
    #endif
        Hazards.push_back(DataHazard {op.getReg(), stalls} );
    }
}

ScheduleHazardRecognizer::HazardType
VEXHazardRecognizer::getHazardType(SUnit *SU, int Stalls) {
  
    if (isDataHazard(SU)) {
        return NoopHazard;
    }

    if (!ItinData || ItinData->isEmpty())
        return NoHazard;

    // Note that stalls will be negative for bottom-up scheduling.
    int cycle = Stalls;

    // Use the itinerary for the underlying instruction to check for
    // free FU's in the scoreboard at the appropriate future cycles.

    const MCInstrDesc *MCID = DAG->getInstrDesc(SU);
    if (MCID == NULL) {
        // Don't check hazards for non-machineinstr Nodes.
        return NoHazard;
    }
    
    unsigned idx = MCID->getSchedClass();
    for (const InstrStage *IS = ItinData->beginStage(idx),
         *E = ItinData->endStage(idx); IS != E; ++IS) {
        // We must find one of the stage's units free for every cycle the
        // stage is occupied. FIXME it would be more accurate to find the
        // same unit free in all the cycles.
        for (unsigned int i = 0; i < IS->getCycles(); ++i) {
            int StageCycle = cycle + (int)i;
            
            if (StageCycle < 0)
                continue;

            if (StageCycle >= (int)RequiredScoreboard.getDepth()) {
                assert((StageCycle - Stalls) < (int)RequiredScoreboard.getDepth() &&
                       "Scoreboard depth exceeded!");
                // This stage was stalled beyond pipeline depth, so cannot conflict.
                break;
            }

            unsigned freeUnits = IS->getUnits();
            switch (IS->getReservationKind()) {
                case InstrStage::Required:
                    // Required FUs conflict with both reserved and required ones
                    freeUnits &= ~ReservedScoreboard[StageCycle];
                    // FALLTHROUGH
                case InstrStage::Reserved:
                    // Reserved FUs can conflict only with required ones.
                    freeUnits &= ~RequiredScoreboard[StageCycle];
                    break;
            }

            if (!freeUnits) {
                DEBUG(dbgs() << "*** Hazard in cycle +" << StageCycle << ", ");
                DEBUG(dbgs() << "SU(" << SU->NodeNum << "): ");
                DEBUG(DAG->dumpNode(SU));
                return Hazard;
            }
        }

        // Advance the cycle to the next stage.
        cycle += IS->getNextCycles();
    }

    return NoHazard;
}

void VEXHazardRecognizer::EmitInstruction(SUnit *SU) {
  
    updateDataHazard(SU);

    if (!ItinData || ItinData->isEmpty())
        return;

    // Use the itinerary for the underlying instruction to reserve FU's
    // in the scoreboard at the appropriate future cycles.
    const MCInstrDesc *MCID = DAG->getInstrDesc(SU);
    assert(MCID && "The scheduler must filter non-machineinstrs");
    if (DAG->TII->isZeroCost(MCID->Opcode))
        return;

    ++IssueCount;

    unsigned cycle = 0;

    unsigned idx = MCID->getSchedClass();
    for (const InstrStage *IS = ItinData->beginStage(idx),
         *E = ItinData->endStage(idx); IS != E; ++IS) {
        // We must reserve one of the stage's units for every cycle the
        // stage is occupied. FIXME it would be more accurate to reserve
        // the same unit free in all the cycles.
        for (unsigned int i = 0; i < IS->getCycles(); ++i) {
            assert(((cycle + i) < RequiredScoreboard.getDepth()) &&
                   "Scoreboard depth exceeded!");

            unsigned freeUnits = IS->getUnits();
            switch (IS->getReservationKind()) {
                case InstrStage::Required:
                    // Required FUs conflict with both reserved and required ones
                    freeUnits &= ~ReservedScoreboard[cycle + i];
                    // FALLTHROUGH
                case InstrStage::Reserved:
                    // Reserved FUs can conflict only with required ones.
                    freeUnits &= ~RequiredScoreboard[cycle + i];
                    break;
            }

            // reduce to a single unit
            unsigned freeUnit = 0;
            do {
                freeUnit = freeUnits;
                freeUnits = freeUnit & (freeUnit - 1);
            } while (freeUnits);

            if (IS->getReservationKind() == InstrStage::Required)
                RequiredScoreboard[cycle + i] |= freeUnit;
            else
                ReservedScoreboard[cycle + i] |= freeUnit;
        }

        // Advance the cycle to the next stage.
        cycle += IS->getNextCycles();
    }

    //DEBUG(ReservedScoreboard.dump());
    //DEBUG(RequiredScoreboard.dump());
}

void VEXHazardRecognizer::AdvanceCycle() {

    for (auto it = Hazards.begin();
         it != Hazards.end();) {
        it->Cycles--;
        dbgs() << Hazards.size() << "\n";
        if (it->Cycles == 0) {
            it = Hazards.erase(it);
//            if (it == e)
//                break;
        } else
            ++it;
    }

    IssueCount = 0;
    ReservedScoreboard[0] = 0; ReservedScoreboard.advance();
    RequiredScoreboard[0] = 0; RequiredScoreboard.advance();
}



