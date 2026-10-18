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

For the same **existing observable behavior**, relevant contracts, dependencies,
responsibilities, and architecture:

> Does the chosen expression make a developer understand more machinery,
> states, assumptions, or indirection than the real operation requires?

Also examine the opposite:

> Has the expression compressed away meaningful distinctions that a reader
> needs to understand the operation?

Do not assume shorter, longer, more abstract, or more idiomatic code is better.

## Required two-pass review

Complete two distinct passes within the same read-only invocation.

### Pass 1 — Identify potential friction

Read the requested code and enough context to understand the operations being
performed. Collect plausible expression-friction candidates without treating
them as established findings.

For each material candidate, record:

- the source location and intended operation;
- the expression choice that may impose unnecessary reading effort;
- the specific effort a reader may need to expend;
- an initial improvement hypothesis;
- the relevant uncertainties or potential reasons for the existing form.

Do not assign severity or confidence yet. Do not presume that an alternative
is better merely because it is more concise, conventional, or familiar.

### Pass 2 — Challenge each candidate

Re-examine every candidate independently, using the relevant source context.
Look for evidence that contradicts the initial interpretation.

For each candidate:

1. Establish what the current form contributes to behavior, meaning, or
   maintainability before treating any part as unnecessary.
2. Test the initial explanation against applicable contracts, constraints,
   dependencies, and meaningful variations in behavior.
3. Assess whether the proposed alternative actually reduces comprehension
   effort, or merely moves complexity elsewhere.
4. Apply the mandatory behavior-preservation gate below. A clearer-looking
   expression is not a valid improvement if it changes existing behavior.
5. Determine whether the concern is genuinely about implementation expression
   or belongs primarily to another review discipline.

### Mandatory behavior-preservation gate

This is a blocking condition for **every** proposed expression improvement,
not an optional caveat or a post-review implementation detail.

Compare the current code with the proposed local alternative using available
read-only evidence. Trace affected callers, state transitions, and relevant
execution paths. Account for normal, boundary, failure, and exceptional
behavior as applicable.

Preserve **what the implementation currently does**, not only what the
reviewer assumes it was intended to do. Do not silently "correct" apparently
odd behavior, remove a special case, change the timing of an operation, or
substitute a cleaner domain policy under the label of expression naturalness.

Consider all relevant observable differences, including:

- return values, externally visible state, and persistent effects;
- branch selection, evaluation order, and short-circuit behavior;
- exceptions, failure handling, retries, and recovery;
- mutation, side effects, callbacks, logging, and notifications;
- timing, scheduling, concurrency, and asynchronous behavior;
- resource ownership, lifetime, and cleanup;
- API contracts, compatibility, and behavior across supported inputs.

The gate has three outcomes:

- **Preservation supported:** Specific source evidence supports equivalence
  for the affected behavior. The candidate may proceed to the expression
  finding threshold.
- **Preservation uncertain:** A relevant behavior difference cannot be ruled
  out from the inspected evidence. Do not present the alternative as a safe
  rewrite or an actionable expression recommendation. Record the missing
  evidence or condition in the candidate review trail; investigate further
  read-only if appropriate.
- **Behavior change identified:** The alternative changes existing behavior.
  Reject that alternative. If a narrower, supported behavior-preserving
  alternative exists, reassess only that narrower proposal; otherwise reject
  or reclassify the candidate.

A correct diagnosis of reading friction does **not** validate an unsafe
improvement. A preservation checklist, a "should behave the same" statement,
or a proposed test is not evidence that the change preserves behavior.
Do not claim proof beyond the read-only evidence available.

Conclude with one disposition for each material candidate:

- **Confirmed:** the expression concern and proposed improvement are supported.
- **Narrowed:** a more specific or limited expression concern survives.
- **Rejected:** the concern does not hold up, or the alternative is not
  demonstrably preferable.
- **Reclassified:** the primary issue is outside expression naturalness.

Only confirmed and narrowed candidates **that pass the behavior-preservation
gate** may become actionable expression findings. Set impact and confidence
only after Pass 2. Reject unsupported recommendations instead of converting
every candidate into a finding.

The final response must distinguish initial candidates from validated findings.
Discarded hypotheses are normal and useful results of the review.

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

The alternative must preserve established existing behavior, including:

- current behavior and outputs, even when the intent is disputed;
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

Do not present unverified behavioral equivalence as fact. If the preservation
gate does not pass, do not recommend the change as an expression improvement.

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
5. Evidence supporting the concern beyond an unverified condition.
6. A proportionate alternative direction.
7. Specific evidence supporting preservation of existing behavior; mere
   preservation instructions or unresolved uncertainty do not pass the gate.

A subjective impression can motivate investigation but cannot alone justify
a finding. Low confidence is never a substitute for passing the behavior gate.

Do not emit cosmetic or low-confidence observations just to fill the report.

Use:

- **High confidence** when the relevant semantics and contracts are clear
  and the alternative is strongly justified.
- **Medium confidence** when friction is credible but limited contextual
  uncertainty remains without undermining supported behavior preservation.

Do not claim that a suggested modification is behavior-preserving unless
the available evidence supports that claim. Do not issue an actionable
improvement direction if a material preservation risk is still unresolved.

## Output

Start with a brief overall assessment of implementation expression.

Summarize the disposition of material Pass 1 candidates in a compact
review trail: location, initial concern, final disposition, and the reason
for that decision. State when a candidate failed the behavior gate because
preservation is uncertain or because a change was established.
Do not present rejected or reclassified candidates as actionable expression
findings.

Then report only confirmed or narrowed expression findings. If a material
concern is reclassified, it may be noted briefly and clearly as outside this
skill's scope; do not expand the review into that other discipline.

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

**Preserve:** Existing behavior, side effects, and contracts that must remain
unchanged.

**Preservation evidence:** Why the proposed alternative is supported as
behavior-preserving, including the relevant code context. Do not use a
conditional "assuming behavior is unchanged" as a substitute for evidence.

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

If neither explanation is substantiated, or if the proposed alternative fails
the behavior-preservation gate, do not report an actionable expression finding.
