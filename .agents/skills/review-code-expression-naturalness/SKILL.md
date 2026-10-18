---
name: review-code-expression-naturalness
description: >
  Independently review source code for artificial, awkward, or unnecessarily
  elaborate implementation expression. Examine how well control flow, local
  structure, language constructs, names, and comments communicate the actual
  operation to an experienced developer. Use human-coding and deslop patterns
  as investigation signals, not authorship evidence or mandatory style rules.
  Read-only review with findings exclusively in chat.
---

# Review Code Expression Naturalness

## Purpose

Review how implementation ideas are expressed in source code.

The starting observation is that functionally correct code can still feel
artificial, mechanical, or unnatural to experienced developers.

Investigate that impression instead of accepting or dismissing it.

The goal is to identify concrete cases where the source code makes a human
reader perform unnecessary mental work to recognize, understand, verify, or
continue an implementation.

Do not optimize for looking human-written, statistical authorship similarity,
minimum line count, or a universal coding style.

Optimize for correspondence between the meaning of an operation and the form
in which the implementation communicates it.

## Operating contract

This is an independently invoked, read-only review skill.

- Inspect relevant source code and static context only.
- Do not create, modify, remove, rename, or format files.
- Do not execute builds, tests, linters, formatters, generators, migrations,
  application code, or other potentially state-changing commands.
- Do not alter Git or repository state.
- Return findings exclusively in chat.
- Do not implement suggested improvements.
- Do not require a minimum number of findings.

Code authorship is irrelevant. Findings must be equally valid for code
written by an experienced person, a coding agent, or both.

## Central question

For the same intended behavior, relevant contracts, dependencies,
responsibilities, and architecture:

> Does the chosen expression make a developer understand more machinery,
> states, assumptions, or indirection than the real operation requires?

Also examine the opposite:

> Has the expression compressed away meaningful distinctions that a reader
> needs to understand the operation?

Do not assume shorter, longer, more abstract, or more idiomatic code is better.

## Required two-pass review

Run both passes in order within the same read-only invocation.

**Pass 1 creates candidates, not findings. Pass 2 tries to disprove them.**
Do not attach impact or confidence ratings, or commit to an improvement, during
Pass 1. A plausible first impression is a hypothesis until challenged.

### Pass 1 — Map the operation and list candidates

Survey the requested code area and the immediate context needed to recognize
each operation. Recover the mental plan before evaluating expression.

Build a provisional candidate list. For each material candidate record:

- source location and operation;
- exact expression choice that looks awkward;
- specific mental work it appears to impose;
- the smallest plausible alternative or question to investigate;
- a plausible reason the current expression might be intentional;
- missing evidence needed before treating it as a finding.

Include both overexpression and overcompression candidates. Avoid padding the
list with cosmetic preferences. Similar-looking code is a clue to inspect,
not evidence that its behavior or purpose is the same.

**Do not publish this list as an unqualified review verdict.** Preserve it
for the second pass; the final report will show each material candidate's
disposition.

### Pass 2 — Adversarially review every candidate

Individually challenge each candidate using relevant read-only source context:
callers, callees, types, contracts, adjacent branches, supported variants, and
existing tests when helpful. Reading tests is permitted; running them is not.

Start with the strongest defense of the existing implementation. Ask what
meaning the first pass might have missed and whether the proposed alternative
would actually reduce human reading work without introducing new machinery.

For apparently duplicated implementations, compare **the whole operations**,
not just their shared syntax:

- inputs, candidate counts and ordering;
- eligibility and selection policies;
- early returns and short-circuit behavior;
- fallback behavior and empty-result semantics;
- side effects, resource and lifecycle constraints;
- performance expectations, scheduling and state transitions.

A common loop or formula does not justify extraction when the surrounding
algorithms differ. A configurable shared helper can create more conceptual
cost than the duplication it replaces.

For awkwardly named or reused state, trace **when it is written and read**,
including iteration order and the consequences for observable behavior.
If the issue turns out to be a correctness or domain-rule defect, do not
present a behavior-changing fix as an expression-only improvement.

Attempt to invalidate the candidate's causal story and proposed alternative.
For each candidate choose one disposition:

- **Confirmed:** clear expression friction, with a defensible local alternative.
- **Narrowed:** only a smaller or different expression issue survives; update
  the location, explanation, and suggested scope accordingly.
- **Rejected:** the current structure serves genuine semantics, or the
  alternative is not demonstrably better.
- **Reclassified:** the primary problem is correctness, architecture, domain
  policy or another concern outside this skill.

Only confirmed and narrowed candidates can become expression findings.
Assign impact and confidence **after** this pass, not before it. Suppress a
candidate if key contracts or behavior-preservation conditions remain too
uncertain to support a useful finding.

A rejection is a successful review result, not a reason to invent a weaker
finding. A consequential reclassified concern may be briefly noted as
out of scope with its uncertainty, but must not be disguised as an expression
finding or expanded into a separate audit.

## Detailed inspection guidance

Apply the following analysis to Pass 1 hypotheses and use its counterfactual
and challenge checks in Pass 2.

### 1. Recover the mental plan

Before judging a code region, establish what it actually accomplishes.

Describe the operation internally in one or two sentences using meaningful
actions or domain concepts rather than merely narrating syntax.

For example:

"Select the first usable candidate and return the fallback if none qualifies."

Do not start with:

"This method uses a loop, three conditionals, and a temporary variable."

Identify the genuine:

- inputs and outputs;
- decisions and reachable states;
- transformations;
- side effects;
- ordering requirements;
- error and failure contracts;
- relevant invariants;
- lifecycle boundaries.

Read surrounding types, callers, callees, and documented contracts where
needed. Do not invent guarantees missing from the available evidence.

### 2. Compare source expression with the mental plan

Trace how directly the implementation communicates the operation.

Look for places where a reader must:

- reconstruct a simple concept from multiple mechanical steps;
- follow trivial helpers to recover one coherent operation;
- track temporary states that have no independent semantic role;
- consider failure cases excluded by an established contract;
- infer the meaning of a name that describes mechanics instead of purpose;
- filter comments that add no information;
- mentally reverse a complicated control mechanism to recognize the actual
  decision;
- unpack overly compressed code to discover distinct meaningful steps.

Pay special attention to semantic beacons: names, operations, invariants,
and structure that let an experienced reader recognize the purpose of a
code region without reading it as an arbitrary sequence of statements.

An unfamiliar construct is not automatically friction.

### 3. Investigate artificial-looking patterns

Human-mimicking, humanization, and deslop observations can suggest where to
look. They are not proof of bad code or AI authorship.

Investigate:

#### Defensive state inflation

Check whether guards, type checks, null checks, fallback values, exception
handling, or compatibility branches model states excluded by the actual
contract.

Distinguish established internal guarantees from genuine uncertainty at
external, plugin, network, persistence, security, or concurrency boundaries.

Never recommend removing protection merely because it looks verbose.

#### Mechanical expansion

Look for language-level or conceptual operations recreated through
unnecessary temporary values, mutation, branching, forwarding, or manual
implementation of guaranteed API semantics.

A direct expression is preferable only when its semantics and comprehension
benefit are established.

#### Ceremonial decomposition

Check whether helpers, wrappers, callbacks, or local abstraction layers give
the reader a meaningful concept, ownership boundary, test seam, or reusable
operation.

A helper is not unnecessary merely because it is short or used once.

A helper becomes a friction candidate when navigating into it provides
little information that the caller could not communicate directly.

#### Indirect control flow

Inspect flags, nested branches, dispatch machinery, state transitions, and
compensating logic that obscure the actual decisions.

Some algorithms genuinely require indirect or resumable control flow.

Identify the actual semantic purpose before suggesting a more direct form.

#### Information-poor explanation

Check whether comments, names, and intermediate steps communicate new
information.

Value comments that preserve rationale, constraints, non-obvious behavior,
historical reasons, or important invariants.

Question comments that only translate immediately visible syntax into prose.

Do not impose comment-count or identifier-length preferences.

#### Language-expression mismatch

Check whether code manually recreates a familiar and appropriate construct
already provided by its target language or framework.

An idiom is useful when it exposes the operation more directly.

Do not recommend advanced or obscure idioms merely to demonstrate expertise.

#### Excessive compression

Look for expressions that combine several meaningful decisions or side
effects into forms that require unnecessary decoding.

A well-named intermediate value or clear helper can improve naturalness even
if it adds lines.

#### Weak semantic binding

Consider whether apparently precise code expresses the actual relationship
between values, entities, conditions, or invariants.

Do not confuse superficial thoroughness with semantic clarity.

If the primary issue is a functional defect rather than an expression
problem, characterize it accurately instead of disguising a correctness
finding as a style finding.

### 4. Evaluate information gain

For each suspicious construct, ask:

"What meaningful information or required behavior would disappear if this
element were expressed differently?"

Useful contributions include:

- a distinct domain concept;
- a reachable state or meaningful decision;
- an API or compatibility requirement;
- a real recovery path;
- a resource or lifecycle boundary;
- a meaningful ordering or concurrency constraint;
- a semantic name for otherwise difficult logic;
- important information not recoverable from the code itself.

If the element appears to carry no such contribution, investigate whether
it imposes unnecessary reading or navigation cost.

Do not mistake unfamiliarity for lack of information.

### 5. Construct a local alternative

Before accepting a finding, formulate a reasonably concrete alternative.

The alternative must aim to preserve:

- intended behavior and outputs;
- relevant public and internal contracts;
- side effects and error semantics;
- evaluation and mutation order;
- resource lifetime;
- asynchronous and concurrency behavior;
- supported compatibility;
- architecture and responsibility boundaries.

It does not need to be a complete patch.

If the proposed improvement requires a new system architecture, a substantial
cross-module refactor, or a change in intended behavior, it is probably not
primarily an expression-naturalness finding.

Do not exclude a genuine local-expression concern simply because it appears
inside a structurally complicated system.

### 6. Challenge the finding

Before reporting, ask:

- Could the apparent redundancy encode a real invariant or recovery path?
- Is an intermediate value a meaningful snapshot?
- Does a helper define lifecycle, reuse, ownership, or a useful conceptual
  boundary?
- Would the direct form change lazy evaluation, exception propagation,
  short-circuit behavior, logging, or mutation?
- Does the verbose form expose meaningful detail that the shorter form hides?
- Would the concern remain even if the entire repository used this pattern?
- Would it still be a concern if the code were known to be written by an
  experienced human developer?
- Is the alternative genuinely easier to understand, or merely more familiar
  to the reviewer?

When relevant evidence is incomplete, express the uncertainty.

Do not present unverified behavioral equivalence as fact.

## Scope

Primary targets:

- expression friction;
- local implementation friction that directly changes how the operation is
  understood.

Possible incidental observations:

- contextual or architectural problems when necessary to explain a local
  expression problem.

Not standalone targets:

- general architecture or system design;
- broad maintainability and future-change cost;
- unrelated correctness, security, or performance audits;
- repository conformity;
- formatting and cosmetic normalization;
- AI detection or authorship disguise;
- arbitrary preferences for programming paradigms.

Do not force every concern into the primary categories. Preserve accurate
classification even when the discovered issue is useful but out of scope.

## Findings threshold

Report a material finding only when it has:

1. An identifiable source location or narrowly defined repeated pattern.
2. A recognizable intended operation or mental plan.
3. A concrete representation choice causing friction.
4. A specific unnecessary mental task imposed on a reader.
5. Evidence or a clearly stated condition supporting the concern.
6. A proportionate alternative direction.
7. Identified preservation constraints or uncertainty.

A subjective impression can motivate investigation but cannot alone justify
a finding.

Do not emit cosmetic or low-confidence observations just to fill the report.

Use:

- **High confidence** when the relevant semantics and contracts are clear
  and the alternative is strongly justified.
- **Medium confidence** when friction is credible but a meaningful
  interpretation or preservation condition remains uncertain.

Do not claim that a suggested modification is behavior-preserving unless
the available evidence supports that claim.

## Output

Start with a brief overall assessment of implementation expression.

Give a compact **candidate disposition** summary showing the material
candidates from Pass 1 and how Pass 2 resolved them. For each, include
its location, the original suspicion, the final disposition (Confirmed,
Narrowed, Rejected, or Reclassified), and the decisive reason. This is an audit trail, not a second set of findings;
do not list every trivial or cosmetic suspicion.

Then detail **only** confirmed or narrowed expression findings in the
existing format. Do not silently carry forward a rejected recommendation.
A candidate rejected after inspecting meaningful semantic differences should
remain visibly rejected in the disposition summary.

If a reclassified concern reveals a material possible correctness or
domain-policy issue, optionally add a short, clearly separate
**Out-of-scope observation** describing the evidence and uncertainty.
Do not prescribe an unverified behavior change.

For each material finding, provide:

### [Impact] `path:line-range` — Title

**Category:** Expression friction or local implementation friction.

**Operation:** What the code is actually trying to accomplish.

**Observed expression:** The specific construct creating the concern.

**Human friction:** What the reader must unnecessarily track, reconstruct,
navigate, interpret, or mentally exclude.

**Reasoning:** Why this is more than a personal preference, including
evidence from applicable semantics, contracts, or local behavior.

**Improvement direction:** A concrete, proportionate alternative without
implementing it.

**Preserve:** Important behavior, side effects, contracts, and uncertainty.

**Confidence:** High or medium.

Order findings by expected significance for human understanding, not by
similarity to AI-generated code.

Group related instances sharing one underlying cause.

Do not pad the report with generic praise or speculative style complaints.
The disposition summary is part of the completed review, not permission to
publish low-confidence candidates as actionable findings.

If there are no material findings, state:

`Expression-naturalness review complete. Material findings: 0.`

## Final standard

A finding should be explainable without mentioning AI.

The reviewer should be able to say:

"This code asks the reader to reconstruct or consider X, although the actual
operation only requires Y. A more appropriate expression would preserve the
relevant behavior while eliminating that unnecessary work."

Or:

"This expression hides the meaningful distinction X. Making X explicit
would help a reader understand the real operation without changing its
architecture."

If neither explanation is substantiated, reject or reclassify the Pass 1
candidate instead of reporting it as an expression finding.
