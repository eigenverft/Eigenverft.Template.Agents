# Discover — Phase Contract

This file defines the common Discover behavior for every profile and future specialization. It is not a profile. Read this file and exactly one active strategy file from this directory before Discover.

## Objective and Scope

Discover **product opportunities**, not arbitrary code-edit tasks. Examine actual product evidence proportionately: observed behavior, known consumer groups, public contracts, documentation, code, tests, issues and workflows as relevant. Discovery is read-only; do not implement changes or create the primary implementation issue in this phase.

Inputs: understood user assignment and context, binding invariants from SKILL.md, selected Discover strategy and any natural-language scope refinements.

Output to Assess: normally 2–5 candidates where credible evidence supports them, each covering (a) observed problem or opportunity, (b) affected consumers and expected outcome, (c) baseline and evidence locations, (d) opportunity type, (e) uncertainties, dependencies and possible contract effects. No credible opportunity is a valid No change result.

## Non-negotiable Rules

- Distinguish observed facts, hypotheses and missing evidence. Do not invent user interviews, analytics, performance measurements or usage patterns.
- A broad search area is not permission for broad implementation.
- A user may tailor search domain, consumer audience and opportunity types in natural language without prescribing Assessment or Selection.
- Specialized Discover strategies must return evidence-backed comparable opportunities, preserve SKILL.md invariants and leave selection/implementation to subsequent phases.
