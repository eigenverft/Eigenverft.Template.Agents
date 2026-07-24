---
name: work-on-handoff-files-softskill
description: Use when an agent should consume one or more implementation handoff files from AGENTS/HANDOFF/, make all remaining technical and optional-scope decisions, plan the work with the harness planning capability when available, implement and verify each handoff completely, move completed handoffs into AGENTS/HANDOFF/DONE/, and continue through the selected queue in order. This is an execution skill, not a review-only or plan-only skill.
---

# Work on Handoff Files Softskill

## Purpose

Use this skill as the implementation agent responsible for turning repository-local handoff files into completed, verified code changes.

The normal flow is:

1. Select the active handoff files.
2. Read and revalidate each handoff against the current repository.
3. Create an actionable implementation plan.
4. Resolve all remaining technical and optional-scope decisions.
5. Implement the accepted work.
6. Verify the complete outcome.
7. Move the completed handoff into `AGENTS/HANDOFF/DONE/`.
8. Continue with the next handoff.

Do not stop after analysis or planning when implementation is possible.

## Handoff Location and Naming

The default handoff directory is:

```text
AGENTS/HANDOFF/
```

Expected filenames follow:

```text
subagent-<subagenthash>-NN-<topic>.md
```

Examples:

```text
AGENTS/HANDOFF/subagent-7f3a91c2-01-domain-contracts.md
AGENTS/HANDOFF/subagent-7f3a91c2-02-storage-transition.md
AGENTS/HANDOFF/subagent-7f3a91c2-03-api-adaptation.md
```

Treat each file as a durable implementation input, not as executable truth. The current repository remains the source of truth.

Completed handoffs are stored under:

```text
AGENTS/HANDOFF/DONE/
```

Keep the original filename when moving a completed handoff. Files in `DONE/` are completed history and are not part of the default active queue.

## When To Use

Use this skill when:

- the user asks an agent to work on one or more handoff files
- a review has already produced implementation-near handoffs
- the desired result is actual implementation rather than another review
- the agent should make technical decisions instead of returning options for user lock-in
- several handoffs should be processed as an ordered queue
- the harness has a planning capability that should guide implementation

## When Not To Use

Do not use this skill when:

- the user requested review, synthesis, or planning only
- the handoff is being created rather than consumed
- the requested work must remain analysis-only
- the agent lacks permission to modify the repository
- the referenced handoff files do not exist and cannot be recovered
- the work requires an external business, legal, security, or production authorization that the agent cannot safely infer

## Selection Contract

Determine the work set in this order:

1. Use explicitly named handoff paths in the order supplied by the user.
2. If the user names a subagent hash, select matching `subagent-<hash>-*.md` files and sort them lexically.
3. If the user requests all handoffs or does not identify a narrower selection, select all top-level Markdown files matching the handoff naming convention in `AGENTS/HANDOFF/` and sort them lexically.

Ignore unrelated Markdown files and nested directories by default. In particular, do not select files already inside `AGENTS/HANDOFF/DONE/` unless the user explicitly asks to inspect or reprocess completed work.

Before building the actionable queue, detect superseded handoff redirects.

A redirect is a handoff file that contains the exact line:

```text
Status: superseded
```

A valid redirect must list one or more canonical handoff paths and state that it is not an implementation task. Resolve each canonical path first at its listed location and then, when it has already been completed, by the same filename under `AGENTS/HANDOFF/DONE/`.

For a valid redirect:

- do not plan or implement the redirect file
- read each canonical destination that is still active
- treat a canonical destination already present in `DONE/` as completed
- when the redirect was explicitly named, replace it in the queue with active canonical destinations in the same position
- when processing a broad selection, include each active canonical destination once and skip duplicate queue entries
- leave the redirect active until every canonical destination is completed
- after every canonical destination is completed or already in `DONE/`, move the redirect itself into `DONE/`
- record the redirect as superseded rather than as implementation work

If a redirect is malformed, points to a missing file, or still contains competing implementation instructions, stop and report the handoff-set problem instead of guessing.

Lexical sorting is the default because the filename places the hash and two-digit sequence before the topic. Reorder files only when a handoff or current source proves a dependency that requires a different order. Record that decision in the implementation plan.

## Repository Safety Gate

Before planning or editing:

- resolve the repository root
- read repository guidance, including `AGENTS.md`, relevant runbooks, and local instructions
- inspect the current branch, upstream, and working-tree state
- preserve staged, unstaged, untracked, and ignored local work
- fetch or synchronize remote state only when repository guidance or the user requests it
- never discard unrelated local changes
- never use destructive cleanup, hard reset, history rewrite, or force push as part of this skill

If existing local work overlaps the selected handoff, integrate with it when safe. Stop only when proceeding would overwrite or invalidate work that cannot be preserved.

## Read the Complete Handoff

Read every actionable selected handoff completely before implementing it. Read a superseded redirect completely only to resolve and validate its canonical destinations; never treat the redirect itself as implementation work.

For each handoff, identify:

- assignment and intended outcome
- scope and exclusions
- source originally inspected
- described current state
- recommended direction
- technical approach
- alternatives and recommendation
- affected boundaries
- compatibility constraints
- dependencies and ordering
- planning inputs
- risks and unresolved questions

Do not implement from headings, filenames, or excerpts alone.

## Revalidation Contract

Before relying on a handoff conclusion, inspect the current repository areas it references.

A handoff may be stale because source, configuration, dependencies, tests, or neighboring work changed after it was written. Therefore:

- confirm referenced files and symbols still exist
- confirm the described behavior still matches current source
- inspect related code needed to implement safely
- preserve current repository conventions
- adapt the approach when the original recommendation no longer fits
- do not repeat the entire original review when the handoff remains accurate

When the handoff and current source disagree, prefer current source and the user’s present objective. Record the adjusted decision in the plan and continue.

## Overlap and Remaining-Work Contract

Assume that selected handoffs may overlap with earlier handoffs, previous tasks, local uncommitted work, or changes already present in the current codebase.

Before planning each handoff, compare its requested outcome and affected boundaries against:

- the current implementation and tests
- changes already completed for earlier handoffs in the active queue
- relevant existing local changes
- behavior or infrastructure introduced by previous work
- current documentation and runbooks when they describe implemented behavior

Classify the handoff scope as:

1. **Not implemented** — the relevant outcome is still missing.
2. **Partially implemented** — some requirements or boundaries are already satisfied.
3. **Already implemented** — the intended outcome is present and consistent with current requirements.
4. **Superseded** — current code solves the underlying concern through a different, valid design.

The agent must plan and implement only the remaining delta.

When a handoff is partially implemented:

- remove already satisfied work from the active plan
- preserve valid existing behavior and design choices
- implement only missing, inconsistent, or insufficient parts
- avoid replacing working code merely to match the handoff’s suggested shape
- update tests or documentation only where the remaining delta requires it

When a handoff is already implemented or validly superseded:

- do not manufacture changes to make the handoff appear processed
- run the smallest meaningful verification that supports the conclusion
- record the handoff as completed with no implementation changes required
- continue to the next selected handoff

Overlap is not itself a blocker. Ask for user input only when overlapping work is materially incompatible and the correct resolution depends on an external decision that cannot be inferred safely.

## Mandatory Planning Behavior

Plan before editing each handoff.

If the agent harness exposes a dedicated plan function, planning tool, task tracker, or editable plan state, use it. Keep it updated as work progresses.

The plan must be an execution plan, not another broad review. It should include:

- the intended outcome
- the current-state classification: not implemented, partially implemented, already implemented, or superseded
- the remaining implementation delta after removing already satisfied scope
- the chosen technical direction
- decisions resolved from alternatives in the handoff
- every optional item and the decision to implement or reject it
- concrete repository areas to change
- compatibility and migration handling
- tests and verification
- documentation or runbook updates when knowledge changes
- dependencies on earlier or later handoffs
- the final move into `AGENTS/HANDOFF/DONE/` after completion

When processing multiple files, maintain one visible top-level queue with one active handoff at a time. Expand the active handoff into implementation steps, complete and verify it, then advance.

If no plan function exists, maintain a concise explicit plan in the current working context and execute it immediately. Do not create a separate plan Markdown file unless the user explicitly requests one.

Do not merely present the plan and stop. Planning is a required implementation step, not the final deliverable.

## Decision Authority

This mode authorizes the agent to make ordinary technical implementation decisions.

Resolve choices using this priority:

1. explicit user requirements
2. current repository behavior and compatibility obligations
3. repository-local guidance and conventions
4. the handoff’s recommended direction and evidence
5. the smallest coherent design that completes the outcome
6. maintainability, operability, and verification quality

When several credible approaches remain:

- compare them against current source and constraints
- choose one
- record the choice and rationale in the plan
- implement it

Do not ask the user to choose between normal technical options merely because more than one implementation is possible.

Do not defer decisions with vague wording such as “consider X or Y.” Select the best-supported direction and proceed.

Stop for user input only when the missing decision is genuinely external to the repository and cannot be safely inferred, such as:

- a product or business policy with materially different user-visible outcomes
- credentials, secrets, or inaccessible infrastructure
- destructive or irreversible production actions
- legal, privacy, or security authorization
- mutually incompatible explicit requirements
- risk of losing existing local work

When a safe reversible default exists, choose it instead of stopping.

## Optional Work Decision Contract

A handoff may contain optional changes, alternatives, follow-up suggestions, nice-to-have cleanup, or recommendations that are useful only under certain conditions.

Do not leave these items undecided and do not automatically implement all of them.

For every optional item, the agent must decide one of these outcomes:

1. **Implement now** — the item is useful, fits the handoff outcome, follows current repository direction, and can be completed and verified safely in this work set.
2. **Do not implement** — the item is unnecessary, speculative, already satisfied, outside the coherent scope, lower value than its cost or risk, or conflicts with the chosen direction.

Make ordinary optional-scope decisions without asking the user. Use current source, repository guidance, compatibility, maintenance cost, operational value, testability, and scope coherence as evidence.

Record each decision and a short concrete reason in the plan. For items accepted for implementation, include their work and verification in the active plan. For rejected items, do not create TODOs, placeholders, follow-up files, or incomplete scaffolding merely to preserve the suggestion.

An optional item blocks completion only when deciding it requires genuinely external product, business, legal, privacy, security, or irreversible production input. In that case, leave the handoff active and report the blocker.

A handoff may move to `DONE/` only after every optional item has been decided and every accepted optional item has been implemented and verified.

## One-Handoff-at-a-Time Rule

Implement one handoff at a time.

For the active handoff:

1. Revalidate it against current source and earlier completed work.
2. Detect overlap and classify how much remains.
3. Reduce the plan to the remaining delta.
4. Decide every required and optional item.
5. Implement the remaining coherent outcome and every accepted optional item, if any.
6. Update tests and documentation where required.
7. Verify the implemented, already-satisfied, or superseded outcome.
8. Mark all plan and optional-decision steps complete.
9. Move the handoff into `AGENTS/HANDOFF/DONE/`.
10. Continue to the next handoff.

Do not mix unrelated changes from later handoffs into the active one unless a shared prerequisite is necessary. If a prerequisite belongs to a later file, reorder the queue deliberately and record why.

Do not run parallel implementation agents against the same working tree unless the harness provides isolated worktrees and the user explicitly requests parallel execution.

## Implementation Contract

Implement the selected handoff rather than restating it.

The implementation may include, when required by the handoff:

- production source changes
- interface and contract changes
- configuration changes
- schemas and migrations
- tests
- workflows and deployment files
- documentation and runbooks
- compatibility adapters
- cleanup made obsolete by the completed change

Follow existing repository patterns unless the handoff and evidence justify a deliberate new boundary.

Prefer complete vertical outcomes over partial scaffolding. Do not leave TODO-only implementations, fake placeholders, dead branches, or unused abstractions merely to mirror the handoff structure.

Keep scope aligned with the active handoff. Make adjacent fixes only when they are necessary for correctness, verification, or removal of directly obsolete code.

## Handoff Is Input, Not a Checklist to Obey Blindly

The handoff may contain recommendations, alternatives, uncertainty, or outdated assumptions.

The agent must:

- use the handoff to avoid repeating expensive discovery
- preserve its useful evidence and constraints
- independently verify implementation-sensitive claims
- choose the final implementation shape
- correct stale or unsafe recommendations
- avoid implementing an option merely because it appears first

The implementation result, not literal adherence to every sentence, defines success.

## Test and Verification Contract

Verification is required for every completed handoff.

Use the smallest meaningful verification first, then broaden when risk warrants it:

- targeted unit or integration tests
- type checking or compilation
- lint or static analysis
- project build
- migration validation
- focused runtime checks
- broader test suites when shared contracts changed

Add or update tests for behavior changed by the handoff.

Do not claim completion when relevant verification fails because of the implementation.

If a verification failure is clearly pre-existing or unrelated:

- confirm that distinction with evidence
- record it accurately
- continue only when the active change is still safely verified by other relevant checks

Do not proceed to the next handoff while the active handoff leaves the repository in a knowingly broken state.

## Runbook and Documentation Contract

Apply the repository’s normal documentation rules during implementation.

When code, configuration, workflows, commands, architecture, interfaces, storage, authentication, infrastructure, or debugging knowledge changes, update the relevant runbook or documentation in the same work set.

Do not modify runbooks merely to record that they were checked. Leave them unchanged when no reusable knowledge changed.

## Handoff Completion and DONE Lifecycle

Treat the content of a handoff as immutable implementation input. Do not rewrite its recommendations or append completion notes during execution.

After a handoff meets every completion criterion, move the original file to:

```text
AGENTS/HANDOFF/DONE/<original-filename>
```

Lifecycle rules:

- create `AGENTS/HANDOFF/DONE/` when the first completed handoff needs it
- preserve the original filename
- move each handoff immediately after its own successful completion rather than waiting for the whole queue
- do not move a handoff while required work, optional decisions, accepted optional work, verification, or documentation remains open
- do not move a blocked or knowingly broken handoff
- move an already-implemented or validly superseded actionable handoff after the supporting verification succeeds
- move a superseded redirect only after all canonical destinations are completed or already in `DONE/`
- do not overwrite an existing destination file
- treat a destination collision as a blocker unless repository guidance provides an explicit safe rule
- do not delete the handoff after implementation; the move preserves it as completed history
- do not stage, commit, or push the move unless explicitly requested

The top-level `AGENTS/HANDOFF/` directory is the active queue. `AGENTS/HANDOFF/DONE/` is completed history.

## Git Contract

This skill changes working-tree files but does not automatically publish them.

Unless the user explicitly requests otherwise:

- do not commit
- do not push
- do not create or merge branches
- do not delete branches
- do not modify remote repository settings

Keep unrelated existing changes intact and report the final working-tree state accurately.

## Failure Handling

If an individual handoff cannot be completed:

- keep completed earlier handoffs in `DONE/`
- leave the blocked handoff in the active top-level directory
- stop before starting dependent later handoffs
- identify the exact blocker
- identify work already completed
- identify optional items already decided and those still blocked
- identify verification performed
- identify which handoffs remain unprocessed

Continue past a blocked handoff only when later files are demonstrably independent and proceeding cannot hide or worsen the blocker. Record the decision in the plan.

Do not silently skip a handoff.

## Completion Criteria

A handoff is complete only when:

- the current repository was inspected
- stale assumptions and overlap with existing work were reconciled
- already satisfied scope was removed instead of reimplemented
- a concrete remaining-delta plan was created and maintained
- ordinary technical decisions were resolved by the agent
- every optional item was explicitly accepted or rejected
- every accepted optional item was implemented
- the intended behavior was implemented or proven already satisfied or superseded
- relevant tests and documentation were updated
- meaningful verification passed
- no known implementation defect remains in scope
- the original handoff file was moved into `AGENTS/HANDOFF/DONE/`

A queue is complete only when every actionable selected handoff is in `DONE/` or explicitly reported as blocked. Valid superseded redirects are complete only when their canonical destinations were resolved and completed, and the redirect itself was moved into `DONE/`.

## Final Response

After execution, report concisely:

- processed handoff paths in execution order
- final `AGENTS/HANDOFF/DONE/` paths for completed handoffs
- superseded redirects and their canonical destinations
- completion, already-satisfied, superseded, or blocker status for each handoff
- important optional items accepted or rejected
- scope reduced because of overlap or existing implementation
- major technical decisions made
- implementation files changed
- tests and verification run with results
- active handoffs left unprocessed or blocked
- current Git status at a useful summary level

Do not paste the complete handoff contents or the full internal plan into the response unless the user asks for them.

## Typical Invocation Phrases

- `Use the work on handoff files softskill and implement all files in AGENTS/HANDOFF/.`
- `Work through these handoffs in order, plan each one, make the decisions, and implement them.`
- `Use the harness plan function, then complete every selected handoff.`
- `Implement the handoffs for hash 7f3a91c2 and verify each before continuing.`
- `Consume AGENTS/HANDOFF/subagent-7f3a91c2-01-domain-contracts.md and finish only the work that is not already present in the codebase.`
