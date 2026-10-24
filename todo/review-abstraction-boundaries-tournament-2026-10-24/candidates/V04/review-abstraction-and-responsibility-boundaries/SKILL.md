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

### Assess Boundaries by Practical Effect

An effective boundary gives a coherent responsibility meaningful operations
and an understandable place for its behavior, state, and rules. Examine
actual ownership and access, including boundaries within the same class
or module. Neither private fields nor shared storage settle the assessment.

Use this skill's review approach to investigate the practical drawback and
the proposed improvement. A new type or a shared workflow name alone is
not evidence of improvement. A stateless rule may also have a useful owner.

### Choose a Form That Fits the Problem

A suitable boundary may be provided by an object, subobject, function,
module, system, or another appropriate mechanism.

A dedicated object can bring together the state and rules of a
sub-responsibility. A system can fulfill the same responsibility over a
shared data set.

An interface can express a useful contract. It is neither a prerequisite
for nor proof of effective encapsulation.

## Review Approach

Start from one ordinary behavioral change to a candidate responsibility.
Trace the decisions and edits it actually requires in the current source,
rather than assuming every participant in the larger workflow must change.
Identify which work belongs to that responsibility and which follow-up
work arises from another area knowing its implementation details.

Describe a realistic alternative boundary and retrace the same change.
Explain which understanding or edits become local and which joint work
remains necessary. The alternative may consolidate a rule, introduce a
subobject or system, or restore ownership to an existing area.

A short qualitative comparison suffices. Do not use file counts, invented
change frequencies, or a speculative future variant as proof. Missing
implementation detail does not invalidate a grounded improvement direction.

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

### 4. Apply the Review Approach to an Ordinary Change

Use this skill's review approach to examine a plausible ordinary change to
the selected behavior. Existing requirements, variants, and known changes
are useful evidence. An explicitly hypothetical change is also acceptable;
do not invent a product roadmap.

Assess the current organization and the proposed direction through that
change. Explain the practical difference in understanding or modification
work, and preserve collaboration that the requirement actually needs.
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

Check plausible counterarguments before settling on a recommendation.
Use a relevant existing workflow or variant to challenge the proposed
boundary when it could expose a material weakness. Consider a credible
less extensive alternative when it could solve the same problem. Use
these checks to refine the direction and expose limits; do not require
an exhaustive design comparison or a fully worked-out refactoring.

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

Before presenting a recommendation, use the review approach to establish:

- the particular responsibility and observed practical drawback,
- a sufficiently grounded improvement direction and its benefit,
- the behavior, state, rules, and useful operations concerned,
- material collaborations, constraints, and remaining design questions.

Use specific source evidence and proportionate reasoning. Final API
signatures, a complete transition design, and runtime proof are not
required. Assess whether the direction is useful before describing how
far its implementation scope has been worked out. Maturity does not
compensate for an unsupported direction.

Separate a supported direction from a settled implementation scope:

- **Direction supported; scope needs design:** The responsibility,
  practical drawback, and benefit of the direction are grounded in source.
  Specific transitions, collaboration details, or the exact extent still
  need design. Include this recommendation in the main table, identify
  those details, and explain how they could constrain the implementation.
- **Scope supported:** The proposed extent and material collaborations
  are sufficiently examined to recommend a bounded implementation step.
  This still does not promise a complete or verified implementation plan.
- If the missing evidence could overturn whether the proposed separation
  is useful at all, or the central responsibility is unclear, keep the
  candidate outside the main table and explain the unresolved question.

Do not discard a valuable direction merely because its full implementation
has not been designed. Conversely, a plausible problem does not justify
a broad proposed owner. Narrow or qualify an overextended recommendation
without pretending that the entire design is settled. Do not manufacture
a trivial extraction just to retain a finding.

Use inspected source and targeted missing context proportionately. Before
calling something an open product decision, check relevant existing
contracts and distinguish an unanswered question from conflicting evidence.
This is a design review, not a demand for runtime proof or implementation.

Retain interesting opportunities that are not yet sufficiently understood
as explicitly conditional observations. Identify the missing context that
would materially change their assessment.

Do not demand mathematical completeness of proof, and do not present
hypotheses as confirmed defects.

## Output

Write in the user's language. Begin with a brief statement of the scope
examined, then provide a compact overview table followed by explanations
using the same finding references.

The table supports quick comparison and selection. The explanations give
the evidence and reasoning needed to accept, defer, or reject a proposal.
Include supported directions and bounded implementation recommendations
that meet the evidence requirements in "Evidence and Recommendations". An appealing description
or a severity label cannot substitute for a supported target boundary.

### Overview Table

Use these columns, translating their labels naturally when appropriate:

| Ref | Severity | Responsibility and proposed change | Maturity | Assessment | Brief rationale |
| --- | --- | --- | --- | --- | --- |
| A | High | <specific responsibility or subobject>: <concrete proposed change> | <direction supported; scope needs design OR scope supported> | <expected benefit; estimated effort> | <why this change is worthwhile> |

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

Use the maturity column to distinguish "Direction supported; scope needs
design" from "Scope supported", translated naturally. Make the first
step match that status: bounded design work for the former, a justified
implementation step for the latter. Neither severity nor maturity is an
automatic instruction to implement. A reference selects the recommendation
at its stated maturity, not permission to assume away open design details.

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
in the proposed remedy. A supported direction may have unresolved design
details; an unsubstantiated direction belongs outside the main table.

Order the table by severity, with the most consequential findings first.
Use expected benefit and estimated effort to order findings of similar
severity. If dependencies or a better benefit-to-effort balance suggest
starting elsewhere, state that implementation recommendation separately
and briefly explain it. Keep finding references stable when reordering.
Do not produce findings to populate every severity level.

### Finding References

Assign simple references such as A, B, and C. Use each reference in its
table row and in a corresponding heading such as "A) <specific title>".

Each reference must identify one coherent, independently discussable
proposal. Group symptoms with the same cause and improvement direction;
keep independently selectable changes separate.

Keep assigned references stable when updating the same report. Do not
renumber remaining findings after a subset is selected or completed, and
do not reuse a reference for an unrelated finding. Give new findings new
references.

This should let the user select findings by reference, for example
"implement D, E, and G", without requiring the report to be reconstructed.
If a proposal depends on another finding, state that dependency briefly
in its table row and explain it below. Identify mutually exclusive
alternatives so they cannot be mistaken for independent work items.

### Explanation for Each Finding

Under the matching reference heading, use concise paragraphs or bullets
covering these four aspects:

- **Finding and evidence:** Describe the specific mixing of
  responsibilities or ineffective boundary. Link the relevant source
  locations and symbols, and explain the practical effect on comprehension
  or ordinary changes.
- **Proposed change:** Contrast the current and proposed boundaries.
  Identify the responsibility concerned, its state and rules, and the
  operations its consumers would use. Explain what would become more
  local and which collaboration would remain necessary.
- **Reason for the assessment:** Justify the severity, expected benefit,
  and effort estimate or its uncertainty. Give enough reasoning for the
  user to form their own judgment.
- **Trade-offs and first step:** State material costs, constraints,
  preservation requirements, dependencies, and a bounded first step
  appropriate to the stated maturity, with relevant
  verification. For a supported direction, identify the specific design
  questions and their effect on scope. Do not use "investigate later" to
  conceal uncertainty about the central responsibility or the benefit itself.
  Do not turn every finding into a full implementation
  plan or invent a minimum number of tasks.

Add explanatory value rather than expanding the table row word for word.
Keep detail proportionate to the finding and avoid empty mandatory fields.

### Unresolved Recommendations and Other Outcomes

Present conditional opportunities whose problem or improvement direction
is not yet sufficiently justified separately from supported recommendations.
State what is observed,
what remains uncertain, and which missing evidence or design decision
would materially change the assessment. A supported problem may remain
supported even when its remedy is unresolved; do not hide the problem or
present an unsettled solution as ready to implement.

Keep these entries outside the main severity-rated table. A focused
investigation step is appropriate here, clearly distinguished from an
implementation recommendation. Do not turn a hypothesis into a confirmed
defect.

Mention notable existing boundaries only when they help explain the
assessment or prevent a misleading recommendation. Do not produce an
exhaustive catalog of correct locations.

If no supported recommendation qualifies, omit the empty table and finding
sections. Briefly state that no supported boundary-change recommendation
was established within the examined scope. Relevant unresolved observations
or conditional opportunities may still follow in their separate section;
distinguish this outcome from a review with neither findings nor useful
opportunities.

When missing context prevents an assessment, state that limitation
explicitly. Do not confuse insufficient evidence with a completed review
that found no relevant improvement.

There is no finding quota and no architecture score.
