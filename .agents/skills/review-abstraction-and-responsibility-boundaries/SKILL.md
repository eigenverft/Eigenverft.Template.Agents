---
name: review-abstraction-and-responsibility-boundaries
description: Use for a read-only review when the user requests an assessment of abstraction boundaries and responsibility separation in existing code, especially whether coherent behavior, state, and rules are effectively encapsulated and ordinary changes remain local. Examine practical opportunities for focused subobjects, modules, or systems without prescribing interfaces, classes, or patterns. Report source-grounded recommendations without modifying files or executing project code.
---

# Review Abstraction and Responsibility Boundaries

Examine whether related behavior, state, and rules form an identifiable
area of responsibility and are effectively encapsulated.

Use this practical criterion:

> Can an ordinary change to this behavior be made mostly within the
> responsible area, without unnecessarily having to understand or modify
> other responsibilities?

Look both for missing boundaries and for boundaries that unnecessarily
scatter a coherent responsibility across separate units.

## Activation and Working Mode

Use this skill when explicitly invoked or when a review of abstraction
boundaries, responsibility separation, or encapsulation is explicitly
requested.

A general implementation, bugfix, or review request does not automatically
activate this specialized review.

Work exclusively by reading and reporting:

- Read existing source code and relevant contracts.
- Read tests, documentation, and change history as evidence when needed.
- Do not modify files or produce patches.
- Do not execute project code, builds, tests, or generators.
- Do not implement any proposed alternative.

Keep the investigation aligned with the request. Follow dependencies only
as far as necessary to make a well-supported assessment of the
responsibility under review.

## Focus

Examine domain and technical sub-responsibilities within existing software,
particularly:

- related behavior and its state,
- rules and valid state changes,
- subobjects, components, modules, and systems,
- algorithm and behavior boundaries,
- collaboration between distinct responsibilities,
- multiple levels of abstraction and composition.

Assess technical mechanisms by the responsibilities they actually delimit.

A class, interface, file, or decomposition into methods does not, by itself,
create an effective responsibility boundary.

This is not a general review of style, defects, performance, or overall
architecture. Consider those aspects when they materially affect the
boundary under review or a proposed alternative.

## Guiding Principles

### Name the Specific Responsibility

A responsibility covers a clearly describable task and the decisions or
rules that govern it.

For example, identify:

- which outcomes an area determines,
- which state it manages,
- which valid transitions it safeguards,
- which mechanism it encapsulates,
- which collaboration it coordinates.

Labels such as "processes data" or "contains business logic" are not enough
to justify a new boundary.

A processing step is not automatically a separate responsibility.
Conversely, several methods may together implement a sub-responsibility
whose state and rules are currently mixed with other tasks.

### Assess Encapsulation by Its Effect

An effective boundary lets its consumers use a capability without
repeatedly reconstructing how it works internally.

Therefore, ask:

- What does this area handle on its own?
- Which operations does it provide for that purpose?
- Which state is it allowed to change?
- Which internal rules must other areas still know?
- Can other areas bypass its intended operations?

Private fields alone do not guarantee this effect.
Shared storage does not rule it out.

### Choose a Form That Fits the Problem

A suitable boundary may be provided by an object, subobject, function,
module, system, or another appropriate mechanism.

A dedicated object can bring together the state and rules of a
sub-responsibility. A system can fulfill the same responsibility over a
shared data set.

An interface can express a useful contract. It is neither a prerequisite
for nor proof of effective encapsulation.

## Procedure

### 1. Reconstruct the Actual Responsibilities

Read the relevant implementation and the context needed to understand its
use.

Determine:

- which distinct tasks and decisions are present,
- which state belongs to each,
- which rules govern valid changes,
- who actually reads and modifies that state,
- how the responsibilities collaborate.

Base the assessment on actual behavior and access paths. Names, file
boundaries, and comments are clues, not conclusive evidence.

Consider construction, lifetime, and cleanup where they affect the
responsibility boundaries.

### 2. Look for Coherent Sub-Responsibilities

Look for areas where behavior, state, and rules clearly belong together
but are currently scattered among other tasks.

In particular, ask:

- Does one unit mix several tasks that can be understood independently?
- Do certain methods operate on a coherent group of state?
- Must other areas manipulate that state according to its internal rules?
- Must an ordinary change to one task cut across other tasks?
- Could a dedicated area of responsibility offer meaningful operations
  and take ownership of its internal decisions?

Such an opportunity can be relevant even without a previous bug, a
documented history of changes, or a second implementation.

Ground its benefit in the code you have read. The mere possibility of
moving code into a new class is not enough.

### 3. Check Whether Existing Boundaries Are Effective

For extracted units, ask:

- Do they actually own their task?
- Or do they still freely manipulate the internals of their former owner?
- Do they receive just the information and capabilities they need?
- Must their consumers know internal states or call sequences?
- Do they hide a distinct decision, or mainly relocate code and add
  navigation between units?

Also trace indirect access through mutable collections, back-references,
contexts, global access, callbacks, and events when relevant to the
boundary.

A broad reference is a signal to investigate. What matters is how it is
actually used and which dependencies it creates.

Distinguish syntactic nesting, runtime composition, and domain
sub-responsibilities. None of these forms automatically establishes the
others.

### 4. Check the Boundary Against a Suitable Change Scenario

Examine boundaries of interest through an ordinary, plausible change to
the behavior concerned.

Use existing requirements, variants, or known changes. An explicitly
hypothetical scenario is also acceptable. Do not turn it into an invented
product roadmap.

Trace:

- Which decision would change?
- Which areas would need to be understood?
- Which areas would actually need to be modified?
- Why would each area be affected?

Distinguish necessary collaboration from avoidable entanglement.

A requirement may legitimately change several responsibilities. The
problem arises when an area unnecessarily needs to understand another
area's implementation details or re-derive a rule owned elsewhere.

Do not use the number of affected files as a quality measure.

### 5. Describe a Specific Alternative Boundary

When recommending a separation, explain:

- which task the new area would take over,
- which state and rules belong to it,
- which operations its consumers need,
- which internal decisions would become hidden,
- which ordinary changes would become more local.

Also consider whether related rules should return to their existing
owner or whether existing units should be combined.

Compare the proposed boundary with the current organization and, where
credible, a less extensive alternative that could address the same task.
Explain the concrete advantage that justifies the proposed extent. A brief
qualitative comparison is usually enough; do not require a fixed number
of alternatives or several complete designs.

Choose a responsibility-complete boundary. A larger coherent owner may
be justified where a helper would leave related state and rules scattered;
the smallest code edit is not automatically the best boundary.

Choose the appropriate technical form only after that analysis.

"Extract a service" or "add an interface" is not a sufficient
recommendation.

An additional variation mechanism needs a concrete benefit. Different
values can be expressed as data; different rules may justify a separate
behavior boundary.

### 6. Evaluate the Alternative in Practice

Assess the relevant overall effect:

- Does it actually remove the need to know another area's internals?
- Does ownership of state changes become clearer?
- Does necessary collaboration remain understandable?
- Does it add forwarding layers or hidden dependencies?
- Does initialization or lifetime management become harder?
- Do previously protected rules move out to callers?
- Are required consistency guarantees and joint operations preserved?
- Are relevant runtime and memory constraints accounted for?

Challenge the proposed boundary against a relevant contrasting case in
the existing source: a workflow or variant that could make the separation
less suitable. Depending on the code, this might involve cancellation,
resumption, a shared state change, or a different behavior variant. These
are examples, not a checklist to apply to every proposal.

Trace the operations and access paths that case would need. Check whether
necessary collaboration remains clear, protected rules stay with their
owner, and the new unit avoids needing its former owner's full internals.
Begin with one proportionate case and investigate further when it reveals
a material concern. This is a source-based design check, not a demand for
implementation, exhaustive proof, or runtime execution.

Do not demand a complete architectural redesign. Recommend a proportionate
set of boundaries that adequately addresses the concrete problem.

## Rules Against Misjudgment

Do not produce a finding solely because of:

- large classes or long methods,
- many or few files,
- missing interfaces or patterns,
- only one production implementation,
- shared data or multiple writers,
- central coordination,
- nested types,
- a conditional branch,
- several areas being affected by one change.

Consider both directions:

- Methods may already organize a coherent task appropriately.
- A distinct sub-responsibility may still need more effective
  encapsulation despite a clear method structure.
- A new class may preserve the same entanglement.
- Several small units may unnecessarily scatter a single rule.
- A thin adapter may protect a real contract boundary.
- Central coordination may own a necessary overall responsibility.

Do not force either additional abstraction or maximum directness.

## Evidence and Recommendations

Ground observations in specific symbols, access paths, and contracts.

Distinguish:

- the observed structure,
- the resulting change or comprehension problem,
- the proposed improvement.

A useful recommendation does not require a demonstrated runtime defect.
It requires an identifiable responsibility, a concrete practical drawback,
and a sufficiently supported improvement direction. A correct observation
does not by itself establish that the proposed new boundary is better.

Before presenting a proposal as a selectable implementation recommendation,
establish both the problem and the proposed remedy:

- **Problem:** Show which decision, rule, or state responsibility is
  unnecessarily mixed, exposed, or scattered. Several lifecycle stages
  handling the same operation is not enough; explain which knowledge or
  authority is unnecessarily shared between them.
- **Target:** Identify the proposed owner, its rules, relevant state, and
  consumer operations. A stateless boundary is valid when appropriate.
  Do not leave the central ownership decision to a later investigation.
- **Improvement:** Trace a concrete ordinary change before and after the
  proposed boundary. Explain which external knowledge or coordinated
  edits disappear and why. Moving code or adding a shared contract alone
  does not establish this benefit.
- **Preservation:** Challenge the remedy against the actual differences
  between the responsibilities and their required collaboration. Show why
  it preserves relevant behavior, consistency, and meaningful distinctions
  instead of merely giving distinct responsibilities a shared name or
  moving their coordination burden elsewhere.

Use the source already inspected and obtain targeted missing context when
necessary. This is a design justification, not a demand for implementation,
runtime proof, or a full refactoring plan. If an essential part remains
unresolved, report the observation and uncertainty separately rather than
promoting the proposal into the main table. A plausible concern may be
worth investigating without being ready to recommend for implementation.

Assess the observed problem separately from the supported extent of its
remedy. If a wider proposal is only partly supported, retain a useful,
responsibility-complete core as the implementation recommendation and
present the uncertain extension as a linked open candidate. Do this only
when the core offers a worthwhile improvement on its own; do not invent
a tiny extraction merely to keep an implementation item in the report.

Localize uncertainty: name the particular assumption or decision that
remains open and explain which part of the proposal it affects. An open
extension does not invalidate a supported core, and a supported core does
not establish that its extension is worthwhile.

Retain interesting opportunities that are not yet sufficiently understood
as explicitly conditional observations. Identify the missing context that
would materially change their assessment.

Do not demand mathematical completeness of proof, and do not present
hypotheses as confirmed defects.

## Output

Write in the user's language. Begin with a brief statement of the scope
examined. Present qualifying implementation recommendations in their
overview table with matching explanations. Give worthwhile open candidates
their own clearly labeled overview and explanations as described below.
Omit either section when it has no entries.

The implementation table supports quick comparison and selection. Its
explanations give the evidence and reasoning needed to accept, defer, or
reject a proposal. Include only recommendations that meet the
problem-and-remedy requirements in "Evidence and Recommendations". An
appealing description or a severity label cannot substitute for a
supported target boundary.

### Implementation Recommendations — Overview Table

Use these columns, translating their labels naturally when appropriate:

| Ref | Severity | Responsibility and proposed change | Assessment | Brief rationale |
| --- | --- | --- | --- | --- |
| A | High | <specific responsibility or subobject>: <concrete proposed change> | <expected benefit; estimated effort> | <why this change is worthwhile> |

The responsibility-and-change column must be understandable on its own.
Name the domain responsibility, technical part, or subobject concerned
and describe what should change about it. A reader must be able to tell
what a proposal concerns before opening its explanation.

For example, illustrative wording is:
"Document revision history: Encapsulate revision state and transition
rules in a dedicated component."

Avoid generic titles such as "improve encapsulation", "separate
responsibilities", or "extract a service". A file or class name alone
does not explain the proposal. Identifiers may supplement the plain
description when useful.

Keep cells short, usually a phrase or a short sentence. Roughly five to
ten words may suit the assessment and rationale cells, but do not enforce
a word limit or shorten the responsibility description until it becomes
ambiguous. Put detailed evidence and explanations below the table.

Use the assessment column for qualitative expected benefit and estimated
effort. State when effort is unknown; do not invent precise estimates.
Use the rationale column for the concrete reason behind the assessment,
rather than repeating the proposal or its severity.

### Severity and Ordering

Use exactly these severity labels:

- **Critical:** A severe problem with immediate, grave consequences.
- **High:** Substantial impact on safe changes or important workflows.
- **Medium:** A concrete, relevant burden within a bounded area.
- **Low:** A small but demonstrable practical drawback.

Severity describes the weight of the observed problem, not implementation
effort or a mandatory implementation order. Do not equate a large proposed
change with high severity, and do not require a runtime defect to justify
a substantial changeability concern. Severity does not establish confidence
in the proposed remedy; a serious concern can still have an unresolved
solution that belongs outside the implementation-recommendation table.

Order the table by severity, with the most consequential findings first.
Use expected benefit and estimated effort to order findings of similar
severity. If dependencies or a better benefit-to-effort balance suggest
starting elsewhere, state that implementation recommendation separately
and briefly explain it. Keep finding references stable when reordering.
Do not produce findings to populate every severity level.

### Finding References

Assign simple references such as A, B, and C. Use each reference in its
table row and in a corresponding heading such as "A) <specific title>".

Use one reference sequence across recommendations and open candidates.
Each reference must identify one coherent, independently discussable
recommendation or candidate. Group symptoms with the same cause and
improvement direction; keep independently selectable changes separate.

Keep assigned references stable when updating the same report. Do not
renumber remaining findings after a subset is selected or completed, and
do not reuse a reference for an unrelated finding. Give new findings new
references.

Keep a reference when its entry moves between open candidates and
implementation recommendations. Its current section determines its status;
the reference preserves its identity.

This should let the user select findings by reference, for example
"implement D, E, and G", without requiring the report to be reconstructed.
If a proposal depends on another finding, state that dependency briefly
in its table row and explain it below. Identify mutually exclusive
alternatives so they cannot be mistaken for independent work items.

### Explanation for Each Implementation Recommendation

Under the matching reference heading, use concise paragraphs or bullets
covering these four aspects:

- **Finding and evidence:** Describe the specific mixing of
  responsibilities or ineffective boundary. Link the relevant source
  locations and symbols, and explain the practical effect on comprehension
  or ordinary changes.
- **Proposed change:** Contrast the current and proposed boundaries.
  Identify the responsibility concerned, its state and rules, and the
  operations its consumers would use. Explain what would become more
  local and which collaboration would remain necessary. Briefly explain
  why the proposed extent is preferable to retaining the current structure
  or using a credible less extensive alternative.
- **Reason for the assessment:** Justify the severity, expected benefit,
  and effort estimate or its uncertainty. Give enough reasoning for the
  user to form their own judgment.
- **Trade-offs and first step:** State material costs, constraints,
  preservation requirements, dependencies, and a bounded first step for
  implementation with relevant verification. Include the meaningful result
  of the contrasting-case check and any effect on the recommendation's
  extent. Do not use "investigate later" to defer establishing the central
  responsibility or feasibility of the proposed boundary. Do not turn
  every finding into a full implementation plan or invent a minimum
  number of tasks.

Add explanatory value rather than expanding the table row word for word.
Keep detail proportionate to the finding and avoid empty mandatory fields.

### Open Candidates — Clarification Needed

Present conditional opportunities and insufficiently justified remedies
separately from implementation recommendations. State what is observed,
what remains uncertain, and which missing evidence or design decision
would materially change the assessment. A supported problem may remain
supported even when its remedy is unresolved; do not hide the problem or
present an unsettled solution as ready to implement.

Keep these entries outside the implementation table. Use a compact second
table, translating the labels naturally:

| Ref | Responsibility and observation | What is supported | What remains open | Next clarification |
| --- | --- | --- | --- | --- |

State whether the supported basis is an observed structure, an established
practical problem, or a conditional opportunity. Where a problem's impact
is already supported, retain that assessment in the explanation even when
the remedy is unsettled. Do not assign confirmed impact to a hypothesis.

Under matching reference headings, provide the relevant source evidence
and explain the missing context or design decision that could change the
assessment. A focused investigation step is appropriate here. Selecting
an open reference identifies a subject for clarification, not a supported
implementation recommendation.

Link an open extension to its supported core when relevant. Explain the
additional unresolved scope without duplicating the same concern as a
second finding. Preserve useful candidates without filling the section
with every conceivable redesign. Do not turn a hypothesis into a confirmed
defect.

### Other Outcomes

Mention notable existing boundaries only when they help explain the
assessment or prevent a misleading recommendation. Do not produce an
exhaustive catalog of correct locations.

If no supported recommendation qualifies, omit the empty implementation
table and its finding sections. Briefly state that no supported
boundary-change recommendation was established within the examined scope.
Useful open candidates may still follow in their separate section;
distinguish this outcome from a review with neither recommendations nor
useful candidates.

When missing context prevents an assessment, state that limitation
explicitly. Do not confuse insufficient evidence with a completed review
that found no relevant improvement.

There is no finding quota and no architecture score.
