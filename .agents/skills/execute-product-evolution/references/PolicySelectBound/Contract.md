# Select & Bound — Phase Contract

This file defines the common Select & Bound behavior for every profile and future specialization. Read this contract before Select & Bound, and read **only the single strategy file selected by SKILL.md, if any**. Fully user-specified criteria may require no strategy file; an explicitly supported external specialization need not live in this directory. Do not load other profiles.

## Objective

Autonomously choose **one eligible, cohesive, worthwhile product increment** from the assessed opportunities. Cohesion is defined by **one understandable product outcome**, not by a repository directory, number of commits or lines changed. One meaningful increment may require changes across multiple technical layers.

Inputs: assessed opportunities, protected invariants, effective selection emphasis and applicable change budget.

Output to Record: (1) selected outcome and selection rationale; (2) observed baseline, intended benefit and verifiable acceptance criteria; (3) included and excluded scope; (4) consumer groups and contractual/behavioral invariants; (5) foreseeable risks, dependencies and rollback; (6) why the increment is feasible, complete and reviewable by a human.

## Mandatory Change-Budget Dimensions

Check cohesion, consumer/contract impact, semantic blast radius, human review complexity, risk, reversibility and ability to complete and verify in the available environment. Changed file count or line count is not a sufficient reviewability measure. If an attractive candidate is too broad, choose **one independently useful part**, never a knowingly incomplete feature. Keep other opportunities outside this run.

## Lightweight Pre-Selection Overlap Recheck

Before committing to the chosen increment **and before creating its issue, worktree or feature branch**, briefly recheck fresh available issue/PR/branch information for **that candidate's product area** (refresh remote refs where permitted, without changing the caller's checked-out branch). If another agent's work already implements or clearly claims the **same outcome**, discard this pick and select the next eligible candidate; if no eligible candidate remains, return **No change** without creating an issue, worktree or feature branch. Otherwise proceed. Do not block unrelated improvements just because the area name matches. This is a best-effort duplicate filter, not a guarantee against simultaneous selections, and requires no locks, reservations or expanded naming convention.

## Freeze and Controlled Rescoping

Freeze the *product outcome and outer change boundary* before Record, not the implementation details. If new information undermines feasibility, requires widening the boundary, or invalidates eligibility:
1. Stop unbounded implementation.
2. Return to Assess/Select as needed.
3. After an issue exists, preserve its original intent and append the reassessment/rescoping decision.
4. For a genuinely different product objective, abandon the original issue rather than silently repurposing it.
5. If no permissible increment remains, report Blocked/Abandoned or No change rather than false Done.

Users may specialize selection preferences and change size in natural language. Future strategies may adjust soft budget heuristics but must preserve SKILL.md invariants and deliver **one** self-contained reviewable increment.
