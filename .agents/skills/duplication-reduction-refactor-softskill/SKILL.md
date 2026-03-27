---
name: duplication-reduction-refactor-softskill
description: Source-first refactoring guidance for reducing duplication through careful consolidation, shared helpers, reusable core flows, data-structure harmonization when sensible, and removal of redundant wrappers, layers, and unnecessary call chains.
---

# duplication-reduction-refactor-softskill

## Purpose

Use this softskill to review a real codebase and recommend concrete refactoring steps that reduce duplication through careful consolidation, shared helpers, reusable core flows, light data-structure harmonization where it is actually useful, and removal of redundant layers or call chains.

This softskill is about making the codebase smaller, clearer, easier to maintain, and easier to extend by removing repeated code, repeated structural patterns, unnecessary function-to-function chains, and needless shape fragmentation.

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
- analyzing common data structures in the app and harmonizing them when that is sensible
- reducing unnecessary function call chains, pass-through layers, and long internal forwarding paths
- deleting duplicated wrappers after repeated forwarding layers fail to add real meaning
- making minimal changes that align with the rest of the codebase instead of introducing a new style

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
- shape consistency for common application data where the source shows meaningful overlap
- navigation simplicity by shortening unnecessary call paths

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
- harmonizing repeated data structures across modules when that reduces friction
- removing needless function call chains or forwarding wrappers

## Do Not Use This Softskill When

Do not use this softskill for:

- isolated syntax fixes
- one-off bug fixes with no structural relevance
- performance tuning only
- purely cosmetic renaming
- framework migration planning without duplication or consolidation relevance
- forcing one universal data structure onto domains that clearly need different shapes
- flattening call paths when the extra layer carries real ownership, policy, validation, or boundary meaning

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
- repeated DTOs, view models, payloads, adapters, mappers, and serialized shapes
- function stacks that repeatedly hop through thin wrappers before reaching the real implementation

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
- multiple modules representing the same conceptual entity with mostly overlapping fields but slightly different names or omissions
- repeated shape padding logic where missing fields are added ad hoc instead of through one clear normalization path
- long call chains where functions mostly rename, forward, rewrap, or lightly translate the same inputs without adding clear responsibility
- repeated wrapper-on-wrapper call stacks where several thin functions only pass through arguments before the first function that actually owns behavior
- repeated behavior selection, repeated lookup, or repeated tiny data-shaping around the same shared helper
- an existing helper that is already close to the real shared core, but callers and child helpers still duplicate setup, normalization, or follow-on work around it

## What Good Looks Like

Prefer a structure where:

- shared code is truly shared and has a clear purpose
- feature-specific logic stays with the owning feature
- repeated flows are collapsed into one obvious implementation path where that is safe
- helper modules stay narrow and responsibility-based
- the same rule or transformation is implemented once
- adding a new case usually extends an existing shared path instead of copying a nearby file
- the total code surface shrinks without hiding behavior behind vague abstractions
- common data shapes are harmonized only where the source shows they are the same concept for the same reason
- optional or absent values are represented consistently when a shared structure exists, including using `null` where the surrounding system already treats that as the normal explicit empty value
- call paths are short enough that the real behavior is easy to find without jumping through many thin layers
- changes remain minimal and align with the surrounding code style and architecture
- one existing helper is strengthened when that collapses duplication both above and below it better than adding another shared layer
- consolidation deletes the old path instead of preserving both the old seam and the new shared helper

## Consolidation Preference Order

When multiple reduction options are possible, generally prefer this order:

1. delete a useless wrapper or redundant layer
2. merge overlapping existing helpers
3. extend one existing helper in a narrow, coherent way
4. harmonize repeated data shapes where the conceptual model is clearly shared
5. extract a new shared helper or core path
6. keep the code local for now if sharing would make ownership less clear

This is a preference order, not a rigid rule.
Use judgment based on clarity, ownership, and change safety.

## Extraction Decision Rule

This is mandatory.

Only recommend extracting a shared helper, shared shape normalizer, or core function when:

- the same behavior appears in two or more places
- the duplicated code has the same purpose and the same reason to change
- the shared abstraction would be easier to understand than the duplicates
- the resulting interface can stay narrow and explicit

Also take into account whether an existing helper could be extended or safely merged when helpers overlap heavily in purpose and behavior.

Only recommend harmonizing data structures when:

- two or more places represent the same conceptual entity or payload
- the fields substantially overlap
- the differences are incidental, historical, or adapter-level rather than domain-level
- one shared shape or normalization step would reduce repeated mapping or conditionals
- missing fields can be filled consistently and safely, including `null` where that is the clearest explicit empty value in the current codebase

Keep code local when duplication is small, still evolving, or specific to one feature boundary and sharing would blur ownership more than it would help.

Do not recommend extraction or harmonization when:

- the similarity is only superficial
- callers need meaningfully different behavior
- the abstraction would become a dumping ground
- local ownership would become less clear
- the shared version would need many flags, modes, or special cases
- the only way to unify shapes would be to create a fake one-size-fits-all model

Do not recommend shortening a call chain when:

- each layer owns a real responsibility boundary
- the intermediate function enforces policy, validation, tracing, security, or transaction behavior
- removing the layer would make ownership or boundaries less clear

## Minimal-Change Rule

This is mandatory.

Prefer the smallest coherent refactor that removes meaningful duplication or indirection.

That means:

- align with the current code style and module layout
- reuse existing helpers before inventing new categories
- prefer local merges and deletions over broad reorganizations
- avoid introducing a new abstraction family when a wrapper can simply be deleted
- avoid large type-system redesigns when a small shared normalizer or shape alias is enough
- keep the resulting code easy for current maintainers to recognize

## Collapse Rule

This is mandatory.

Prefer real seam collapse over responsibility relocation.

Do not treat a refactor as successful if it only moves repeated logic, repeated selection, or repeated tiny transforms into a new wrapper or generic-by-name helper.

Also do not analyze duplication only from the top-down caller perspective.
Inspect existing shared helpers as potential collapse points.

Ask whether:

- one existing helper already owns most of the real behavior
- callers repeat setup, normalization, branching, or parameter shaping around it
- child helpers mainly perform narrow follow-on work that belongs with that same responsibility
- strengthening that helper would remove more total code than introducing a new abstraction above it

Prefer enhancing an existing helper when that safely collapses duplication both above and below it.

Prefer incremental convergence over upfront universal design.
Route one concrete caller through the helper first, then expand the helper only as the next real caller requires.
Let the shared shape emerge from repeated adoption when that keeps the helper coherent and allows the old caller-specific path to be deleted after each step.

Success means:

- fewer total functions in the touched seam
- fewer call hops in the touched seam
- fewer repeated lookups, transforms, or wrapper objects in the touched seam
- old forwarding paths, duplicate prep code, or fragmented helper chains are removed afterward

## Required Output Style

The output must be concrete and task-oriented.

It should answer:

- where the codebase is repeating itself
- which duplicates should become shared helpers, shared normalizers, or core functions
- which similar-looking code should stay local
- what should be merged, extracted, harmonized, collapsed, shortened, or deleted first
- where function call chains should be reduced
- where data structures should stay different because there is no real one-size-fits-all model

## Required Output Shape

### 1. Highest-value duplication clusters

List the main repeated logic, repeated structure patterns, repeated data-shape variants, or repeated call-chain patterns seen in the source.

For each cluster, say whether it is:

- exact duplication
- near-duplicate logic
- repeated orchestration
- redundant abstraction
- duplicated shape normalization
- fragmented representation of the same conceptual data
- unnecessary function chain

### 2. Reduction directions

Provide 2 or 3 realistic refactoring directions.

Each direction should say:

- what duplication or indirection it reduces
- what shared unit would be introduced, merged, harmonized, collapsed, shortened, or deleted
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
- `Harmonize repeated entity payload shapes behind one narrow normalizer and fill absent optional fields with null where that is already the project convention.`
- `Inline the thin forwarding function and remove the extra call hop from the request flow.`
- `Strengthen the existing shared helper so callers stop duplicating setup around it and remove the child transform helpers that become redundant.`

### 4. Recommended direction

Pick one direction.

Choose the one with the best maintainability gain for the least abstraction risk.

Prefer the direction that removes duplicate logic or useless call depth with minimal structural churn.

### 5. Ordered reduction task list

This is the most important part.

Provide at least 5 ordered tasks.

Each task should say:

- what to extract, merge, harmonize, delete, shorten, or collapse
- why it should happen now
- what duplicate or indirect surface area it removes
- what clarity or maintainability benefit it creates
- what old duplicate path, wrapper, helper fragment, or fragmented shape should be removed afterward when relevant

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
- forcing unrelated data into one common structure
- filling missing values with `null` where the codebase actually distinguishes absence from explicit empty state
- shortening a call chain that was actually carrying a useful boundary
- mechanically flattening every call chain instead of only removing the repeated wrappers that add no real behavior
- adding a new shared wrapper when improving one existing helper would have collapsed more code

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
  - harmonize
  - normalize
  - reroute
  - shorten
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
- where one helper already owns most of the behavior, prefer strengthening it over adding a new wrapper above it
- prefer a helper shape proven by successive real caller adoption over an upfront design meant to fit every case immediately

### Shared core quality

- introduce a small shared core when multiple consumers need the same behavior
- centralize the stable part of the behavior and keep unstable feature-specific rules outside
- prefer one obvious source of truth over synchronized duplicate implementations
- keep the shared unit owned by a clear responsibility, not by a vague cross-cutting bucket

### Data-structure harmonization quality

- harmonize only proven common structures, not everything that looks similar
- prefer one shared source shape or one small normalization step over many ad hoc field-mapping blocks
- keep domain-specific variants local when they genuinely differ in meaning
- when a common shape is adopted, make optional empties explicit in one consistent way, including `null` only where the surrounding codebase already uses it coherently
- remove duplicate mapping code after the harmonized structure is introduced instead of leaving both shape paths active

### Layer reduction

- delete pass-through wrappers that add indirection without behavior
- delete duplicated wrappers when several layers keep forwarding to the same real implementation
- merge tiny layers when they split one responsibility across several files for no benefit
- inline abstractions that make navigation harder but do not reduce duplication
- shorten function chains when intermediate calls only forward, rename, or rewrap values
- do not force-collapse layers that still carry meaningful ownership, policy, or boundary behavior
- after consolidating, remove obsolete wrappers, aliases, and dead call paths instead of keeping both versions around

### Safe reduction

- prefer deleting or merging before inventing a new framework
- prefer the smallest shared unit that removes meaningful duplication
- keep feature ownership visible after deduplication
- prefer proven reuse over speculative reuse
- prefer a local, minimal change that fits the existing code over a broad theoretical cleanup

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

When recommending a consolidation, also identify what should be deleted, replaced, rerouted, or normalized so the old duplicate implementation does not linger.

### Do not force uniformity

Do not force one common data structure or one shared path onto different concepts just because they look related.

### Reduce call depth when it is cheap and real

Prefer shorter, clearer call paths when intermediate layers do not justify their existence.

### Prefer the first real owner

When a call chain looks like function -> function -> function -> real function, prefer rerouting callers closer to the first function that actually owns behavior, then delete the duplicated forwarding wrappers if they add no meaningful boundary.

### Prefer the best existing collapse point

When one helper is already close to the real shared core, prefer improving that helper over introducing another abstraction beside it, above it, or below it.

### Prefer progressive adoption

Prefer shared helpers that become the real core through repeated caller migration and deletion of old paths, rather than through an upfront attempt to design one abstraction that fits everything at once.

## Good Task Examples

- `Merge the duplicated workspace-discovery routines into one shared function and keep only the variant-specific filter logic at call sites.`
- `Extract the repeated manifest-loading and validation sequence into one shared module with explicit error reporting inputs.`
- `Delete the intermediate wrapper that only forwards to the real helper with renamed parameters.`
- `Replace three near-identical formatting helpers with one responsibility-based formatter and move feature-only cases back to their owners.`
- `Collapse duplicated command setup code into one shared execution helper and inject the operation-specific action as a parameter.`
- `Centralize repeated path resolution into one small shared core function and remove the copied path-building blocks.`
- `Merge the duplicated mapping tables into one source of truth and update call sites to use it directly.`
- `Merge helper functions like ResolveWorkspaceRoot, FindWorkspaceRoot, and GetWorkspaceRoot into one helper if they resolve the same concept with only minor call-shape differences.`
- `Harmonize repeated API response shapes behind one normalizer and set absent optional fields to null only where that matches the existing contract.`
- `Inline the three-step forwarding chain between controller, facade, and thin service wrapper where only one layer contains real behavior.`
- `Extend the existing shared helper to absorb repeated caller setup, reroute one concrete caller through it, and delete the child helpers that only perform fragmented follow-on transforms.`

## Bad Advice Examples

Do not produce advice like:

- `Create more abstractions.`
- `Use shared helpers.`
- `Clean up the duplicate code.`
- `Make the architecture more reusable.`
- `Introduce a generic framework for this area.`
- `Standardize all data structures.`
- `Add a common base model for everything.`
- `Split this into more layers.`

Those are incomplete until translated into concrete source changes.

## Preferred Tone

Be practical, direct, and reduction-minded.

The response should feel like:

- here is what is repeated
- here is what should be shared and what should stay local
- here is where common data structures make sense and where they do not
- here is which call chains should be shortened or deleted
- here is the simplest useful consolidation direction
- here are the first refactoring tickets to create

## Typical Invocation Phrases

- `[$duplication-reduction-refactor-softskill] review this codebase for duplication and consolidation`
- `use the duplication reduction refactor softskill`
- `look at this repo and tell me what repeated code should become shared helpers`
- `show me how to simplify this codebase by merging repeated logic`
- `give me concrete refactoring tasks to reduce duplication and create the right shared core functions`
- `review this project and suggest what to extract, merge, harmonize, shorten, and delete first`
- `analyze the app data structures and tell me which ones should be harmonized and which ones should stay local`
- `find thin wrappers and long function chains that can be collapsed with minimal changes`