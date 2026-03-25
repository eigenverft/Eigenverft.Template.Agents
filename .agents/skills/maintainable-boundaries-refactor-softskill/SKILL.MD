---
name: maintainable-boundaries-refactor-softskill
description: Source-first refactoring guidance for making a codebase more developer-friendly through clearer structure, naming, ordering, ownership, and boundaries.
---

# maintainable-boundaries-refactor-softskill

## Purpose

Use this softskill to review a real codebase and recommend concrete refactoring steps that make it easier to understand, maintain, and extend.

This softskill is about improving developer-friendliness in the architecture and code organization.

Focus on:

- clear separation of responsibilities
- better naming
- better file and module ordering
- simpler dependency direction
- clearer ownership
- maintainable structure
- extensible boundaries
- less “where does this belong?” confusion

The output should not be abstract architecture talk.
It should read like practical refactoring advice a developer can act on.

## Core Goal

Make the codebase easier for developers to work in.

That usually means improving:

- readability
- navigability
- module boundaries
- consistency
- local reasoning
- extension points
- change safety

## Use This Softskill When

Use this softskill when the user wants help with:

- refactoring structure
- codebase cleanup
- clearer architecture
- maintainability
- extensibility
- better naming
- folder or module organization
- reducing confusion in a growing codebase
- creating clearer boundaries between parts of the system

## Do Not Use This Softskill When

Do not use this softskill for:

- isolated syntax fixes
- one-off bug fixes with no structural relevance
- performance tuning only
- product redesign
- infrastructure planning without code structure relevance

## Source First

Always base the advice on the actual source material.

Useful sources include:

- code files
- repo structure
- package layout
- imports and dependencies
- build files
- project references
- public entrypoints
- tests
- docs that explain structure

Do not give generic advice unless it clearly maps back to something seen in the source.

## What To Look For

Look for source-level signs that the codebase is hard to work in.

Examples:

- unclear module ownership
- bad or vague naming
- oversized files or god modules
- fake separation with no real boundary
- shared folders used as dumping grounds
- feature code scattered across many places
- domain logic mixed with framework or I/O code
- dependency direction going the wrong way
- too many layers for the app size
- no obvious extension points
- too much cross-feature knowledge
- hard-to-find code paths
- repeated boilerplate caused by bad structure
- “common”, “misc”, “helpers”, “utils”, or “manager” folders that hide responsibility

## What Good Looks Like

Prefer a structure where:

- developers can quickly find the right place to change something
- names match responsibilities
- each module has a clear purpose
- dependencies mostly flow one way
- features or responsibilities are grouped coherently
- shared code is truly shared
- extension points are explicit
- moving or changing one part does not require understanding the whole system

## Required Output Style

The output must be concrete and task-oriented.

It should answer:

- what is structurally confusing today
- what direction would make this codebase easier to work in
- what exact refactoring tasks should happen first

## Required Output Shape

### 1. What is making this codebase hard to work in

List the main developer-facing structural problems seen in the source.

Keep it concrete.

Examples:

- “`common/` mixes HTTP helpers, billing formatting, and auth utilities.”
- “Feature code is split across `controllers`, `services`, `validators`, and `mappers` with no feature grouping.”
- “`UserManager` and `UserService` overlap responsibilities and hide where user logic belongs.”
- “Core code depends directly on infrastructure packages.”

### 2. Refactoring direction options

Provide 2 or 3 realistic directions.

Each direction should say:

- what it improves
- why it fits the current source
- what tradeoff it has

### 3. First concrete steps for each direction

For every direction, give at least 3 concrete refactoring tasks.

Phrase them like TODOs or issue titles.

Examples:

- “Move billing-specific formatting out of `common/format.ts` into `features/billing/format.ts`.”
- “Split `UserService` into `user_queries` and `user_commands` if it currently mixes read, write, and orchestration logic.”
- “Rename `helpers/` to responsibility-based modules or delete it by moving files into owning features.”
- “Create `features/orders/` and co-locate validation, mapping, and handlers for orders.”
- “Stop `core` from importing `infra/db`; introduce an interface and move the current implementation behind it.”

### 4. Recommended direction

Pick one direction.

Choose the one with the best maintainability gain for the least disruption.

### 5. Ordered refactoring task list

This is the most important part.

Provide at least 5 ordered tasks.

Each task should say:

- what to change
- why it comes now
- what clarity or boundary it improves

### 6. Watchouts

Mention only relevant risks, such as:

- creating churn without real boundary improvement
- renaming without responsibility changes
- moving code before ownership is clear
- introducing too many layers
- over-generalizing shared code

## Minimum Concreteness Rule

This is mandatory.

- Every direction must include at least 3 concrete refactoring actions.
- The recommended direction must include at least 5 ordered tasks.
- Tasks must be specific enough to copy into issues, TODOs, or a refactoring checklist.
- Use concrete verbs like:
  - move
  - split
  - extract
  - isolate
  - merge
  - rename
  - delete
  - group
  - introduce
  - replace
  - collapse
- Avoid vague advice like:
  - improve structure
  - revisit boundaries
  - clean up architecture
  - make naming better
  unless followed by a concrete source-level action.

## Developer-Friendly Refactoring Heuristics

Prefer refactors that improve:

### Naming clarity

- rename vague modules to responsibility-based names
- remove overloaded names like `common`, `manager`, `helpers`, `base`, `core` when they hide intent
- align file names with what the code actually owns

### Structural clarity

- group code by responsibility or feature
- keep related code close together
- reduce scattering across unrelated folders
- remove fake abstraction layers

### Boundary clarity

- make ownership explicit
- reduce cross-module leakage
- isolate external systems behind stable boundaries
- stop inward layers from depending on outward details

### Extension clarity

- create obvious places for new feature work
- avoid requiring edits in many unrelated modules for one change
- isolate unstable dependencies behind interfaces or adapters only where it helps

### Navigation clarity

- make the path from entrypoint to behavior easy to follow
- reduce “jumping around” across the codebase
- keep top-level structure understandable from the repo tree

## Strong Rules

### Be source-based

Recommendations must visibly map to the code or structure reviewed.

### Be task-oriented

Do not stop at observations.
Turn them into refactoring tasks.

### Prefer small useful changes

Do not default to a rewrite.
Start with the smallest changes that improve clarity.

### Prefer real boundaries over cosmetic cleanup

Renaming folders alone is not enough.
The goal is better ownership and simpler change paths.

### Prefer maintainability over purity

Do not force heavyweight architecture patterns unless the codebase clearly needs them.

## Good Task Examples

- “Split `shared/utils.ts` into separate modules and move feature-only helpers back into their owning feature folders.”
- “Extract order workflow orchestration out of the controller into a dedicated application-level module.”
- “Merge `UserManager` and `UserHelper` if they split the same responsibility without a real boundary.”
- “Create a single composition root for dependency wiring instead of spreading setup logic across entry files.”
- “Move validation logic out of UI components and into feature-level modules.”
- “Delete the pass-through abstraction around repository calls if it adds no behavior or boundary.”
- “Rename `common/` into responsibility-based modules, then shrink or remove it.”

## Bad Advice Examples

Do not produce advice like:

- “Improve maintainability.”
- “Refactor toward better boundaries.”
- “Use cleaner architecture.”
- “Review naming.”
- “Adopt a more modular design.”

Those are incomplete until translated into concrete source changes.

## Preferred Tone

Be practical, direct, and developer-friendly.

The response should feel like:

- here is what is structurally awkward
- here are the realistic cleanup directions
- here is the one I would choose
- here are the first refactoring tickets to create

## Typical Invocation Phrases

- `[$maintainable-boundaries-refactor-softskill] review this codebase for maintainability and boundaries`
- `use the developer-friendly architecture refactor softskill`
- `look at this repo and tell me how to restructure it for clarity`
- `give me concrete refactoring tasks for naming, separation, and maintainability`
- `review this project and suggest a cleaner developer-friendly structure`
- `show me the next refactors to make this codebase easier to extend`