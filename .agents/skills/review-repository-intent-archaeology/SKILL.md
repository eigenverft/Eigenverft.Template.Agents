---
name: review-repository-intent-archaeology
description: Read-only, source-first reconstruction of likely responsibilities, concepts, constraints, features, and design intent from an existing codebase. Build traceable observations first, derive bounded hypotheses second, and analyze how hypotheses support, contradict, depend on, or combine with each other without pretending inferred historical intent is known fact.
---

# Review Repository Intent Archaeology

## Purpose

Use this softskill to inspect an existing codebase and reconstruct what ideas may sit behind the implementation.

The goal is not ordinary code summarization and not a code-quality review. The goal is to move carefully from observable repository facts toward plausible explanations of why a responsibility exists, what problem it appears to solve, which concept or feature it may belong to, and how several local hypotheses may relate to a broader intent.

The core chain is:

`repository evidence -> observations -> responsibilities -> local hypotheses -> hypothesis relationships -> synthesis hypotheses`

Keep every transition traceable. Preserve uncertainty. Prefer several bounded plausible explanations over one confident story that the repository does not prove.

## Repository-State Contract

This is a read-only analysis skill.

- Keep source files, tests, configuration, documentation, generated files, dependencies, handoffs, and Git state unchanged.
- Do not create, edit, delete, rename, stage, commit, merge, rebase, push, restore, or format repository files.
- Do not run commands whose purpose is to mutate the repository or application state.
- Build, test, or execute only when the user explicitly asks for runtime evidence and the operation is known to be non-destructive in the current environment.
- Return the analysis in chat by default.
- Do not create report files unless the user explicitly asks for an artifact.

If a useful next step would require mutation, describe the probe rather than performing it.

## What This Skill Is For

Use this skill when the user has a codebase and wants to understand questions such as:

- Why does this code part exist?
- What responsibility does it appear to own?
- What problem makes that responsibility necessary?
- Is this likely a domain rule, feature, architectural mechanism, resilience measure, compatibility layer, migration artifact, operational constraint, or workaround?
- Which code areas appear to express the same underlying idea?
- Which larger concept could explain several otherwise separate responsibilities?
- Which competing explanations fit the evidence?
- Which hypotheses reinforce or contradict each other?
- What evidence would distinguish two plausible explanations?
- Which apparent feature or concept is only weakly supported?

## What This Skill Is Not For

Do not turn this into:

- a line-by-line code explanation;
- a generic architecture review;
- a refactoring plan;
- a code-quality score;
- a security review;
- a performance review;
- a feature inventory based only on filenames or names;
- an attempt to invent product requirements from common patterns;
- a claim that present code proves the original historical intention.

If code-quality or architecture problems are noticed incidentally, mention them only when they materially affect intent reconstruction. Do not produce remediation tasks unless the user explicitly asks for them.

## Core Distinction: Present Intent vs Historical Origin

Always distinguish these two questions:

### Present structural intent

What responsibility or purpose does the current implementation appear to serve now?

This can often be inferred from code structure, call sites, tests, state transitions, configuration, and runtime contracts.

### Historical origin hypothesis

Why was this responsibility originally introduced, and what initial requirement or idea motivated it?

Current code alone normally cannot establish this as fact. Treat historical origin as a hypothesis unless supported by explicit historical evidence such as commit messages, issue or PR discussion, old tests, design documents, migration notes, or comments tied to the introduction of the behavior.

Never silently convert present structural intent into claimed historical fact.

## Analysis Unit

Work locally before working globally.

A useful analysis unit can be a:

- function or method;
- class or type;
- module or package;
- endpoint or command;
- state transition;
- persistence model;
- configuration option;
- adapter or integration boundary;
- test cluster;
- small cooperating set of components.

Do not begin by inventing a repository-wide product story. Start with small responsibilities and expand only when evidence connects them.

## Evidence Sources

Prefer actual repository evidence. Useful evidence includes:

1. implementation code and control flow;
2. callers, callees, dependency edges, and composition roots;
3. state ownership and state transitions;
4. tests and assertions;
5. configuration and feature switches;
6. schemas, serialization contracts, API contracts, and persistence shapes;
7. error types, retry behavior, fallback logic, validation, and invariants;
8. comments and documentation;
9. naming and directory structure;
10. Git history, commit messages, blame, tags, and diffs when available and relevant;
11. issue or PR material when available in the working environment and relevant to the requested scope.

Treat naming, comments, and folder placement as useful but weaker evidence unless behavior corroborates them.

## Evidence Classes

Label important claims using these conceptual classes.

### Observation

A directly inspectable repository fact.

Examples:

- `SessionRefreshManager` is called before authenticated requests.
- The queue is persisted and replayed after reconnection.
- A test rejects the transition from `Closed` back to `Draft`.

An observation should avoid inferred motivation.

### Derived responsibility

A compact abstraction of one or more observations describing what a code area appears responsible for.

Examples:

- maintain an authenticated session across token expiry;
- preserve operations while connectivity is unavailable;
- enforce allowed lifecycle transitions.

Derived responsibilities are interpretations, but they should remain close to observable behavior.

### Local hypothesis

A plausible explanation of why the responsibility exists or what concept it implements.

Examples:

- users are intended to remain signed in while access tokens rotate;
- intermittent connectivity is an expected operating condition;
- the status lifecycle represents a domain workflow rather than incidental storage state.

### Synthesis hypothesis

A higher-level explanation that unifies several independently supported local hypotheses.

Examples:

- the application was designed to remain usable during intermittent connectivity;
- the system treats approval as a first-class domain workflow;
- backward compatibility with an older external protocol shaped several current boundaries.

Require stronger evidence for synthesis hypotheses than for local hypotheses.

## Intent Categories

When useful, classify a hypothesis as one of these rather than calling everything a feature:

- `user-facing capability`
- `domain rule or invariant`
- `workflow or lifecycle concept`
- `security or trust requirement`
- `resilience or reliability goal`
- `performance or resource constraint`
- `external-system constraint`
- `compatibility requirement`
- `migration or evolution artifact`
- `operational or deployment constraint`
- `developer ergonomics or maintainability mechanism`
- `defensive workaround or technical debt`
- `unknown / mixed`

Only infer a user-facing feature when there is evidence of user-visible behavior, a public contract, UI/API semantics, tests expressing user behavior, documentation, or several implementation responsibilities that coherently support it.

## Hypothesis Relationships

Use a small explicit relation vocabulary when hypotheses interact:

- `supports`: one hypothesis makes another more plausible;
- `contradicts`: both cannot comfortably explain the same evidence as currently stated;
- `alternative_to`: competing explanations for substantially the same evidence;
- `depends_on`: one hypothesis only makes sense if another is true;
- `part_of`: a local hypothesis is a narrower constituent of a broader one;
- `jointly_explains`: several hypotheses together explain evidence better than any one alone;
- `shares_evidence_with`: hypotheses reuse substantial evidence and therefore are not independent confirmation;
- `narrows`: one hypothesis constrains a broader hypothesis without replacing it.

Do not create relations merely to make a dense graph. Report only useful relationships.

## Confidence And Inference Distance

Avoid fake numerical precision such as `0.82` unless the user explicitly requests a scoring model.

For each important hypothesis, use qualitative confidence:

- `strong`
- `moderate`
- `weak`

Also state inference distance:

- `near`: little interpretation beyond directly observed behavior;
- `medium`: combines several observations into a plausible purpose;
- `far`: reconstructs product intent, historical motivation, or a broad concept from indirect evidence.

Confidence and inference distance are different. A broad hypothesis can be strongly supported while still being a far inference.

## Evidence Independence Rule

Do not count repeated expressions of the same underlying fact as independent confirmation.

For example, a class name, its comment, and a test copied from that comment may all reflect one source of intent rather than three independent signals.

Prefer hypotheses supported by different evidence channels, such as:

- behavior plus tests;
- persistence shape plus call sites;
- configuration plus runtime branching;
- implementation plus Git history;
- several independently owned subsystems expressing the same constraint.

For a synthesis hypothesis, prefer at least two local hypotheses with substantially independent evidence. If this is not available, label the synthesis weak or do not promote it.

## Negative Evidence And Expected Evidence

For material hypotheses, ask what else should exist if the hypothesis were true.

Examples:

If the hypothesis is `offline editing is an intentional user capability`, expected evidence might include:

- persisted local operations;
- delayed synchronization;
- conflict handling;
- user-visible pending or offline state;
- tests for offline flows;
- documentation or product language.

Missing expected evidence does not automatically falsify a hypothesis, but it should lower confidence or narrow the claim.

Actively record:

- missing expected evidence;
- evidence that points in another direction;
- code areas that should participate but do not;
- alternative explanations that remain viable.

## Workflow

### Phase 1: Orient without explaining everything

Establish the requested scope and inspect enough repository structure to identify meaningful responsibility boundaries.

If the user asks about the whole repository and it is non-trivial, do not exhaustively summarize every file. Select a small number of high-signal areas for the first pass and state the important exclusions.

Good first-pass signals include:

- application entry points;
- feature or domain boundaries;
- central state models;
- integrations;
- persistence boundaries;
- lifecycle coordinators;
- queues, schedulers, retries, caches, permission checks, state machines, and compatibility layers;
- tests that encode behavior.

### Phase 2: Extract local observations

For each selected unit, determine:

- what inputs it receives;
- what outputs or side effects it produces;
- what state it owns or changes;
- who calls it and what it calls;
- which conditions or invariants it protects;
- which tests or contracts depend on it;
- what would break or become impossible if it disappeared.

Write observations before motivations.

### Phase 3: Derive responsibilities

Summarize the smallest useful responsibility that explains the observed behavior.

Prefer:

`prevents concurrent refresh operations and replaces expired credentials`

over:

`handles authentication stuff`

Do not yet force the responsibility into a feature.

### Phase 4: Generate bounded explanations

For each meaningful responsibility, ask:

`What problem would make this responsibility necessary?`

Generate one or more plausible explanations when the evidence permits. Include technical or historical alternatives, not only product explanations.

For example, a retry mechanism might exist because of:

- an explicit resilience requirement;
- a flaky external dependency;
- a temporary migration workaround;
- an SDK limitation.

Keep alternatives alive until evidence distinguishes them.

### Phase 5: Cross-check hypotheses

Look for evidence outside the originating code unit that would strengthen, weaken, narrow, or contradict each hypothesis.

Useful probes include:

- other call sites;
- related state or schemas;
- tests;
- configuration;
- sibling components;
- error handling;
- UI/API exposure;
- Git history when historical motivation matters.

Do not broaden the repository scan merely to be exhaustive. Expand only where a probe can materially change a hypothesis.

### Phase 6: Build relationships

Compare the surviving hypotheses.

Ask:

- Are two hypotheses alternatives for the same evidence?
- Does one depend on another?
- Do several local hypotheses point toward one broader concept?
- Are several apparently independent findings actually the same evidence repeated?
- Does one hypothesis explain observations that another leaves unexplained?
- Do two hypotheses jointly explain a pattern better than either alone?

### Phase 7: Promote synthesis carefully

Only create a broader concept, feature, or original-intent hypothesis when several local findings support the promotion.

A synthesis should explain more evidence with fewer unsupported assumptions.

Do not promote a concept solely because it is a familiar software pattern.

### Phase 8: Report uncertainty and next discriminating probes

End by showing which hypotheses are well supported, which remain open, and which small read-only probes would most efficiently distinguish the remaining alternatives.

## Anti-Narrative Rules

### Do not write the story first

Never begin with a presumed product feature and reinterpret every code area to fit it.

### Do not confuse implementation pattern with intent

A queue does not automatically mean offline-first. A state machine does not automatically mean a formal business workflow. A cache does not automatically mean a performance requirement.

### Do not infer users from technical behavior without evidence

Technical responsibilities may exist for operations, compatibility, security, external APIs, or debt rather than a user-facing feature.

### Do not treat current necessity as original motivation

Code may have drifted, accumulated responsibilities, or survived after its original purpose changed.

### Do not erase alternatives too early

If two explanations fit, keep both and identify the evidence that would distinguish them.

### Do not reward larger hypotheses merely because they sound coherent

Prefer a small, well-supported local hypothesis over an elegant repository-wide story with weak traceability.

## Default Breadth

The default pass is intentionally bounded.

For a large repository, prefer:

- a few high-signal areas;
- a small set of concrete observations per area;
- only material responsibilities;
- only hypotheses that add explanatory value;
- only relationships that affect interpretation.

If the first pass reveals a promising cluster, recommend a second focused pass on that cluster rather than pretending the first pass covered the entire repository.

## Required Chat Output

Use the following structure for the default report. Keep it compact enough to reason about, but detailed enough that every important hypothesis remains traceable.

### 1. Analysis scope

State:

- repository or subsystem reviewed;
- branch / revision when available;
- analysis mode: `read-only intent archaeology`;
- high-signal areas inspected;
- important exclusions.

Do not dump every filename or command.

### 2. Observation map

List direct observations grouped by local code area.

Use stable IDs such as `O1`, `O2`, `O3`.

For each observation include:

- code area;
- concise fact;
- source reference such as file path plus symbol, and line when conveniently available.

Keep interpretation minimal here.

### 3. Responsibility map

Use stable IDs such as `R1`, `R2`.

For each responsibility include:

- concise responsibility;
- observations that support it;
- scope or owning code area.

### 4. Hypothesis set

Use stable IDs such as `H1`, `H2`.

For each hypothesis include:

- claim;
- intent category;
- supporting observations / responsibilities;
- counterevidence or missing expected evidence;
- viable alternatives;
- confidence: `strong`, `moderate`, or `weak`;
- inference distance: `near`, `medium`, or `far`;
- whether the claim is about present structural intent or historical origin.

Do not require every field to be verbose. One compact block per hypothesis is enough.

### 5. Hypothesis relationships

Report only material relations, for example:

`H2 supports H5 because ...`

`H3 alternative_to H4 because ...`

`H1 + H2 jointly_explain H6 because ...`

`H4 shares_evidence_with H5, so they are not independent confirmation.`

### 6. Synthesis candidates

Include this section only when justified.

For each broader synthesis hypothesis use an ID such as `S1` and include:

- broader concept or possible feature;
- local hypotheses it explains;
- why the combination is stronger than the parts alone;
- important alternative explanation;
- confidence and inference distance.

If no synthesis is defensible, say so directly.

### 7. Gaps and discriminating probes

List the smallest read-only checks that would most improve the analysis.

Examples:

- inspect the call sites of one boundary;
- inspect tests around one lifecycle;
- inspect the introduction commit for one subsystem;
- check whether a state is user-visible or only internal;
- compare two sibling implementations.

Prefer probes that can falsify or distinguish hypotheses, not generic requests to inspect more code.

### 8. Bottom line

Finish with a short summary separating:

- what is directly observed;
- what is the strongest current interpretation;
- what remains speculative.

## No-Hypothesis Contract

A useful analysis does not require an intent hypothesis.

If the evidence supports observations and responsibilities but not a defensible explanation of intent, say:

`No defensible intent hypothesis yet.`

Then report the strongest observations, responsibilities, and the smallest probes that could make a hypothesis possible.

Do not invent a feature or design rationale merely to complete the report.

## Follow-Up Modes

When the user continues the analysis, preserve IDs where practical so hypotheses can evolve across turns.

Useful follow-ups include:

### Deepen one hypothesis

Inspect only evidence that could materially strengthen, weaken, or distinguish the selected hypothesis.

### Compare hypotheses

Build a focused comparison of alternatives, shared evidence, contradictions, and expected evidence.

### Expand one concept cluster

Trace a synthesis hypothesis into nearby code and test whether it explains additional independent responsibilities.

### Historical-origin pass

Use Git history and available historical artifacts to test whether a present-intent hypothesis also describes the likely original motivation.

### Feature-evidence pass

Test whether a technical concept actually reaches user-visible behavior or public API semantics strongly enough to call it a feature.

## Source Referencing

Prefer concrete source references in the report:

- `path/to/file.ext:Type.Method`
- `path/to/file.ext:functionName`
- `path/to/file.ext:line` when line numbers are available and useful.

Do not fabricate line numbers or symbols.

## Preferred Tone

Be investigative, compact, and skeptical.

Use language such as:

- `observed`
- `appears responsible for`
- `supports the hypothesis`
- `plausible alternative`
- `missing expected evidence`
- `current structural intent`
- `historical origin remains uncertain`

Avoid language such as:

- `obviously`
- `clearly intended` unless explicit evidence exists;
- `the developers wanted` without historical evidence;
- `this is the feature` when the evidence only supports a technical mechanism.

The skill succeeds when the user can see not only the hypotheses, but also why they exist, how they relate, and where the uncertainty comes from.

## Typical Invocation Phrases

- `[$review-repository-intent-archaeology] inspect this codebase and reconstruct the likely ideas behind it`
- `use repository intent archaeology on this repository`
- `read this subsystem and tell me why these responsibilities probably exist`
- `extract observations and hypotheses from this code without changing anything`
- `look for possible features or concepts behind this implementation, but keep evidence and speculation separate`
- `compare the intent hypotheses you found and show how they relate`
