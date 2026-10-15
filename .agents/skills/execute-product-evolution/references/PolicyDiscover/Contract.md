# Discover — Phase Contract

This file defines the common Discover behavior for every profile and future specialization. It is not a profile. Read this contract before Discover, and read **only the single strategy file selected by SKILL.md, if any**. Fully user-specified criteria may require no strategy file; an explicitly supported external specialization need not live in this directory. Do not load other profiles.

## Objective and Scope

Discover **product opportunities**, not arbitrary code-edit tasks. Examine actual product evidence proportionately: observed behavior, known consumer groups, public contracts, documentation, code, tests, issues and workflows as relevant. Discovery is read-only; do not implement changes or create the primary implementation issue in this phase.

Inputs: understood user assignment and context, binding invariants from SKILL.md, selected Discover strategy and any natural-language scope refinements.

Output to Assess: **try to discover around five distinct, evidence-backed product opportunities** before selection, so Assess can compare meaningful alternatives instead of accepting the first technically valid edit. This is a **soft search aim, not a quota**: stay proportionate to the product, scope and available evidence; neither invent weak candidates nor keep searching without reasonable prospect of added value. Pass along fewer genuine candidates when that is what a reasonable search finds. For each, provide (a) observed problem or opportunity, (b) affected consumers and expected outcome, (c) baseline and evidence locations, (d) opportunity type, (e) uncertainties, dependencies and possible contract effects. No credible opportunity is a valid No change result.

## Non-negotiable Rules

- Distinguish observed facts, hypotheses and missing evidence. Do not invent user interviews, analytics, performance measurements or usage patterns.
- **Incidental observations outside the active Discover profile:** If a potentially interesting absence, behavior or idea arises naturally during the permitted investigation, it may be noted briefly without researching, assessing or selecting it. If this run later creates a primary issue, transfer worthwhile notes to its separate **`Incidental Discoveries (Out of Scope)`** section with the observed fact/context and explicit uncertainty. These are raw observations, **not qualified candidates or work commitments**. Do not widen Discover, create extra issues/files, or change the effective policy to pursue them; if no primary issue is created, no additional artifact is required.
- A broad search area is not permission for broad implementation.
- Apply the lightweight **area-overlap screen in SKILL.md**: check readily available existing/finished issues, PRs and feature-branch names by product area. Where a candidate overlaps, briefly verify whether its specific outcome is already done or being implemented; remove covered candidates rather than propose parallel duplicate work. Matching a broad area alone is not proof that every new need is covered. No exhaustive semantic search or coordination infrastructure.
- A user may tailor search domain, consumer audience and opportunity types in natural language without prescribing Assessment or Selection.
- Specialized Discover strategies must return evidence-backed comparable opportunities, preserve SKILL.md invariants and leave selection/implementation to subsequent phases.
