---
name: analyze-design-intent
description: Read-only reconstruction of the design intent behind a selected technical target. Discover what it does or expresses, how it fits into its surroundings, how interactions and data/state matter when relevant, what problem or constraint it addresses, what trade-offs may explain its shape, and what it enables. Treat the user's target as the question boundary rather than the evidence boundary, expand context only when it can materially change the interpretation, and explain the result independently of local project vocabulary.
---

# Analyze Design Intent

## Purpose

Use this softskill when a user has a technical target they do not yet understand and wants to discover what is really behind it.

The target may be any technically meaningful material available for inspection: a small fragment, configuration, documentation, workflow definition, data representation, script, group of related materials, behavior, subsystem, or a much broader body of work.

Do not begin by forcing the target into a predefined artifact category. First determine what role it appears to play.

The central questions are:

> What is this thing actually doing or expressing?
>
> What role does it play in its surroundings?
>
> Why might it be designed this way?
>
> Which constraints, assumptions, decisions, and trade-offs are visible?
>
> How does it behave when used or combined with other parts?
>
> What does that make possible, easier, safer, more predictable, or intentionally constrained?

The internal reasoning may move through:

`target -> evidence -> meaning / behavior -> interactions / state -> capabilities -> problem / pressure -> design idea -> trade-offs -> practical purpose`

This is a reasoning chain, not the required report structure.

## Read-Only Contract

This is a read-only analysis skill.

- Keep all available source material and repository/workspace state unchanged.
- Do not create, edit, delete, rename, stage, commit, merge, rebase, push, restore, or format files.
- Do not run commands whose purpose is to mutate application, repository, workspace, or external state.
- Build, test, or execute only when the user explicitly asks for runtime evidence and the action is known to be non-destructive.
- Return the analysis in chat by default.
- Do not create report files unless the user explicitly asks for an artifact.

If a useful probe would require mutation, describe the probe instead of performing it.

## Scope Principle

### The target is the question boundary, not automatically the evidence boundary

The selected target defines what the answer is about.

It does **not** mean all evidence must come from inside the target.

Use the narrowest answer scope that satisfies the user's question, while allowing the evidence scope to expand when surrounding material can materially change the interpretation.

Surrounding evidence may reveal:

- who or what uses the target;
- what the target uses or depends on;
- what happens before and after it;
- how it is configured, generated, transformed, stored, composed, published, invoked, loaded, tested, documented, automated, or evolved;
- whether it is one part of a larger capability;
- whether its apparent purpose changes when seen in actual use;
- whether nearby material establishes a contract, lifecycle, compatibility expectation, data model, operational expectation, or intended audience that is not visible locally.

These are possible discoveries, not categories the target must fit into.

### Scope inheritance

If the target was established in the immediately preceding conversation, inherit it automatically.

Do not ask the user to restate something that was just located, pasted, named, or selected.

Only resolve ambiguity when multiple plausible targets remain after considering the immediate conversation.

### Scope reflection

Before deep analysis, reflect on the target itself:

- What appears to be the semantic boundary of what the user pointed at?
- Which visible boundaries may be merely organizational rather than conceptual?
- Does the target make sense on its own, or is it obviously one participant in a larger behavior?
- Which nearby evidence could materially change the answer to "what is this for?"
- Is the user's target wording a transferable concept, or merely a local label?
- Could the target's intended role only become visible through how it is consumed, produced, configured, documented, automated, stored, or evolved?

Use this reflection to choose probes. Do not dump it as a checklist in the final answer.

## Context Expansion By Information Gain

Do not zoom out merely because more material exists.

Expand context only when the next probe could plausibly change at least one of these:

- what the target does or represents;
- what role it plays;
- what problem it solves;
- who or what it serves;
- how it is used;
- how its state or data behaves;
- which constraints shape it;
- which design trade-off it represents;
- whether an apparent capability is real, incidental, incomplete, or broader than it first looked;
- whether the target is meant to be reused, composed, generated, configured, distributed, operated, replaced, migrated, versioned, or evolved in a particular way;
- whether the target is primarily behavior, contract, policy, representation, automation, glue, generated output, or evidence of a larger design.

Use this test:

> If this surrounding evidence came out differently, would I explain the target differently?

If not, do not expand into it merely for completeness.

Prefer a few high-information probes over exhaustive traversal.

## Vocabulary Independence

The common use case is unfamiliarity. Therefore the target's own wording must not become the explanation.

Do not merely paraphrase names.

Bad:

`The FooCoordinator coordinates Foos and maintains Foo state.`

Better:

`This part gives one authority control over several independent participants so their state changes can be treated as one logical operation.`

Move through:

`local wording -> observed meaning / behavior -> neutral description -> broader concept -> purpose`

Rules:

- Explain behavior or role before relying on local labels.
- Prefer ordinary or transferable concepts over project-specific nouns.
- Introduce the local term after the concept when useful: `the project calls this ...`.
- Treat naming as evidence, not proof.
- If documentation repeats the same local wording, do not mistake repetition for independent understanding.
- For unfamiliar domain terms, explain them through inputs, outputs, relationships, state, constraints, consequences, and usage.
- The explanation should still make sense if the local names were changed tomorrow.

## Mechanism Versus Intent

Low-level mechanisms are usually **analysis evidence**, not automatically user-facing findings.

Examples:

- a retry count;
- a timeout value;
- a cache;
- persistence;
- an index;
- a queue;
- a serialization format;
- a lock;
- a validation step;
- a watcher;
- a fallback;
- a particular number of stages.

Do not report such details merely because they were found.

Instead ask what they imply:

- Why is retry needed at all?
- Why is this information stored at all?
- Why must it survive process lifetime?
- Why cache rather than recompute?
- Why is this field versioned?
- Why is failure retried here but rejected elsewhere?
- Why is state copied, normalized, retained, or discarded?
- What property does this mechanism protect or enable?

Only surface the mechanism when it is needed to support the explanation, distinguish alternatives, or clarify a materially relevant behavior.

The default output should emphasize **reason and consequence**, not inventory.

## Core Reasoning Dimensions

These are internal dimensions. They are not mandatory headings.

### Meaning / Behavior

Determine what the target actually does, declares, constrains, describes, or makes possible.

Depending on the target, useful questions include:

- What goes in and what comes out?
- What triggers or consumes it?
- What does it declare, select, constrain, transform, generate, persist, publish, or promise?
- What state or assumptions exist before and after?
- What happens on success, failure, or partial failure?
- What would become impossible, ambiguous, unsafe, inconsistent, or inconvenient if it did not exist?

Do not force runtime-behavior language onto material that is primarily descriptive or declarative. Interpret it according to what it contributes.

### Capabilities

Group low-level facts into useful statements of ability.

A capability answers:

> What can this design make happen, guarantee, prevent, preserve, expose, coordinate, describe, automate, or constrain?

Capabilities may belong to one target or emerge only from several pieces working together.

### Interaction / Usage

When sequencing or relationships matter, reconstruct the flow.

Ask:

- who or what initiates;
- which participants interact;
- what is passed or shared;
- what happens before and after;
- where validation, decision, mutation, publication, retry, fallback, handoff, or cleanup occurs;
- what another participant sees;
- where authority or lifecycle boundaries become visible.

Prefer a compact flow such as:

`input -> interpretation -> decision -> effect -> observable result`

rather than a list of filenames or symbols.

### Data / State Semantics

When the target creates, carries, stores, transforms, synchronizes, or interprets information, treat the data design itself as first-class evidence.

The primary question is not merely **how data is stored**, but **why this information needs to exist in this form and lifecycle at all**.

Ask:

- Why is this information represented or stored at all?
- What decision or behavior needs it later?
- Why must it outlive the current operation, process, session, or source input?
- Which parts are source-of-truth, derived, cached, transient, persisted, replicated, or reconstructable?
- Who owns the information and who may change it?
- What identities, keys, relationships, invariants, and boundaries exist, and why?
- How are absence, defaults, unknown values, invalid values, conflicts, or partial state represented?
- Why does data move between these representations or layers?
- Why is something serialized, encoded, encrypted, normalized, indexed, grouped, denormalized, copied, or retained?
- What intent is suggested by versioning, migration, retention, deletion, expiry, recovery, synchronization, or conflict handling?
- Which information is intentionally not stored, exposed, copied, or retained?

Details such as exact column counts, retry counts, field layouts, or storage syntax are normally internal evidence unless they materially explain the design intent.

### Problem / Design Pressure

Ask:

> What problem, constraint, risk, ambiguity, cost, or desired property would make this design worth having?

Keep alternative explanations alive when the evidence supports more than one.

### Design Idea

Abstract the local mechanism into a transferable concept.

Examples of the **level** of abstraction, not labels to search for:

- preserve a known-good state while evaluating replacement;
- separate decision authority from observers;
- make partial failure explicit instead of pretending atomicity;
- isolate one failure domain from another;
- delay irreversible work until validation succeeds;
- centralize ownership of a shared lifecycle;
- make implicit assumptions explicit;
- separate persisted representation from semantic meaning;
- keep one layer independent from another layer's failure;
- represent desired state separately from observed state;
- retain history to make change explainable or recoverable.

Do not apply familiar pattern names merely because the shape resembles them.

### Decision Logic / Trade-offs

Reconstruct the smallest defensible decision rationale visible in the material.

Ask:

- What does the design appear to favor?
- What cost, complexity, restriction, delay, duplication, or storage does it accept to get that property?
- Which simpler or more obvious alternative is not being used?
- Which failure mode is tolerated and which is prevented?
- Where does flexibility stop?
- What is deliberately made explicit?
- What is isolated, validated, delayed, duplicated, cached, persisted, versioned, indexed, normalized, or constrained, and why might that be useful?

Phrase this as design reasoning, not access to a developer's private chain of thought.

Use language such as:

- `The design appears to favor ... over ...`
- `This suggests a trade-off between ... and ...`
- `A plausible rationale is ...`
- `The shape makes sense if ... was an important constraint.`

### Practical Utility

Explain why the design matters in practice.

Distinguish when useful:

- **observed use**: surrounding evidence shows an actual use, consumer, workflow, integration, or outcome;
- **strongly implied use**: the practical effect follows closely from the observed design;
- **possible use**: plausible but not demonstrated.

Do not present possible use as known intent.

### Embedding / Role

Ask how the target participates in its surroundings without assuming a predefined technical category.

Questions include:

- What consumes, invokes, includes, configures, generates, publishes, wraps, documents, tests, stores, or depends on it?
- What does it consume or depend on?
- Which surrounding material establishes its intended role?
- Is it an endpoint of behavior or a building block inside something larger?
- Does context reveal a purpose invisible from the target alone?
- Does another part treat it as stable surface, internal detail, generated representation, policy, reusable mechanism, integration contract, state store, or something else?

Use whichever evidence answers these questions. Do not privilege code over other technical material by default.

### Historical Origin

Current material can support present design meaning without proving original motivation.

When historical origin matters, distinguish:

- what the design means now;
- what appears to have existed at introduction;
- what was added later as hardening, generalization, workaround, migration, compatibility, or evolution;
- what remains unknown.

Never silently convert present design meaning into historical fact.

### Relationships

When multiple topics or hypotheses exist, consider useful relationships such as:

- supports;
- contradicts;
- alternative explanation;
- depends on;
- part of;
- jointly explains;
- shares evidence with;
- narrows.

Do not create a graph for its own sake.

## Evidence Selection

Any material that can change the interpretation may be useful evidence.

Possible evidence includes, without priority:

- implementation;
- data shapes and stored representations;
- configuration;
- documentation and READMEs;
- examples;
- tests;
- comments;
- schemas and contracts;
- scripts;
- automation definitions;
- metadata;
- dependency declarations;
- generated material;
- usage sites;
- callers and consumers;
- surrounding workflows;
- history and diffs;
- neighboring technical material.

This list is intentionally non-hierarchical and non-exhaustive.

Choose evidence by information value, not file type.

### Evidence discipline

- Behavior and actual usage can outweigh naming.
- Data shape and persistence choices can reveal ownership, lifecycle, invariants, compatibility, and expected future use.
- Documentation can reveal intended role that local implementation does not show.
- Automation, metadata, or surrounding definitions can reveal lifecycle and embedding.
- Tests can expose intended semantics but may share the same source of intent as nearby code or docs.
- Historical evidence is stronger for historical-origin claims than present material alone.
- Missing expected evidence can narrow or weaken a hypothesis.
- Several repetitions of the same underlying statement are not independent confirmation.

## Hypothesis Discipline

For important interpretations, consider:

- supporting evidence;
- alternative explanations;
- expected evidence if the interpretation were true;
- missing expected evidence;
- evidence pointing another way;
- whether the claim concerns present meaning, design reasoning, practical use, or historical origin.

Use qualitative confidence only when it adds value:

- strong;
- moderate;
- weak.

Avoid fake numerical precision.

It is acceptable to conclude:

`The role is clear, but no defensible design rationale is visible yet.`

## Internal Workflow

This workflow is for reasoning. Do not use it as the default report structure.

### Step 1: Resolve the target

Use the user's request and immediate conversation context.

### Step 2: Reflect on scope

Identify the likely semantic boundary and which surrounding evidence could change the interpretation.

### Step 3: Establish local meaning

Understand what the target actually does or expresses without relying on its own vocabulary.

### Step 4: Follow high-information context

Inspect only surrounding evidence likely to change role, purpose, data/state interpretation, usage, trade-offs, or historical understanding.

### Step 5: Reconstruct interactions and information flow

Trace relevant flows across participants, state, and representations when the design lives in relationships rather than one item.

### Step 6: Abstract away from local wording

Restate the target in neutral semantic terms before naming broader design ideas.

### Step 7: Infer purpose and trade-offs

Generate bounded explanations for why the shape exists and compare alternatives when useful.

### Step 8: Test the interpretation

Look for supporting, contradictory, missing, or independent evidence.

### Step 9: Organize by the user's topic

Produce the answer around the thing or things the user wants to understand, not around Steps 1-8.

## Topic-Centric Output

The default response is an explanation, not an analysis report.

### One-topic request

If the user wants to understand one thing, keep the entire answer centered on that thing.

Use the target or a clearer neutral concept as the main heading.

A useful shape is:

`# <topic>`

**Essence:** 1-3 lines stating what it does or represents, its apparent purpose, and why that matters.

Then include only dimensions that add explanatory value, such as:

- what it does / means;
- how it is used or interacts;
- why relevant information is stored or state exists;
- how data/state affects the design;
- why it may be designed this way;
- trade-offs and alternatives;
- what it enables;
- where it fits in its surroundings;
- uncertainty or historical origin.

Do **not** analyze unrelated areas merely to make the response feel complete.

Surrounding material may be inspected extensively, but only findings that help explain the selected topic belong in its section.

### Multi-topic request

When the target contains several materially different things the user is trying to understand, organize the answer by those topics:

`# Topic A`

`# Topic B`

`# Topic C`

Put relevant behavior, data/state meaning, interactions, reasoning, utility, context, and uncertainty under each topic.

After the topic sections, add a short **Connections / shared design ideas** section only when relationships between topics add explanatory value.

### Broad target

For a broad target, begin with a 1-3 line **Essence** of the whole target.

Optionally provide a compact topic index when it helps navigation, then explain the important themes one by one.

Do not make a mandatory capability table, observation map, design-ID ledger, coverage matrix, or fixed multi-section report.

Coverage information belongs at the end only when breadth itself matters or meaningful areas were intentionally left unexamined.

### Essence rule

Every material topic should begin with a concise 1-3 line essence that can stand alone.

It should answer, in ordinary language:

- what this thing does or represents;
- the central purpose it appears to serve;
- the useful consequence or protected property.

A useful mental form is:

`This does / represents X so that Y becomes possible or Z is protected.`

Do not make this a rigid sentence template.

## Output Relevance Filter

Before including a discovered detail in the final answer, ask:

> Does this detail help the user understand what the target is for, how it behaves, why it is shaped this way, or what it enables?

If not, keep it as internal evidence and omit it.

Examples:

- `there are three retries` -> normally omit;
- `retry exists because temporary failure is treated as recoverable rather than terminal` -> potentially important;
- `the value is stored in JSON` -> normally omit;
- `the value is persisted because the design separates a durable desired state from the currently active state` -> important if supported;
- `there are six fields` -> normally omit;
- `one field exists solely to preserve compatibility across schema evolution` -> potentially important.

The goal is explanatory compression: retain the meaning, not every mechanism that led to it.

## Anti-Patterns

### Do not mirror the analysis process

The user asked to understand the target, not to read the sequence of investigative steps.

### Do not explain local wording with more local wording

If the explanation only makes sense to someone who already knows the project's glossary, it failed.

### Do not stop at the selected file or folder when its meaning depends on context

Scope is the question boundary. Follow high-value evidence outside it when necessary.

### Do not zoom out indiscriminately

Context expansion must earn its way by changing the interpretation.

### Do not privilege code

Configuration, documentation, data shape, generated output, automation, metadata, usage, or history may reveal intent more clearly than implementation code.

### Do not ignore data design

Storage, representation, ownership, lifecycle, migration, versioning, absence, conflict, synchronization, and deletion choices may be central design decisions.

### Do not inventory mechanisms as findings

Retries, caches, fields, tables, locks, files, stages, and formats matter only insofar as they reveal meaning, purpose, constraints, or trade-offs.

### Do not force a predefined artifact taxonomy

Discover the target's role from evidence rather than deciding in advance what kind of thing it is.

### Do not call every capability a user feature

Explain the actual observed or inferred role instead of promoting technical mechanisms into product claims.

### Do not pretend inferred reasoning is known thought

Reconstruct decision logic and trade-offs, not a verbatim private chain of thought.

### Do not write a grand story first

Broader concepts must emerge from supported local interpretations.

### Do not confuse present design with original motivation

Historical intent requires historical evidence.

## Optional Evidence Appendix

Only add a raw evidence appendix when:

- the user asks for full traceability;
- the interpretation is contested;
- many conclusions depend on subtle evidence;
- stable references would help follow-up work.

Place it after the human-readable explanation, not before it.

## Source Referencing

Prefer concrete references directly next to the claim they support.

Use the reference form available in the environment: path and symbol, line, section, key, record shape, workflow step, commit, or another precise locator.

Do not fabricate symbols, lines, or locations.

## Preferred Tone

Be investigative, explanatory, concept-oriented, and compact enough that the central idea remains visible.

Prefer language such as:

- `This appears to provide ...`
- `In neutral terms, this is ...`
- `The underlying idea appears to be ...`
- `This seems useful because ...`
- `The design appears to favor ... over ...`
- `The surrounding usage suggests ...`
- `The reason this state is retained appears to be ...`
- `Historical origin remains uncertain.`

Avoid making the answer sound like a forensic ledger unless the user asks for that style.

The skill succeeds when the reader understands the target better than its own names explain it: what it is really for, how it participates in a larger design, why relevant state/data/mechanisms exist, which trade-offs shaped it, and what those choices enable.

## Typical Invocation Phrases

- `[$analyze-design-intent] help me understand what is really behind this`
- `analyze the design intent of this target`
- `what is this actually for and why might it be built this way?`
- `look at this and its relevant surroundings and explain the underlying ideas`
- `why is this state stored at all and what design does that imply?`
- `compare these selected targets and explain the reasoning behind their different shapes`
- `trace how this is used and what its role appears to be`
- `analyze this broader area, but organize the answer by the actual topics you discover`
