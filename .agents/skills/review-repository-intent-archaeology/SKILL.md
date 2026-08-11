---
name: review-repository-intent-archaeology
description: Read-only, source-first discovery of implemented capabilities, underlying design ideas, likely purposes, useful applications, constraints, and related intent hypotheses from an existing codebase. Start with repository-wide capability coverage, connect implementation details to design concepts, and keep observed behavior separate from inferred or historical intent.
---

# Review Repository Intent Archaeology

## Purpose

Use this softskill to inspect an existing codebase and answer the more interesting question behind ordinary code comprehension:

> What ideas are embodied by this implementation, what capabilities does it provide, why might those capabilities exist, and what are they useful for?

The skill is not primarily an evidence report and not primarily a code-quality review. Evidence is necessary, but it supports the explanation rather than becoming the explanation itself.

The preferred reasoning chain is:

`implementation area -> implemented capabilities -> problem / need -> underlying design idea -> practical utility -> related hypotheses -> broader design concepts`

For historical questions, add a separate branch:

`design idea -> historical evidence -> possible original motivation`

The result should help a reader look at a codebase and say things such as:

- this implementation provides these concrete capabilities;
- these capabilities seem to embody this design idea;
- the idea is useful because it enables these operating modes or protects these properties;
- several otherwise separate subsystems appear to express the same larger principle;
- this broader interpretation is strongly supported, while this historical origin remains speculative.

## Repository-State Contract

This is a read-only analysis skill.

- Keep source files, tests, configuration, documentation, generated files, dependencies, handoffs, and Git state unchanged.
- Do not create, edit, delete, rename, stage, commit, merge, rebase, push, restore, or format repository files.
- Do not run commands whose purpose is to mutate repository or application state.
- Build, test, or execute only when the user explicitly asks for runtime evidence and the operation is known to be non-destructive in the current environment.
- Return the analysis in chat by default.
- Do not create report files unless the user explicitly asks for an artifact.

If a useful probe would require mutation, describe the probe instead of performing it.

## Primary Questions

The analysis should actively try to answer these questions:

1. What does this implementation actually provide?
2. Which concrete capabilities or technical features are present?
3. What problem or operating condition makes each capability useful?
4. Which design idea or concept seems to connect those capabilities?
5. What does that design idea enable for applications, operators, developers, integrations, or users?
6. Which implementation areas express the same idea in different ways?
7. Which ideas combine into a larger architectural or product concept?
8. Which alternative explanations remain plausible?
9. Is there historical evidence for why the idea was originally introduced?

Do not force every answer into a user-facing product feature. Infrastructure can have meaningful features and design ideas of its own.

## Core Concept Types

### Implementation area

A meaningful code region such as a namespace, subsystem, package, public API surface, cooperating class cluster, integration boundary, lifecycle manager, persistence mechanism, or feature slice.

### Implemented capability

Something the implementation can actually do or guarantee.

Examples:

- switch several configuration sources as one logical set;
- persist desired configuration state;
- distinguish live-apply from restart-required changes;
- retain a last-known-good TLS certificate generation during a failed reload;
- normalize application directories relative to the executable;
- replay queued operations after connectivity returns;
- enforce an allowed lifecycle transition graph.

Capabilities are more useful to the reader than a list of classes because they answer:

> What functionality is contained here?

A capability may be technical, operational, developer-facing, integration-facing, or user-facing.

### Responsibility

The narrower ownership behind one or more capabilities.

Example:

`keep several configuration participants logically consistent during a state transition`

Use responsibilities internally when they help reasoning, but do not make a responsibility inventory the main report unless the user asks for one.

### Design idea

The conceptual idea expressed by one or more capabilities.

Examples:

- controlled runtime reconfiguration;
- desired-state control plane;
- last-known-good runtime replacement;
- fail-safe reload;
- explicit lifecycle ownership;
- executable-relative deployment contract;
- offline-tolerant operation;
- capability-based authorization;
- compatibility isolation.

A design idea should be more abstract than a class name but still explain the implementation shape.

### Practical utility

What the capability or design idea is useful for or enables.

Examples:

- switching an application between coherent operating profiles without silently leaving participants on mixed state;
- rotating certificates without taking down a healthy HTTPS endpoint because one replacement file is invalid;
- packaging applications so their writable/runtime directories behave consistently across IDE, service, and direct executable launch contexts;
- surviving intermittent network connectivity without losing user operations.

Distinguish three forms of utility:

- `observed use`: a concrete repository consumer or tested scenario exists;
- `strongly implied use`: behavior makes the utility close to self-evident even if no external consumer was inspected;
- `possible use`: a plausible application of the capability that is not shown as an actual repository requirement.

Never present a merely possible use as an existing feature requirement.

### Intent hypothesis

A plausible explanation for why a capability or design idea exists.

Examples:

- operators need to change coherent runtime profiles without restarting everything;
- intermittent connectivity is an expected operating condition;
- the application intentionally favors availability of the current good certificate over immediate acceptance of a replacement;
- launch-environment differences previously caused filesystem ambiguity.

### Synthesis concept

A broader design principle that explains several independently implemented ideas.

Examples:

- bounded runtime mutability;
- preserve known-good operation while applying change;
- explicit desired state with controlled convergence;
- deployment-environment independence;
- defensive integration with unreliable external systems.

## Present Design vs Historical Origin

Always separate these questions.

### Present design meaning

What idea is embodied by the implementation as it exists now?

This can often be inferred strongly from behavior, public APIs, tests, state transitions, error semantics, configuration, and consumers.

### Historical origin

Why was this idea originally introduced?

Current code alone rarely proves this. Use Git history, introduction diffs, commit messages, issue or PR discussions, old tests, design docs, or migration notes when available.

Use wording such as:

- `The current implementation embodies ...`
- `The introduction commit supports the historical explanation that ...`
- `The original motivation remains uncertain.`

Do not silently turn present design meaning into historical fact.

## Repository Coverage Rule

A whole-repository request must not begin by arbitrarily selecting only two or three interesting subsystems and treating them as the repository.

First create a breadth map of meaningful implementation areas.

Useful breadth signals include:

- project and package boundaries;
- top-level namespaces or feature folders;
- public/exported APIs;
- application entry points;
- extension methods and composition roots;
- persistence and state layers;
- integration boundaries;
- runtime/lifecycle infrastructure;
- security/trust mechanisms;
- tests grouped by subsystem;
- package descriptions and docs.

For each discovered area, perform enough inspection to identify at least its main capability theme, or explicitly mark it as not yet understood.

Then deepen the areas that provide the strongest design signal.

For a large repository, the report should include a compact coverage table such as:

| Area | Coverage | Main capability theme |
| --- | --- | --- |
| ConfigurationSets | deep | coordinated runtime configuration |
| Kestrel | deep | resilient certificate hosting |
| MachineBinding | skimmed | runtime identity binding |
| Protection | skimmed | local secret/data protection |
| Logging | discovered only | bootstrap/runtime logging |

This prevents a three-area deep dive from looking like a complete repository interpretation.

## Capability Extraction Rule

For every implementation area that receives meaningful attention, explicitly ask:

> What features or capabilities does this implementation contain?

Do not stop at:

`ConfigurationSetCoordinator coordinates configuration state.`

Prefer a capability list such as:

`ConfigurationSets provides:`

- coordinated switching of several configuration participants;
- prepare-before-commit transition semantics;
- detection of partially committed / inconsistent state;
- persistent desired state;
- startup-only versus live-apply policy;
- lifecycle notifications and ownership rules.

Then abstract upward:

`Underlying design idea: controlled desired-state runtime reconfiguration.`

Then explain utility:

`Useful for: changing coherent application operating profiles while making failed or restart-required convergence explicit.`

This capability -> idea -> utility chain is mandatory for material areas.

## Design-Idea Discovery Heuristics

When inspecting code, actively look for design ideas expressed through combinations of mechanisms.

### Change-management ideas

Signals:

- prepare / commit phases;
- desired versus actual state;
- restart-required markers;
- generations or snapshots;
- atomic publication;
- rollback or last-known-good behavior;
- consistency status.

Possible ideas:

- controlled convergence;
- transactional approximation;
- bounded live reconfiguration;
- preserve-known-good-on-change.

### Lifecycle ideas

Signals:

- startup-only state;
- explicit activation/deactivation;
- leases and disposal;
- ownership checks;
- generation replacement;
- state transition guards.

Possible ideas:

- explicit lifecycle ownership;
- stable lifecycle boundaries;
- no hidden state transitions.

### Reliability ideas

Signals:

- retries;
- queues;
- fallback;
- last-known-good;
- degraded state;
- circuit breaking;
- partial-failure representation.

Possible ideas:

- graceful degradation;
- continuity over immediacy;
- failure containment;
- intermittent-connectivity tolerance.

### Deployment and environment ideas

Signals:

- executable-rooted paths;
- environment normalization;
- immutable versus writable directories;
- launch-context checks;
- packaging constraints.

Possible ideas:

- environment-independent application layout;
- reproducible deployment contract;
- explicit writable-runtime boundary.

### Trust and security ideas

Signals:

- capability checks;
- ownership validation;
- path containment;
- secret stores;
- certificate validation;
- identity binding.

Possible ideas:

- least authority;
- trust-boundary enforcement;
- local identity anchoring;
- defense against path or ownership escape.

These are prompts for investigation, not labels to apply automatically.

## Evidence Sources

Prefer actual repository evidence. Useful evidence includes:

1. implementation code and control flow;
2. public API shape and exported contracts;
3. callers, consumers, composition roots, and dependency edges;
4. state ownership and state transitions;
5. tests and assertions;
6. configuration and feature switches;
7. schemas, serialization, persistence, and API contracts;
8. error types, fallback logic, validation, retry, and invariants;
9. package/project descriptions, comments, and documentation;
10. naming and directory structure;
11. Git history, introduction diffs, commit messages, blame, tags;
12. issue or PR material when available.

Treat naming and folder placement as weaker evidence unless behavior corroborates them.

## Evidence Discipline

Evidence is required, but detailed evidence should normally sit behind the design explanation rather than dominate the beginning of the report.

Use concise source references directly on capability and design claims.

Keep raw observation IDs only when they materially help traceability, comparison, or follow-up analysis. Do not produce a long numbered observation catalog by default.

For each major design idea, retain enough evidence to answer:

- Which implementation mechanisms express this idea?
- Which independent evidence channels support it?
- What evidence would weaken it?

## Confidence And Inference Distance

Avoid fake numerical precision unless the user requests a scoring model.

Use qualitative confidence:

- `strong`
- `moderate`
- `weak`

Use inference distance when useful:

- `near`: little interpretation beyond observed behavior;
- `medium`: several mechanisms combined into a design purpose;
- `far`: broad product concept or historical motivation reconstructed indirectly.

Confidence and inference distance are different.

## Alternative Explanations And Negative Evidence

For important design or intent hypotheses, ask:

- What alternative explanation could produce the same implementation?
- What evidence should exist if this interpretation is true?
- Is expected evidence missing?
- Are multiple apparent signals actually derived from the same source?

Do not keep weak alternatives merely for symmetry. Keep them when they materially affect the interpretation.

## Workflow

### Phase 1: Map the repository surface

Before deep analysis, identify the meaningful implementation areas across the requested scope.

For a library, pay particular attention to:

- exported/public APIs;
- package description;
- namespace and folder groups;
- extension/composition entry points;
- tests grouped by functionality;
- consumers elsewhere in the repository or workspace when available.

For an application, pay particular attention to:

- user/API entry points;
- feature slices;
- domain/state models;
- integrations;
- background/runtime subsystems;
- persistence;
- operational surfaces.

Produce an internal or visible coverage map before deciding what to deepen.

### Phase 2: Extract capabilities per area

For every relevant area, answer:

- What can this implementation do?
- What behavior does it guarantee or make possible?
- Which variants, policies, modes, or failure semantics exist?
- Which public or externally consumable surface exposes the capability?
- Which tests demonstrate the capability?

Group related mechanisms into reader-meaningful feature/capability bullets.

### Phase 3: Ask what problem the capabilities solve

For each capability cluster, ask:

> What problem, constraint, or desired operating mode makes these capabilities worth having?

Examples:

- Why coordinate several config participants rather than reload each independently?
- Why retain last-known-good instead of accepting every certificate reload?
- Why model restart-required separately from live apply?
- Why anchor paths to the executable instead of current working directory?

This question is the bridge from implementation detail to design meaning.

### Phase 4: Name the underlying design idea

Give the idea a concise name that is independent of exact class names when possible.

Prefer:

`Preserve known-good operation during runtime replacement`

or:

`Controlled desired-state convergence`

over:

`SniCertificateState design`

The code name may be included as evidence, but the idea should explain why the code has that shape.

### Phase 5: Explain practical utility

For each material design idea, state what it is useful for.

Include concrete consequences such as:

- operating without downtime;
- switching coherent runtime profiles;
- preventing mixed state;
- supporting self-contained deployment;
- reducing dependence on IDE/working-directory behavior;
- tolerating temporary external failures;
- preserving compatibility while internals evolve;
- exposing a stable control surface to multiple applications.

Label utility as observed, strongly implied, or possible when ambiguity matters.

### Phase 6: Inspect consumers and manifestations

When possible, trace a design idea into consumers.

Ask:

- Which applications use this library feature?
- Which endpoints, commands, services, or UI flows expose it?
- Is this a reusable infrastructure capability or part of one concrete product feature?
- Are test names the only place where a scenario appears, or does a real consumer use it?

This step is especially important before calling an infrastructure capability a product feature.

### Phase 7: Find recurring design principles

Compare independent areas and ask whether they embody the same larger idea.

Examples:

- configuration switching and certificate reload may both express `apply change without sacrificing known-good operation`;
- directory layout and machine binding may both express `make runtime identity independent of launch environment`;
- queues and retries may jointly express `intermittent external availability is expected`.

Only promote a synthesis when it explains multiple independently evidenced capabilities.

### Phase 8: Check historical origin where valuable

For the strongest or most surprising design ideas, inspect introduction history when available.

Prefer history that can answer:

- What was added together?
- Which problem did the commit describe?
- Did the initial implementation already contain the current design principle?
- Was the current idea introduced later as a correction or hardening step?

Historical archaeology should deepen the design story, not replace current source analysis.

### Phase 9: Build interrelationships

Use relationships when they add understanding:

- `supports`
- `contradicts`
- `alternative_to`
- `depends_on`
- `part_of`
- `jointly_explains`
- `shares_evidence_with`
- `narrows`

Prefer relationships between design ideas and synthesis concepts, not merely between dozens of raw observations.

## Anti-Patterns

### Do not lead with an observation wall

The user should not have to read ten or twenty source facts before learning what the implementation is interesting for.

### Do not replace design discovery with responsibility naming

`owns certificate state` is not yet a design idea.

Ask why the ownership and state model are shaped that way.

### Do not stop after three interesting areas

If the request covers a repository, map the broader repository surface first. Deep dives may be selective, but coverage must be visible.

### Do not call everything a product feature

Technical features are still capabilities. Distinguish:

- user-facing feature;
- application/platform capability;
- operational feature;
- library feature;
- implementation mechanism.

### Do not describe only what exists

Always ask what the capability enables and why that may matter.

### Do not write a grand story first

Broader concepts must emerge from independently supported local design ideas.

### Do not confuse present design with original motivation

Historical intent needs historical evidence.

## Required Chat Output

The default output should be useful to a human before it is exhaustive.

### 1. Design ideas at a glance

Start with the most important discovered ideas, normally 3 to 7 for a non-trivial repository.

For each, give one compact line:

`D1 - Controlled desired-state reconfiguration: several runtime configuration participants can move together between named states while failed or restart-required convergence remains explicit.`

This section is the fastest answer to:

> What ideas are actually inside this codebase?

If the analysis is still too shallow to name design ideas, say so and begin with the capability map instead.

### 2. Repository capability map

Show the meaningful implementation areas and what they provide.

Preferred shape:

| Implementation area | Implemented capabilities / features | What this enables / is useful for | Related design idea | Coverage |
| --- | --- | --- | --- | --- |
| ConfigurationSets | coordinated switching; desired-state persistence; startup-only/live apply; partial-commit detection | coherent runtime operating profiles without silently mixed state | D1 Controlled desired-state reconfiguration | deep |
| Kestrel certificates | generation reload; last-known-good; recovery policy; path containment | certificate rotation without unnecessarily destabilizing a healthy HTTPS endpoint | D2 Preserve known-good operation during replacement | deep |
| DirectoryLayout | executable-relative paths; writable-directory validation; web-root normalization | predictable packaged runtime behavior across launch contexts | D3 Environment-independent deployment contract | deep |

For large repositories, include discovered but shallow areas too, marked `skimmed` or `discovered only`.

### 3. Design idea deep dives

For each material design idea, include:

**D1 - Short idea name**

- **Embodied by:** implementation areas and concrete capabilities.
- **Core idea:** explain the concept in implementation-independent language.
- **Problem it appears to solve:** why the capability is useful.
- **What it enables:** observed or strongly implied practical utility.
- **Evidence:** concise source references, tests, consumers, history where relevant.
- **Confidence:** strong / moderate / weak.
- **Historical origin:** supported explanation or `uncertain`.
- **Alternative explanation:** only when material.

The `What it enables` line is mandatory for every material design idea.

### 4. Cross-cutting design principles

Explain whether independent design ideas combine into broader principles.

Example:

`D1 controlled configuration convergence + D2 last-known-good certificate reload jointly suggest S1: runtime change is allowed, but change must not silently destroy known-good operation.`

This is where broader architecture or product philosophy should emerge.

### 5. Feature / consumer interpretation

When evidence permits, explain how the technical capabilities may appear to consumers.

Examples:

- `ConfigurationSets is a reusable library capability; in EdgeReverseProxy it may surface as ...`
- `The certificate subsystem is primarily an operational hosting feature rather than an end-user feature.`
- `The queue and conflict resolver together support a user-visible offline editing capability.`

Separate observed consumers from plausible uses.

If no consumers were inspected, say that explicitly rather than implying a product feature.

### 6. Competing hypotheses and interrelationships

Keep this concise and only include relationships that change interpretation.

Examples:

- `D2 supports S1 because it independently expresses preserve-known-good semantics.`
- `H3 alternative_to H4: the path model may be primarily packaging-driven rather than IDE-normalization-driven.`
- `D1 shares evidence with H1, so they are not independent support for a broader synthesis.`

### 7. Coverage and important gaps

State which meaningful repository areas were:

- deeply inspected;
- skimmed for capability identification;
- discovered but not understood;
- intentionally excluded.

Then list only the smallest read-only probes that could materially change the design interpretation.

### 8. Bottom line

Finish with three compact parts:

- **What this codebase provides:** main capability themes.
- **What design ideas appear to sit behind it:** strongest concepts.
- **What remains uncertain:** especially historical origin or uninspected consumers.

## Optional Evidence Appendix

Only add a raw observation / evidence appendix when:

- the user asks for full traceability;
- the analysis is contested;
- many hypotheses depend on subtle evidence;
- stable evidence IDs are useful for follow-up work.

If used, place it after the human-readable design report, not before it.

Stable IDs such as `O1`, `C1`, `D1`, `H1`, and `S1` may be used when they improve continuity across turns.

## No-Design-Idea Contract

Do not invent a design philosophy merely to complete the output.

If capabilities can be identified but their underlying idea cannot yet be defended, say:

`Capabilities identified; no defensible underlying design idea yet.`

Then explain what is implemented and which small read-only probes could reveal its rationale.

## Follow-Up Modes

### Deepen one design idea

Trace one idea across implementation, tests, consumers, and history.

### Consumer pass

Find where a library capability is actually used and determine whether it becomes an application or user-facing feature.

### Historical-origin pass

Inspect introduction commits and evolution to distinguish original motivation from later hardening.

### Concept relationship pass

Compare design ideas and test whether a broader synthesis genuinely explains several independent areas.

### Repository breadth pass

Expand shallow/discovered areas into capability summaries without deep-diving every implementation detail.

## Source Referencing

Prefer concrete source references directly next to the claim they support:

- `path/to/file.ext:Type.Method`
- `path/to/file.ext:functionName`
- `path/to/file.ext:line` when line numbers are available and useful.

Do not fabricate symbols or line numbers.

## Preferred Tone

Be investigative, explanatory, and concept-oriented.

Prefer language such as:

- `This implementation provides ...`
- `A useful way to understand these mechanisms is ...`
- `The underlying design idea appears to be ...`
- `This is useful for ...`
- `The code independently expresses the same principle in ...`
- `The consumer evidence shows ...`
- `Historical origin remains uncertain.`

Avoid making the report sound like a forensic ledger unless the user asks for that style.

The skill succeeds when the reader comes away understanding not just the code structure, but the capabilities, design ideas, usefulness, and relationships that give the implementation its shape.

## Typical Invocation Phrases

- `[$review-repository-intent-archaeology] inspect this codebase and tell me what capabilities and design ideas are hidden in the implementation`
- `use repository intent archaeology and explain what the implementation provides, why those features might exist, and what they are useful for`
- `map the technical features in this library to the underlying design ideas`
- `read this repository and reconstruct the concepts behind the implementation without changing anything`
- `show me which independent subsystems express the same design principle`
- `find where this library capability becomes an actual application or user-facing feature`
