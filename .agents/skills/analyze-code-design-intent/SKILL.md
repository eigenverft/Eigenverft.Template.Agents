---
name: analyze-code-design-intent
description: Read-only, source-first reconstruction of capabilities, design ideas, decision logic, trade-offs, interactions, likely purpose, and useful applications from code at any scale, from a fragment or component to combined targets or an entire codebase. Keep observed behavior separate from inferred reasoning and historical intent.
---

# Analyze Code Design Intent

## Purpose

Use this softskill to inspect any selected code scope, from a single fragment, function, class, subsystem, or interaction path to several combined targets or a complete codebase, and answer the more interesting questions behind ordinary code comprehension:

> What does this implementation provide, what design ideas does it embody, what problem does it appear to solve, what reasoning and trade-offs may explain its shape, how does it behave in use, and what is it useful for?

The skill is not primarily an evidence report and not primarily a code-quality review. Evidence is necessary, but it supports the explanation rather than becoming the explanation itself.

The preferred reasoning chain is:

`selected code target -> implemented capabilities -> usage / interactions -> problem / need -> underlying design idea -> decision logic / trade-offs -> practical utility -> related hypotheses -> broader design concepts`

For historical questions, add a separate branch:

`design idea -> historical evidence -> possible original motivation`

The result should help a reader look at the selected code and say things such as:

- this implementation provides these concrete capabilities;
- these capabilities seem to embody this design idea;
- the idea is useful because it enables these operating modes or protects these properties;
- several otherwise separate subsystems appear to express the same larger principle;
- this broader interpretation is strongly supported, while this historical origin remains speculative.

## Analysis-State Contract

This is a read-only analysis skill.

- Keep source files, tests, configuration, documentation, generated files, dependencies, handoffs, and Git state unchanged when a repository or workspace is involved.
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
9. What interactions or execution flow make the design idea visible in actual use?
10. Which trade-offs, rejected alternatives, or competing concerns are suggested by the implementation shape?
11. Is there historical evidence for why the idea was originally introduced?

Do not force every answer into a user-facing product feature. Infrastructure can have meaningful features and design ideas of its own.

## Scope Model

This skill is intentionally not repository-bound.

The selected scope may be:

- a pasted code fragment or diff;
- one function, method, class, type, or file;
- a cooperating set of classes or functions;
- one feature, endpoint, command, lifecycle, data flow, or call path;
- a subsystem, package, library, or application;
- several code targets selected because the user wants them compared or understood together;
- a whole repository or multiple repositories when that breadth is materially useful.

Use the narrowest scope that answers the user's question. Do not widen from a fragment to a repository merely because more code is available.

If the target was established in the immediately preceding conversation, inherit that target automatically. Do not ask the user to restate it merely because the skill invocation itself contains no explicit path or scope.

Examples:

- user asks to locate `WebLib`, the workspace lookup identifies that project, then the skill is invoked -> analyze the identified `WebLib` project;
- user pastes a class, discusses it, then invokes the skill -> analyze that class and only the nearby context needed to understand it;
- user names two implementations to compare, then invokes the skill -> keep those two implementations as the combined scope.

Only resolve ambiguity when multiple plausible targets remain after considering the immediate conversation context.

For combined targets, explicitly state why they are being analyzed together, for example shared responsibility, interaction, common state, similar mechanism, competing implementations, or a suspected common design idea.

Repository-wide breadth mapping is required only when the requested scope is actually repository-wide.

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

- `observed use`: a concrete caller, consumer, integration, or tested scenario exists;
- `strongly implied use`: behavior makes the utility close to self-evident even if no external consumer was inspected;
- `possible use`: a plausible application of the capability that is not shown as an actual requirement or observed consumer behavior.

Never present a merely possible use as an existing feature requirement.

### Intent hypothesis

A plausible explanation for why a capability or design idea exists.

Examples:

- operators need to change coherent runtime profiles without restarting everything;
- intermittent connectivity is an expected operating condition;
- the application intentionally favors availability of the current good certificate over immediate acceptance of a replacement;
- launch-environment differences previously caused filesystem ambiguity.

### Decision-reasoning hypothesis

A bounded reconstruction of the decision logic that may explain why the implementation has its current shape.

Examples:

- preserving an already working runtime state appears to have been favored over applying the newest candidate immediately;
- explicit partial-commit state suggests the design accepts that true cross-resource atomicity is unavailable and chooses visible inconsistency over pretending rollback succeeded;
- executable-relative paths suggest predictability across launch contexts was favored over allowing arbitrary path flexibility;
- observer failures being unable to alter commit outcome suggests mutation authority was deliberately separated from notification extensibility.

A decision-reasoning hypothesis is not a claim about the developer's private chain of thought. Reconstruct only decision logic supported by implementation structure, alternatives visible in the code, tests, history, or documented constraints.

### Interaction / usage model

A compact description of how relevant participants behave together over time.

Examples:

- caller requests switch -> coordinator prepares every participant -> commits accepted candidates -> publishes notifications;
- file watcher notices change -> candidate is parsed and validated -> good candidate replaces snapshot -> bad candidate leaves last-known-good active;
- startup code creates bootstrap diagnostics -> loads configuration -> configures normal logging -> hands control to runtime host.

Use interaction models to explain why a design matters in actual use rather than describing components in isolation.

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

## Scope Coverage Rule

For a whole-repository request, do not begin by arbitrarily selecting only two or three interesting subsystems and treating them as the repository.

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

This prevents a three-area deep dive from looking like a complete repository interpretation. For fragment, component, subsystem, or combined-target requests, omit repository breadth work unless it is necessary to understand dependencies or consumers.

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

## Essence Rule

Every material implementation area or design idea must have a concise 1 to 3 line **Essence** statement before its detailed explanation.

The essence should answer, in ordinary language:

- what this code does or makes possible;
- the central reason or purpose it appears to serve;
- the practical effect, benefit, or operating property it creates.

A useful mental form is:

`This part does / enables X so that Y becomes possible or Z is protected.`

Do not make this a rigid sentence template, but keep the result sharp enough to stand alone without the rest of the report.

Good example:

`ConfigurationSets lets several configuration sources move toward one named desired state as a coordinated unit. This makes runtime profile changes possible without hiding mixed state, rejected candidates, or changes that require a restart.`

Bad example:

`ConfigurationSets manages configuration and has a coordinator.`

Also produce one scope-level essence near the top when the selected target contains more than one material idea.

## Reasoning And Trade-off Reconstruction Rule

For each material design idea, ask what decision pressure can be inferred from the code shape.

Look for evidence of choices such as:

- correctness versus availability;
- immediacy versus last-known-good continuity;
- flexibility versus predictability;
- central authority versus extensibility;
- atomicity versus explicit partial failure;
- runtime mutability versus restart-only safety;
- convenience versus security boundary clarity;
- abstraction reuse versus local ownership;
- backward compatibility versus simplification;
- performance versus observability or validation cost.

Then reconstruct the smallest defensible decision logic, for example:

`The design appears to accept delayed convergence because keeping the current valid runtime state is safer than publishing an invalid replacement.`

When an alternative implementation is visible or strongly implied, state it and explain why the current design may have favored one side of the trade-off.

Never claim access to an exact hidden thought sequence. Use terms such as `appears to favor`, `suggests an explicit trade-off`, `likely design pressure`, or `a plausible decision rationale`.

## Interaction And Runtime-Behavior Rule

Do not analyze design ideas only as static structures. When the code has meaningful sequencing, state, consumers, or cooperating participants, reconstruct the interaction flow.

Ask:

- who initiates the behavior;
- which participants interact;
- what state exists before the operation;
- what preparation, validation, mutation, commit, publication, retry, fallback, or cleanup steps happen;
- what happens on success;
- what happens on partial or total failure;
- what a caller, consumer, operator, or user observes;
- where ownership or lifecycle boundaries become visible.

Prefer a compact sequence or prose flow over a class inventory.

Interaction analysis may reveal design intent that no single class exposes by itself.

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

### Phase 1: Resolve and map the selected scope

First resolve what the user actually wants analyzed from the current request and immediately preceding conversation context: fragment, component, interaction path, combined targets, subsystem, application, or repository. Reuse an already-established target instead of asking for it again.

Before deep analysis, identify the meaningful implementation areas inside that selected scope. Only perform repository-wide breadth mapping when the scope is repository-wide.

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

For broad scopes, produce an internal or visible coverage map before deciding what to deepen. For narrow scopes, map only the immediate dependencies, callers, state, and interactions needed to understand the target.

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

### Phase 5: Reconstruct interaction and decision logic

Describe how the relevant parts behave together in use. Then ask what trade-off or design pressure best explains the chosen flow, boundaries, fallback behavior, and ownership.

When alternatives are visible, compare them. Keep the reasoning bounded and evidence-based rather than inventing a developer thought process.

### Phase 6: Explain practical utility

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

### Phase 7: Inspect consumers and manifestations

When possible, trace a design idea into consumers.

Ask:

- Which callers, applications, services, or integrations use this capability?
- Which endpoints, commands, services, or UI flows expose it?
- Is this a local implementation mechanism, a reusable capability, or part of one concrete application/product feature?
- Are test names the only place where a scenario appears, or does a real consumer use it?

This step is especially important before calling an infrastructure capability a product feature.

### Phase 8: Find recurring design principles

Compare independent areas and ask whether they embody the same larger idea.

Examples:

- configuration switching and certificate reload may both express `apply change without sacrificing known-good operation`;
- directory layout and machine binding may both express `make runtime identity independent of launch environment`;
- queues and retries may jointly express `intermittent external availability is expected`.

Only promote a synthesis when it explains multiple independently evidenced capabilities.

### Phase 9: Check historical origin where valuable

For the strongest or most surprising design ideas, inspect introduction history when available.

Prefer history that can answer:

- What was added together?
- Which problem did the commit describe?
- Did the initial implementation already contain the current design principle?
- Was the current idea introduced later as a correction or hardening step?

Historical archaeology should deepen the design story, not replace current source analysis.

### Phase 10: Build interrelationships

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

### Do not pretend inferred reasoning is known thought

Reconstruct decision logic and trade-offs, not a verbatim or exact private chain of thought. If the evidence only supports several plausible rationales, keep them as alternatives.

### Do not ignore interactions

A design idea often appears in the sequence between components rather than inside one class. Trace the relevant use or runtime flow when it changes the interpretation.

### Do not write a grand story first

Broader concepts must emerge from independently supported local design ideas.

### Do not confuse present design with original motivation

Historical intent needs historical evidence.

## Required Chat Output

The default output should be useful to a human before it is exhaustive.

### 1. Scope essence and design ideas at a glance

Begin with a 1 to 3 line **Scope essence** when more than one material idea is present. It should summarize what the selected code provides, its apparent central purpose, and the practical property or use it creates.

Then list the most important discovered ideas, normally 3 to 7 for a non-trivial broad scope and fewer for a narrow fragment or component.

For each, give one compact line:

`D1 - Controlled desired-state reconfiguration: several runtime configuration participants can move together between named states while failed or restart-required convergence remains explicit.`

Each idea line should itself function as a mini-essence: what it does, why it exists, and what it enables.

This section is the fastest answer to:

> What is this code really doing, and what is the point of that design?

If the analysis is still too shallow to name design ideas, say so and begin with the capability map instead.

### 2. Capability map

Show the meaningful implementation areas in the selected scope and what they provide. For a tiny fragment, this may be a short bullet list instead of a table.

Preferred shape:

| Implementation area | Implemented capabilities / features | What this enables / is useful for | Related design idea | Coverage |
| --- | --- | --- | --- | --- |
| ConfigurationSets | coordinated switching; desired-state persistence; startup-only/live apply; partial-commit detection | coherent runtime operating profiles without silently mixed state | D1 Controlled desired-state reconfiguration | deep |
| Kestrel certificates | generation reload; last-known-good; recovery policy; path containment | certificate rotation without unnecessarily destabilizing a healthy HTTPS endpoint | D2 Preserve known-good operation during replacement | deep |
| DirectoryLayout | executable-relative paths; writable-directory validation; web-root normalization | predictable packaged runtime behavior across launch contexts | D3 Environment-independent deployment contract | deep |

For large repository scopes, include discovered but shallow areas too, marked `skimmed` or `discovered only`. For narrow scopes, omit the Coverage column when it adds no value.

### 3. Design idea deep dives

For each material design idea, include:

**D1 - Short idea name**

- **Essence:** 1 to 3 lines that stand alone and state what the design does, why, and what it enables.

- **Embodied by:** implementation areas and concrete capabilities.
- **Core idea:** explain the concept in implementation-independent language.
- **Problem it appears to solve:** why the capability is useful.
- **Interaction / behavior:** the relevant runtime or usage sequence when sequencing matters.
- **Decision logic / trade-offs:** the smallest defensible reconstruction of what the design appears to favor and what alternative pressure it balances.
- **What it enables:** observed or strongly implied practical utility.
- **Evidence:** concise source references, tests, consumers, history where relevant.
- **Confidence:** strong / moderate / weak.
- **Historical origin:** supported explanation or `uncertain`.
- **Alternative explanation:** only when material.

The `Essence`, `What it enables`, and, when relevant, `Interaction / behavior` and `Decision logic / trade-offs` lines are mandatory for every material design idea.

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

### 7. Scope coverage and important gaps

For broad scopes, state which meaningful areas were:

- deeply inspected;
- skimmed for capability identification;
- discovered but not understood;
- intentionally excluded.

Then list only the smallest read-only probes that could materially change the design interpretation.

### 8. Bottom line

Finish with three compact parts:

- **What this selected code provides:** main capability themes.
- **What design ideas and decision logic appear to sit behind it:** strongest concepts and trade-offs.
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

### Scope breadth pass

For broad codebase or repository scopes, expand shallow/discovered areas into capability summaries without deep-diving every implementation detail.

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

The skill succeeds when the reader comes away understanding not just the code structure, but the capabilities, interaction flow, design ideas, likely decision logic, trade-offs, usefulness, and relationships that give the implementation its shape.

## Typical Invocation Phrases

- `[$analyze-code-design-intent] inspect this code and tell me what capabilities, design ideas, and decision trade-offs are embodied in it`
- `analyze this code fragment and reconstruct what problem it seems designed to solve`
- `compare these two components and infer the design reasoning behind their different approaches`
- `trace this interaction and explain why the sequence, ownership, and failure behavior may be designed this way`
- `map the technical features in this library to the underlying design ideas and practical uses`
- `read this repository and reconstruct the concepts behind the implementation without changing anything`
- `show me which independent subsystems express the same design principle`
- `find where this library capability becomes an actual application or user-facing feature`
