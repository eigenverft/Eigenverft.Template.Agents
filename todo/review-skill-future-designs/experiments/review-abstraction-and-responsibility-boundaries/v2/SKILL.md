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

**Coverage-led discovery, branch refinement, and explicit completeness gates before deep evaluation.** Investigate the selected scope with the diligence of an intensive responsibility-boundary review. A few plausible candidates or strong-looking findings are **not** a reason to stop searching. Search quality is established by relevant coverage and meaningful follow-up, **not** by reaching a candidate count.

1. **Map the responsibility surface before selecting concerns.** Read enough actual source and surrounding contracts to identify the main tasks, decisions, state owners, rules and valid transitions, cross-boundary readers/writers, collaboration, and relevant construction, lifetime, or cleanup. Maintain a compact **working coverage inventory**: significant in-scope responsibilities and access paths examined, still unexamined, or blocked by missing evidence. Do not infer coverage from file counts or names. The inventory stays in working context; it is not a mandatory file or separate user-facing report.
2. **Make a deliberate first discovery pass across the mapped scope.** For each significant responsibility area, inspect the relevant code and check **both directions**: coherent behavior/state/rules inadequately owned or exposed, and an existing coherent responsibility unnecessarily scattered across units. Look for bypassed operations, external reconstruction of internal rules, shared mutable access, ineffective extracted units, forwarding-only boundaries, and ordinary changes that require avoidable cross-area knowledge. Record credible initial candidates with **source anchor, observed structure, and the specific responsibility question**. A generic category label or an uninspected hunch is not a candidate. Do not let the first promising concern consume the entire search.
3. **Make a complementary second discovery pass.** Revisit the selected scope from a *different route* instead of merely rereading the first findings: for example, trace ordinary change scenarios from decision to affected consumers, or trace state and rule ownership backward from callers and mutations. Specifically inspect meaningful areas or boundary crossings underrepresented in the first pass, and look for contrasting evidence that an apparent split is intentional or an apparent central owner is appropriate. Add genuinely new questions and revise mistaken ones. **Do not declare discovery complete because one or several findings already look convincing.** There is no fixed minimum or maximum number of candidates; continue where another targeted inspection has a reasonable chance of exposing a distinct material concern.
4. **Refine every credible initial candidate before deep validation.** Ask which concrete, independently investigable responsibility questions sit beneath each broad suspicion. **Keep** a focused question when it already identifies a plausible owner/rule/access issue; **split** a broad candidate into materially different branches and examine their relevance; **drop** an irrelevant, redundant, or contradicted branch with a reason; **retain as uncertain** a branch whose relevance depends on unresolved material context. Iterate only where subdivision clarifies distinct questions. A parent can disappear while one child survives. Do not inherit the parent's presumed problem or severity.
5. **Apply the candidate handoff gate.** Before entering Evaluation, check that the important mapped in-scope responsibility areas and boundary crossings have received actual attention, the complementary pass was performed, and each credible starting branch was kept, refined, rejected, or marked uncertain. Each surviving candidate must identify **where the suspicion arises, what responsibility question is open, and what evidence remains to be checked**. If relevant scope or candidate branches were skipped, return to discovery/refinement before proceeding. If coverage is blocked, record the specific limitation. This is an operational working result, not a requirement to print the tree, persist a queue, or manufacture findings.
6. **Only then evaluate the surviving questions in phase 04.** Deep verification, counterarguments, change-path analysis, comparison of alternative boundaries, and readiness judgments belong there, not in the lightweight relevance filter. If Evaluation exposes an overlooked material branch or an unsound discovery assumption, return to the necessary part of this phase and update the candidate inventory; do not start an unbounded new audit.
7. **Perform a final skeptical coverage self-review before reporting.** Once Evaluation appears complete, independently challenge that conclusion: *Which significant in-scope owners, state transitions, callers, collaboration paths, or change scenarios did I never inspect? Did I follow only the first appealing issue? Did I check both missing and unnecessary boundaries? Did a vague parent conceal a worthwhile child? Are the remaining gaps capable of changing the result?* Reopen discovery or evaluation for material, answerable gaps rather than declaring the review finished. Apply this gate **even with zero findings**, and do not stop merely because the working candidate list is empty. When further work would not reasonably improve the conclusion, or access genuinely blocks it, conclude proportionately and disclose meaningful limits.

A thorough review does **not** require a prescribed number of candidates, false positives, arbitrary tree depth, infinite searching, or work outside the authorized scope. It requires a genuine search across relevant responsibilities, a second independent perspective, reasoned handling of candidate branches, and a self-checked basis for declaring the investigation sufficient.

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
