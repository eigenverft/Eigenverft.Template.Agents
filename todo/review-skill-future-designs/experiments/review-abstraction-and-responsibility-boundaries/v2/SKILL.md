---
name: review-abstraction-and-responsibility-boundaries-v2
description: Use for a read-only review when the user requests an assessment of abstraction boundaries and responsibility separation in existing code. Examine whether coherent behavior, state, and rules are effectively encapsulated and ordinary changes remain local. Evaluate practical boundary improvements from source evidence without prescribing patterns. Return findings only in chat and leave code and repository state unchanged.
---

# Review Abstraction and Responsibility Boundaries

Assess whether coherent behavior, state, and rules have effective responsibility boundaries, and whether ordinary changes stay local without unnecessary knowledge of other responsibilities. Ground proposals in actual source behavior rather than preferred abstraction patterns.

## 01 – Skill Selection

**Identity / Applicability.** This review concerns abstraction boundaries, responsibility separation, and encapsulation in existing code. Apply its criteria to the supplied review target without turning it into an unrelated audit.

## 02 – Review Setup

**Request Resolution.** Interpret the user's requested review target, constraints, language, and relevant conversation context. Preserve any explicit narrower scope or additional limits. Ask only if consequential ambiguity prevents a responsible review; otherwise state an appropriate narrow assumption.

**Objective.** Determine whether related behavior, state, and rules form understandable responsibilities that are *effectively* encapsulated. Central test:

> Can an ordinary change to this behavior be made mostly within the responsible area, without unnecessarily understanding or modifying other responsibilities?

Examine both **missing boundaries** and **unnecessary fragmentation** of one coherent responsibility. The goal is meaningful, source-supported improvements, not a particular object-oriented style.

**Target / Scope.** Identify the source areas or diff to assess and which responsibility boundaries matter. Investigate necessary callers, consumers, dependencies, contracts, and state transitions to support conclusions about that target, without turning the request into a general style, defect, performance, or architecture audit. The review scope is not automatically a ban on relevant external evidence.

**Context / Revision.** Determine which repository, revision, behavior, contracts, tests, requirements, and change scenarios the conclusions concern. Do not attribute observed implementation choices to an invented product intent.

**Authority.** Read and report only. Relevant source, tests, documentation, configuration, and history may be read as evidence. Do not modify source, tests, documentation, reports, or Git state; do not create patches, run project code, builds, tests, or generators, or implement recommendations. Report in chat only. A proposed fix never authorizes its execution.

**Evaluation Lens.** Responsibility ownership and effective encapsulation across domain or technical tasks, behavior, state, invariants, valid transitions, algorithms, compositions, lifetimes, cleanup, and collaboration. A class, file, method split, interface, private field, or shared storage alone does not prove or disprove a good boundary.

**Review Basis.** Use actual behavior and callers, observable contracts, constraints, valid state transitions, known variants, and ordinary plausible change scenarios. Distinguish a documented requirement from a reasonable hypothetical scenario. Do not fabricate a future roadmap or impose a named design pattern as an unstated standard. Where the basis is insufficient, preserve that uncertainty rather than inventing a rule.

**Method Contract.** Source-first, evidence-grounded, proportional and skeptical. Reconstruct what each area *actually* decides or owns; names and folder layout are clues, not proof. Use **03 – Investigation** to develop candidates, **04 – Evaluation** to verify their significance and evaluate remedies, and **05 – Review Reporting** to communicate only supported conclusions. Keep the output contract in mind throughout, without treating observations as already qualified findings.

## 03 – Investigation

**Broad discovery and tree-like candidate refinement before deep evaluation.**

1. **Discover a broad initial candidate space.** First reconstruct the actual tasks, decisions, state, rules, interactions, construction, lifetime, and cleanup within the selected scope. Deliberately scan more than the first promising concern: mixed responsibilities, scattered behavior/state/rules, bypassed ownership, caller knowledge, ineffective extracted units, excessive forwarding, unnecessarily fragmented coherent tasks, and relevant change paths. Collect *potential* investigation directions without immediately proving or designing fixes for each. A soft search aim of about **five distinct, credible leads or directions** can discourage premature stopping; it is neither a quota nor a requirement to invent concerns.
2. **Refine candidates as a tree of questions.** For each promising broad candidate, briefly ask what more specific responsibility questions it contains. Split only when the branches concern meaningfully different ownership, state, transitions, access paths, or collaboration effects. Use the already available context for a lightweight relevance check: a branch can be **worth deeper investigation**, **not worthwhile**, or **too broad and worth refining further**. Repeat locally only while that distinction improves the questions.
3. **Allow parent candidates to disappear.** An initial claim such as "this module mixes responsibilities" may dissolve into one plausible state-ownership question and several irrelevant branches. Keep the specific worthwhile branch, not the unsound or redundant parent. Do not inherit a parent's assumed problem or severity. A branch with meaningful unresolved uncertainty is not automatically irrelevant.
4. **Produce a shortlist of investigation-worthy candidates.** Collect the surviving concrete questions, remove obvious duplicates, and check whether important *different* responsibility directions within scope were prematurely overlooked. The shortlist contains **only candidates**: a relevance decision is **not validation**, and no candidate becomes a finding just because it survived. Do not require a printed tree, a formal queue, a fixed depth, a minimum surviving count, or any persisted artifact.
5. **Only then enter Evaluation.** Deeply trace evidence, counterarguments, practical change scenarios, and proposed boundaries for the surviving candidates in **04 – Evaluation**. If Evaluation reveals another material branch or a meaningful discovery gap, return selectively to Discover/Refine; do not restart an unbounded search.

Breadth is a guard against early fixation, not permission to exceed scope or to replace actual source inspection with a list of speculative labels. A sufficiently explored scope with no surviving candidates can legitimately proceed to Evaluation and a zero-finding result.

**Review depth and completion self-review.** Conduct discovery and evaluation with the depth expected from a **very intensive responsibility-boundary review** of the selected scope. Finding one or several plausible candidates or validated findings is **not a stopping condition**: continue investigating other relevant responsibility boundaries and evaluating material questions while further targeted inspection may change the conclusions. Before reporting, critically self-review whether important in-scope responsibilities, ownership of state and rules, access paths, ordinary change scenarios, or credible counterarguments were overlooked; return to discovery/refinement or evaluation to close material, answerable gaps. Stop only when further relevant investigation is unlikely to change the assessment, or disclose concrete evidence limitations. Do not invent findings or expand beyond the authorized scope.

## 04 – Evaluation

Evaluate each candidate reaching this phase against the evidence and criteria below. Do not treat relevance, an unusual code shape, or a conceivable refactoring as proof of a boundary problem.

**4.1 Validation — establish the actual situation.**

- Verify the concrete responsibility: what outcome is determined, which state and transitions are owned, what operations consumers use, who can bypass those operations, and which internals other areas must know. Ground claims in inspected symbols, access paths, callers, contracts, and appropriate tests or history.
- Distinguish syntactic nesting, runtime composition, and domain sub-responsibility. Shared storage, multiple writers, broad references, and central coordination can be legitimate; what matters is their actual use and ownership.
- Test the concern against an ordinary plausible change scenario: which decisions change, what must be understood, which areas really need edits, and why? Separate necessary multi-area collaboration from avoidable leaking of rules or implementation knowledge. Do not count files as a proxy for quality.
- Check relevant counterevidence. An apparently large class, long method, missing interface, single implementation, nested type, conditional branch, or several changed areas **alone** is not a finding. Avoid conclusions based solely on names, patterns, imagined future needs, or an unverified intent.
- If a candidate requires more material context, return selectively to Investigation when additional inquiry could change the conclusion. If decisive evidence cannot be obtained within authority and scope, preserve an honest limitation or conditional observation.

**4.2 Assessment — is a better boundary justified?**

- **Problem.** Identify a specific task, rule, decision, or coherent state responsibility unnecessarily mixed, exposed, or scattered, and its practical cost in understanding or ordinary changes.
- **Direction.** Consider a suitable owner and operations: object, subobject, function, module, system, existing owner, merged units, or other proportionate form. Explain which behavior, state, and rules belong together and what collaborations should remain. An interface or "extract service" is not by itself a remedy.
- **Benefit.** Show why the direction could remove external knowledge, repeated rule reconstruction, coordinated edits, or unnecessary navigation. Moving code without changing responsibility ownership is not a demonstrated improvement.
- **Countercheck.** Could the proposed boundary add pass-through layers, complicate initialization or lifetime, expose protected rules to callers, harm consistency or atomic coordination, weaken necessary collaboration, or violate runtime/memory constraints? Consider a credible simpler or less extensive alternative, including keeping the current shape. Respect required guarantees and existing consumers.
- Compare the whole practical effect, not just the local abstraction. A useful direction need not be a fully designed refactoring or demonstrated runtime fix, but it does require concrete source evidence of a drawback and improvement mechanism.

**4.3 Decisions — classify without inflating the result.**

- **Supported direction; scope needs design:** responsibility, drawback, and improvement benefit are supported, but exact transitions, interactions, or boundaries remain open. A recommendation can qualify if those open details would not overturn the direction itself; describe the bounded next design step.
- **Scope supported:** enough ownership, scope, and material collaboration is known to recommend a bounded first implementation step, without promising a verified implementation plan.
- **Conditional / unresolved:** the key responsibility, practical drawback, or benefit is not yet substantiated, or missing evidence could reverse the recommendation. Keep outside the main findings table and name what would resolve it.
- **Rejected / no material concern:** the premise is contradicted, collaboration is necessary, the proposed boundary makes things worse, or no worthwhile change is supported. Do not force a finding.

Group symptoms with the same underlying responsibility and improvement direction. Keep independently selectable proposals separate. Do not demand a minimum number of findings, a full architectural redesign, or mathematical certainty. End when the relevant candidates and major coverage limits are sufficiently understood for a proportional review, not simply because a checklist or candidate list is empty. A zero-finding or limited review is legitimate.

## 05 – Review Reporting

**Result Selection / Output Contract.** Write in the user's language and return only in chat. Begin with the reviewed scope and meaningful context or coverage limits. Choose findings, supporting explanation, alternatives, actions, and limitations only when justified; do not invent a universal verdict, fill empty sections, or publish rejected hypotheses as findings.

**Overview table when supported recommendations exist:**

| Ref | Severity | Responsibility and proposed change | Maturity | Assessment | Brief rationale |
| --- | --- | --- | --- | --- | --- |
| A | High | Specific responsibility: concrete proposed change | Direction supported; scope needs design | Expected benefit; estimated effort | Why worthwhile |

- Identify the actual responsibility and meaningful change in the proposal column; "improve encapsulation" or "extract a service" alone is insufficient.
- Use only **Critical** (grave immediate consequences), **High** (substantial impact on safe changes or important workflows), **Medium** (concrete bounded burden), or **Low** (small demonstrated drawback). Severity describes the problem, not implementation effort, confidence, or order of execution.
- Mark maturity as **Direction supported; scope needs design** or **Scope supported**. A supported direction may still have open implementation questions. Match any recommended first step to its maturity; do not silently treat open scope as settled.
- Assess qualitative benefit and estimated effort separately; state when effort is unknown. Order by severity, then practical benefit/effort, noting any different sensible implementation order or dependency. No finding quota and no architecture score.
- Use stable references **A**, **B**, **C**, etc. in both table and corresponding explanations. Group shared-cause symptoms; keep separately selectable corrections separate. Preserve references across revisions of the same report. Mention dependencies and mutually exclusive alternatives when relevant.

**Explanation for each supported finding.** Under `A) Specific responsibility and change` (and corresponding references), cover proportionately:

1. **Evidence and effect:** actual responsibility mixing or ineffective boundary, concrete source locations/symbols, and how it affects understanding or ordinary changes.
2. **Proposed direction:** existing versus proposed owner, state, rules, operations, useful locality, and retained collaboration.
3. **Assessment:** reason for severity, expected benefit, effort or its uncertainty, with credible counterarguments.
4. **Trade-offs and first step:** relevant preservation requirements and dependencies; a bounded implementation step if scope is supported, or a focused design decision if the direction is supported but scope is not settled.

**Unresolved observations and limitations.** Present important conditional opportunities separately without severity-rated recommendations. Distinguish observed facts, uncertainty, missing evidence, and useful next investigation. A supported problem with an unsettled solution should not be disguised as a ready implementation. Mention good existing boundaries only when they clarify the assessment; do not inventory everything that works.

**No finding / incomplete review.** If no supported recommendation qualifies, omit the empty table and finding sections; briefly state that no supported boundary-change recommendation was established in the examined scope. Report useful unresolved observations separately if present. If evidence or coverage is inadequate, state that limitation explicitly rather than implying that the code has been proven well structured.

Recommendations are **not authorized changes**. Implementation, committing, and publication require separate permission and an appropriate execution workflow.
