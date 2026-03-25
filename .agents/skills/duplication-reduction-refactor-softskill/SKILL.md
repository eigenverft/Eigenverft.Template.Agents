---
name: duplication-reduction-refactor-softskill
description: Source-first refactoring guidance for reducing duplication through careful consolidation, shared helpers, reusable core flows, and removal of redundant layers.
---

# duplication-reduction-refactor-softskill

## Purpose

Use this softskill to review a real codebase and recommend concrete refactoring steps that reduce duplication, collapse repeated patterns, and introduce the right shared helpers or core modules.

This softskill is about making the codebase smaller, clearer, easier to maintain, and easier to extend by removing repeated code and repeated structural patterns.

Focus on:

- duplicated logic
- repeated flow shapes
- near-duplicate helpers
- repeated orchestration
- copy-paste variation points
- consolidation opportunities
- reusable shared core functions
- deleting redundant wrappers or layers
- reducing total code surface without reducing clarity

The output should not be abstract architecture talk.
It should read like practical reduction-oriented refactoring guidance a developer can act on.

## Core Goal

Make the codebase easier to change by reducing the number of places that implement the same idea.

That usually means improving:

- maintainability
- flexibility
- expansion safety
- consistency
- local reasoning
- discoverability
- change speed
- code volume to understand per feature

## Use This Softskill When

Use this softskill when the user wants help with:

- reducing duplication
- simplifying an overgrown codebase
- extracting shared helpers
- creating reusable core functions
- merging repeated patterns
- collapsing redundant layers
- shrinking boilerplate
- making a system easier to extend without copying more code
- finding what is written multiple times and simplifying it

## Do Not Use This Softskill When

Do not use this softskill for:

- isolated syntax fixes
- one-off bug fixes with no structural relevance
- performance tuning only
- purely cosmetic renaming
- framework migration planning without duplication or consolidation relevance

## Source First

Always base the advice on the actual source material.

Useful sources include:

- code files
- repo structure
- imports and dependencies
- build files
- package manifests
- project references
- entrypoints
- scripts and workflow definitions
- repeated call paths
- tests
- docs that describe system behavior

Do not give generic advice unless it clearly maps back to repeated patterns seen in the source.

## What To Look For

Look for source-level signs that the same behavior or structure is implemented more than once.

Examples:

- the same normalization or validation logic repeated across modules
- multiple helpers with nearly identical behavior and different names
- existing helpers that overlap heavily in inputs, outputs, and responsibility
- repeated path, config, manifest, or environment resolution
- controllers, commands, services, scripts, or jobs repeating the same orchestration steps
- duplicated error handling, retry, logging, or result wrapping
- repeated mapping logic between the same conceptual shapes
- multiple modules branching on the same cases in the same way
- pass-through abstractions that add files and indirection without reducing duplication
- copy-paste setup blocks for tools, loaders, clients, pipelines, or package scripts
- large utility folders that exist because the same code keeps being copied around

## What Good Looks Like

Prefer a structure where:

- shared code is truly shared and has a clear purpose
- feature-specific logic stays with the owning feature
- repeated flows are collapsed into one obvious implementation path where that is safe
- helper modules stay narrow and responsibility-based
- the same rule or transformation is implemented once
- adding a new case usually extends an existing shared path instead of copying a nearby file
- the total code surface shrinks without hiding behavior behind vague abstractions

## Consolidation Preference Order

When multiple reduction options are possible, generally prefer this order:

1. delete a useless wrapper or redundant layer
2. merge overlapping existing helpers
3. extend one existing helper in a narrow, coherent way
4. extract a new shared helper or core path
5. keep the code local for now if sharing would make ownership less clear

This is a preference order, not a rigid rule.
Use judgment based on clarity, ownership, and change safety.

## Extraction Decision Rule

This is mandatory.

Only recommend extracting a shared helper or core function when:

- the same behavior appears in two or more places
- the duplicated code has the same purpose and the same reason to change
- the shared abstraction would be easier to understand than the duplicates
- the resulting interface can stay narrow and explicit

Also take into account whether an existing helper could be extended or safely merged when helpers overlap heavily in purpose and behavior.

Keep code local when duplication is small, still evolving, or specific to one feature boundary and sharing would blur ownership more than it would help.

Do not recommend extraction when:

- the similarity is only superficial
- callers need meaningfully different behavior
- the abstraction would become a dumping ground
- local ownership would become less clear
- the shared version would need many flags, modes, or special cases

## Required Output Style

The output must be concrete and task-oriented.

It should answer:

- where the codebase is repeating itself
- which duplicates should become shared helpers or core functions
- which similar-looking code should stay local
- what should be merged, extracted, collapsed, or deleted first

## Required Output Shape

### 1. Highest-value duplication clusters

List the main repeated logic or repeated structure patterns seen in the source.

For each cluster, say whether it is:

- exact duplication
- near-duplicate logic
- repeated orchestration
- redundant abstraction

### 2. Reduction directions

Provide 2 or 3 realistic refactoring directions.

Each direction should say:

- what duplication it reduces
- what shared unit would be introduced, merged, or deleted
- why it fits the current source
- what tradeoff it has

### 3. First concrete steps for each direction

For every direction, give at least 3 concrete refactoring tasks.

Phrase them like TODOs or issue titles.

Examples:

- `Extract the repeated path discovery loop into one shared helper with explicit filter inputs.`
- `Merge duplicate config-loading branches into one shared loader and remove the pass-through wrapper.`
- `Delete the wrapper service that only renames calls to the real implementation.`
- `Move repeated normalization code into one shared module owned by the same responsibility.`
- `Collapse the duplicated command execution flow into one small orchestration function and keep feature-specific steps injected explicitly.`

### 4. Recommended direction

Pick one direction.

Choose the one with the best maintainability gain for the least abstraction risk.

### 5. Ordered reduction task list

This is the most important part.

Provide at least 5 ordered tasks.

Each task should say:

- what to extract, merge, delete, or collapse
- why it should happen now
- what duplicate surface area it removes
- what clarity or maintainability benefit it creates
- what old duplicate path or wrapper should be removed afterward when relevant

### 6. Watchouts

Mention only relevant risks, such as:

- extracting too early
- building a giant helpers module
- merging code that looks similar but changes for different reasons
- keeping a useless abstraction after introducing a shared core path
- introducing flags instead of making the shared unit truly coherent
- moving feature-owned code into shared space without a clear long-term owner
- extracting a shared path but leaving the old duplicate code in place beside it
- reducing line count while making behavior harder to follow

## Minimum Concreteness Rule

This is mandatory.

- Every direction must include at least 3 concrete refactoring actions.
- The recommended direction must include at least 5 ordered tasks.
- Tasks must be specific enough to copy into issues, TODOs, or a refactoring checklist.
- Use concrete verbs like:
  - extract
  - merge
  - collapse
  - delete
  - replace
  - isolate
  - centralize
  - deduplicate
  - inline
  - simplify
- Avoid vague advice like:
  - improve maintainability
  - clean up duplication
  - create shared helpers
  - simplify architecture
  unless followed by a concrete source-level action.

## Reduction-Oriented Refactoring Heuristics

Prefer refactors that improve:

### Repeated logic reduction

- merge identical or near-identical helper functions
- centralize repeated transformations, parsing, normalization, or validation
- replace repeated switch or branching logic with one clear ownership point when that logic truly matches

### Repeated orchestration reduction

- collapse command, controller, service, or script flows that repeat the same sequence with small variations
- extract stable shared flow steps and keep the varying behavior explicit
- prefer one small shared execution path over many near-duplicate handlers

### Shared helper quality

- create helpers only when they have a narrow responsibility
- prefer responsibility-based names over vague names like `utils`, `common`, or `manager`
- keep inputs and outputs explicit so the helper remains understandable
- take overlapping existing helpers into account before introducing a new one
- where it stays coherent and safe, merging similar helpers can be better than adding another sibling helper

### Shared core quality

- introduce a small shared core when multiple consumers need the same behavior
- centralize the stable part of the behavior and keep unstable feature-specific rules outside
- prefer one obvious source of truth over synchronized duplicate implementations
- keep the shared unit owned by a clear responsibility, not by a vague cross-cutting bucket

### Layer reduction

- delete pass-through wrappers that add indirection without behavior
- merge tiny layers when they split one responsibility across several files for no benefit
- inline abstractions that make navigation harder but do not reduce duplication
- after consolidating, remove obsolete wrappers, aliases, and dead call paths instead of keeping both versions around

### Safe reduction

- prefer deleting or merging before inventing a new framework
- prefer the smallest shared unit that removes meaningful duplication
- keep feature ownership visible after deduplication
- prefer proven reuse over speculative reuse

## Strong Rules

### Be source-based

Recommendations must visibly map to the code or structure reviewed.

### Prefer reduction over expansion

If duplication can be removed by merging or deleting something, prefer that before suggesting a new layer.

### Extract only proven common behavior

Do not create shared helpers for hypothetical future reuse.

### Prefer maintainability over cleverness

One clear shared function is better than a configurable abstraction maze.

### Keep ownership clear

Do not reduce duplication by hiding feature behavior inside a generic dumping ground.

### Finish the reduction

When recommending a consolidation, also identify what should be deleted, replaced, or rerouted so the old duplicate implementation does not linger.

## Good Task Examples

- `Merge the duplicated workspace-discovery routines into one shared function and keep only the variant-specific filter logic at call sites.`
- `Extract the repeated manifest-loading and validation sequence into one shared module with explicit error reporting inputs.`
- `Delete the intermediate wrapper that only forwards to the real helper with renamed parameters.`
- `Replace three near-identical formatting helpers with one responsibility-based formatter and move feature-only cases back to their owners.`
- `Collapse duplicated command setup code into one shared execution helper and inject the operation-specific action as a parameter.`
- `Centralize repeated path resolution into one small shared core function and remove the copied path-building blocks.`
- `Merge the duplicated mapping tables into one source of truth and update call sites to use it directly.`
- `Merge helper functions like ResolveWorkspaceRoot, FindWorkspaceRoot, and GetWorkspaceRoot into one helper if they resolve the same concept with only minor call-shape differences.`

## Bad Advice Examples

Do not produce advice like:

- `Create more abstractions.`
- `Use shared helpers.`
- `Clean up the duplicate code.`
- `Make the architecture more reusable.`
- `Introduce a generic framework for this area.`

Those are incomplete until translated into concrete source changes.

## Preferred Tone

Be practical, direct, and reduction-minded.

The response should feel like:

- here is what is repeated
- here is what should be shared and what should stay local
- here is the simplest useful consolidation direction
- here are the first refactoring tickets to create

## Typical Invocation Phrases

- `[$duplication-reduction-refactor-softskill] review this codebase for duplication and consolidation`
- `use the duplication reduction refactor softskill`
- `look at this repo and tell me what repeated code should become shared helpers`
- `show me how to simplify this codebase by merging repeated logic`
- `give me concrete refactoring tasks to reduce duplication and create the right shared core functions`
- `review this project and suggest what to extract, merge, and delete first`