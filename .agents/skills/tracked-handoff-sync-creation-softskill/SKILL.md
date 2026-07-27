---
name: tracked-handoff-sync-creation-softskill
description: Investigate the current repository and create only justified initial implementation handoffs under TRACKED_HANDOFFS/INITIAL/. Save each producing run first on its own remote tracked-handoffs/initial/run/<hash> branch, then integrate it append-only into tracked-handoffs/initial/current without updating the product branch. Recover open remote runs automatically, preserve local work, and return only created paths, NO_HANDOFFS_CREATED with the permitted Markdown explanation, or an exact blocker with the next safe action.
---

# Tracked Handoff Sync Creation Softskill

## Purpose

Use this skill when repository investigation should produce durable Initial Implementation Handoffs that remain available across product branches, independent sessions, local clones, and computers.

Many independent top-level agents may run this skill at the same time:

- on the same computer
- on different computers
- from `main`, development, test, feature, release, or detached product states
- directly or with explicitly requested subagents

Each producing run first saves its result on its own remote run branch. The result is then integrated into the shared current Initial collection.

Reconciliation, planning, implementation, completion, supersession, and later lifecycle interpretation are outside this Creation workflow.

## Core Model

Creation uses these remote branches:

```text
tracked-handoffs/initial/current
tracked-handoffs/initial/run/<12-character-hash>
```

The general phase pattern is:

```text
tracked-handoffs/<phase>/current
tracked-handoffs/<phase>/run/<hash>
```

This skill owns only the Initial phase:

```text
TRACKED_HANDOFFS/INITIAL/
tracked-handoffs/initial/current
tracked-handoffs/initial/run/*
```

A later Reconcile workflow may use separate branches such as:

```text
tracked-handoffs/reconciled/current
tracked-handoffs/reconciled/run/<hash>
```

This Creation skill must not create, update, delete, or reinterpret another phase's branches or files.

### Meaning of `current`

`tracked-handoffs/initial/current` means:

> The currently integrated and remotely published Initial Handoff collection.

It does not mean:

- reconciled
- approved
- final
- ready for implementation
- correct for every product branch
- completed or superseded

### Meaning of `run/<hash>`

`tracked-handoffs/initial/run/<hash>` means:

> One producing run's remotely saved Initial Handoff result, which may or may not already be integrated into `initial/current`.

The run branch protects the result from being left only in a local temporary worktree when integration into `current` is delayed or rejected.

## Hard Safety Rules

Always preserve these invariants:

- never force-push
- never switch, checkout, detach, pull, merge, rebase, reset, clean, commit, or push any existing product checkout or existing product worktree for this workflow
- never merge a tracked-handoff branch into a product branch
- never stage, commit, or push product code on a tracked-handoff branch
- never change a path outside `TRACKED_HANDOFFS/INITIAL/` on an Initial run or integration commit
- never edit, rename, move, or delete an already integrated Initial Handoff
- never overwrite unrelated local work
- never delete a remote run branch before its complete contribution is verified in `initial/current`
- never claim cross-computer availability before the relevant remote push is verified
- never create an empty run branch, empty result commit, or placeholder file

The current product checkout is read-only source evidence. All writable handoff work happens in isolated temporary worktrees.

Assume other agents may be using the same repository concurrently. Do not change the branch or HEAD of any checkout or worktree that already existed when this run started. Create only new, uniquely named temporary Handoff worktrees and local Handoff branches owned by this run. Removing or reusing another session's active worktree is forbidden.

## Investigation-Only Execution Boundary

This workflow investigates and writes Handoff documents. It does not execute product workflows merely to validate, initialize, or prepare the repository.

Do not run as part of this skill:

- product builds, tests, dependency or package restores, publishes, application launches, or benchmarks
- product or repository setup, bootstrap, initialization, maintenance, migration execution, formatting, generation, or repository-provided cleanup commands
- repository-provided one-time, startup, runbook, automation, or environment-preparation procedures
- a second product-source checkout or detached product worktree merely to run such commands

Existing source, tests, configuration, logs, history, and documented command results may be read as evidence. Do not execute them.

This boundary does not prohibit the fetches, temporary Handoff worktrees, Handoff commits, remote run publication, current integration, mirror refresh, or cleanup of this run's own Handoff artifacts explicitly required by this skill.

If the user explicitly requests command execution, treat it as separate work outside this Creation workflow. It must not be silently added as a verification step and must not change the product branch during this workflow.

## Remote Resolution

Choose the writable remote deterministically:

1. Use the writable remote configured as the current product branch's upstream remote when one exists.
2. Otherwise use writable `origin`.
3. Otherwise use the only remaining writable remote.
4. If several writable remotes remain and the repository identifies no primary remote, stop and report the ambiguity.

Fetch the selected remote before investigation and before every integration attempt. Do not update the product branch after fetching.

## Legacy Branch Blocker

The legacy remote branch:

```text
tracked-handoffs
```

cannot coexist with:

```text
tracked-handoffs/initial/current
tracked-handoffs/initial/run/<hash>
```

because Git ref names cannot be both a branch and a directory prefix.

If the selected remote still contains `tracked-handoffs`, stop before creating new work and report that the repository requires the one-time migration to `tracked-handoffs/initial/current`.

Do not delete or migrate the legacy remote branch automatically during an ordinary Creation run.

## Pure Storage Branch Contract

`tracked-handoffs/initial/current` and every Initial run branch are storage branches. Their trees may contain only:

```text
TRACKED_HANDOFFS/
└── INITIAL/
    └── initial-handoff-<hash>-NN-<topic>.md
```

They must not contain ordinary repository paths such as:

```text
src/
PROJECTNOTES/
.agents/
README.md
```

When `initial/current` does not yet exist, treat the Initial collection as empty. The first producing run uses an orphan result commit containing only its Initial Handoffs. After the run branch is verified remotely, integration creates `initial/current` from that result if no competing current branch appeared first.

Before using any fetched Initial branch, verify that its tree contains no path outside `TRACKED_HANDOFFS/INITIAL/`. A malformed branch is not safe input and must be reported precisely.

## Normal Workflow

Every top-level run follows five phases.

### Phase A: Synchronize the remote Initial phase

1. Resolve repository root, identity, current product branch or detached commit, exact source commit, upstream state, staged changes, unstaged changes, and relevant untracked state.
2. Preserve all product work and every pre-existing checkout or worktree without stash, reset, clean, rebase, merge, checkout, detach, or branch switching.
3. Resolve and fetch the writable remote.
4. Reject the legacy `tracked-handoffs` branch when present.
5. Fetch `tracked-handoffs/initial/current` when it exists.
6. Enumerate remote branches under `tracked-handoffs/initial/run/*`.
7. Validate and integrate every safely recoverable open remote run into `initial/current` before beginning the requested investigation.
8. Delete only remote run branches whose complete file contribution is verified byte-for-byte in `initial/current`.
9. Refresh the local visibility mirror from verified `initial/current` when the short mirror lock is available.

A later session therefore begins from every Initial Handoff already integrated before its fetch, and it also attempts to finish any remotely saved open runs left by earlier sessions.

### Phase B: Investigate in isolation

1. Generate one unique 12-character lowercase hexadecimal session token.
2. Create a session record under the Git common directory.
3. Create a new uniquely named temporary Handoff worktree and local Handoff branch owned by this run; do not repurpose or switch any existing checkout or worktree.
4. Base the temporary worktree on the latest fetched `initial/current` when it exists; otherwise use an empty orphan Initial storage tree.
5. Treat only `TRACKED_HANDOFFS/INITIAL/` as writable in that worktree.
6. Inspect the designated product checkout read-only without executing product, setup, maintenance, build, or test workflows.
7. Apply the Handoff Eligibility Gate to every possible finding.
8. Write only justified Initial Handoffs.

### Phase C: Save the producing result remotely

When one or more Handoffs were created:

1. Verify that the producing worktree contains no changed path outside `TRACKED_HANDOFFS/INITIAL/`.
2. Verify that all changes are additions; no integrated file may be modified, renamed, or deleted.
3. Create exactly one result commit beyond the run's recorded Initial base. For the first empty phase, the result may be one orphan root commit.
4. Push the result to:

```text
tracked-handoffs/initial/run/<handoff-hash>
```

5. Fetch that remote run branch and verify its commit and file contents.

This run push does not use the shared `current` integration path and does not require the local mirror lock. Different agents normally push different remote branch names and therefore do not block each other's first remote save.

After this verified push, the result is available from the remote to another computer even if integration into `initial/current` has not completed.

### Phase D: Integrate remote runs into `current`

After the own run is remotely saved, integrate it together with any other safely recoverable open runs:

1. Fetch the latest `initial/current` and all `initial/run/*` branches again.
2. Validate each run branch using the Remote Run Contract.
3. Build the append-only union on a fresh temporary integration branch based on the latest `initial/current`.
4. Apply only files contributed by validated open runs.
5. Preserve every file already in `initial/current` byte-for-byte.
6. Verify that the prospective integration commit changes only `TRACKED_HANDOFFS/INITIAL/` and contains additions only.
7. Push normally to `tracked-handoffs/initial/current`.
8. Never force-push.
9. Fetch and verify the resulting remote `initial/current` tree.
10. Delete each remote run branch only after all of its contributed files exist with identical content in verified `initial/current`.

### Phase E: Refresh visibility and return

1. Refresh the local `TRACKED_HANDOFFS/INITIAL/` visibility mirror from verified `initial/current` when the short mirror lock is available.
2. Do not stage or commit mirror changes on the product branch.
3. Clean local worktrees, local branches, and session records when they contain no unpublished value.
4. Return only the response allowed by the Return Contract.

## Remote Run Contract

A valid Initial run branch must:

- use `tracked-handoffs/initial/run/<12-character-lowercase-hex-hash>`
- contain only `TRACKED_HANDOFFS/INITIAL/`
- have a tip that is exactly one result commit above its first parent, or one orphan result commit for the first empty phase
- add files only
- never modify or delete an existing Initial Handoff from its base
- use the same run hash in its branch name, filenames, headings, and internal run references
- contain no secrets, credentials, private data, symlinks, or unsafe non-Markdown artifacts

For an ordinary run commit, inspect the tip against its first parent. For an orphan result, inspect the complete tree.

When a remote run is malformed:

- do not merge, cherry-pick, delete, or rewrite it silently
- continue integrating other independent valid runs when safe
- report the exact malformed branch and reason

## Open Remote Run Recovery

At the start and before final return, classify every remote `initial/run/*` branch:

### Already integrated

All files contributed by the run exist with identical content in `initial/current`.

Action:

- treat it as integrated
- delete the remote run branch when possible
- a failed branch deletion is cleanup debt, not a failure of the integrated Handoff result

### Valid and not yet integrated

The run is valid and contributes one or more files not yet present in `initial/current`.

Action:

- include it in the next append-only integration attempt

### Collision

A contributed path already exists in `initial/current` or another open run.

Action:

1. Read both files completely.
2. If content is identical, treat the run file as already integrated.
3. If the run adds no distinct Handoff value, keep the current file and classify the run contribution as a duplicate.
4. If it is a distinct Handoff, assign a fresh hash and filename to the still-unintegrated content, update its heading and internal hash references, publish a corrected replacement run branch, and integrate the replacement.
5. Delete the original run branch only after the corrected replacement is verified in `initial/current`.
6. Stop only when the collision cannot be classified safely.

Never rename or rewrite a file already present in `initial/current`.

## Integration Retry Contract

Updating `initial/current` is the remaining shared remote step. Git push rejection provides the concurrency control.

For a rejected `initial/current` push:

1. Fetch the newest `initial/current` and all open Initial run branches.
2. Rebuild the append-only union from the newest current tip.
3. Retry with increasing waits of approximately 10, 20, 30, 45, 60, 75, and 90 seconds.
4. Add a small random variation when practical so many agents do not retry in lockstep.
5. Stop after the eighth integration attempt and no more than about six minutes total.
6. Never force-push.

If integration still fails, the producing result must remain on its verified remote run branch. Return a concise pending-integration blocker that includes:

- the remote run branch
- the target `tracked-handoffs/initial/current`
- the exact integration failure
- that the Handoffs are already saved remotely
- that the same request may be retried after concurrent integrations settle
- that a later run on this or another computer will automatically retry the open remote run

Example shape:

```text
BLOCKED: The Handoffs are safely stored on tracked-handoffs/initial/run/a4c9e17d3b62 but could not yet be integrated into tracked-handoffs/initial/current after the bounded retries because the remote kept changing. Run the same request again after the concurrent integrations settle; the next run will recover the remote run automatically.
```

Do not report a remote-saved run as existing only locally.

## Local Temporary Artifacts and Recovery

Use 12-character lowercase hexadecimal identifiers.

Recommended local branch prefixes:

```text
tracked-handoff-initial-work/<hash>
tracked-handoff-initial-integrate/<session-hash>-NN
tracked-handoff-initial-recovery/<hash>
```

Store one local session record at:

```text
<git-common-dir>/tracked-handoff-initial-sessions/<session-hash>.json
```

Record at least:

- host identifier
- process identifier when available
- start and heartbeat times
- current phase
- source product branch and commit
- local worktree paths and branches
- intended remote run branch
- whether the remote run push was verified

Refresh the heartbeat at major phases and at least every five minutes during a long investigation.

At startup:

1. Inspect only session records and local artifacts using this skill's prefixes.
2. Leave an active session untouched.
3. For abandoned work not yet pushed as a remote run, recover safe Initial Handoffs into a new valid run and push them remotely before deleting the source.
4. If the remote run was already verified, prefer remote recovery and remove the obsolete local worktree when safe.
5. Never delete a local artifact containing unrelated changes or unreadable unpublished value.
6. Mere existence of an old local worktree is not a blocker when it does not prevent safe current work.

Recovery priority:

> Preserve unpublished Initial Handoffs, save them remotely, integrate everything safe, then clean obsolete local artifacts.

## Local Visibility Mirror

The product checkout may expose:

```text
TRACKED_HANDOFFS/INITIAL/
```

This directory is a human and agent visibility mirror of verified `tracked-handoffs/initial/current`.

It is not an authoring workspace for a producing run.

Rules:

- refresh it by copying files from verified `initial/current`
- do not switch, detach, or repurpose any existing product checkout or worktree to a tracked-handoff branch
- do not restore or merge a whole branch into the product checkout
- do not stage or commit mirror changes on the product branch
- do not modify `.gitignore`
- leave ordinary local notes outside recognized Initial Handoff files untouched
- open run branches are not copied into the mirror before integration

### Short mirror lock

Use one atomically created phase-specific lock directory only for short mirror reads, mirror writes, and related local cleanup:

```text
<git-common-dir>/tracked-handoff-initial-mirror.lock
```

This lock must not guard investigation, remote run pushes, or remote `current` integration.

When another active local session owns the mirror lock:

- do not read or write the mirror concurrently
- continue using verified remote branches
- retry briefly with bounded waits such as 1, 2, 4, 8, and 15 seconds
- if it remains busy, defer the mirror refresh; do not invalidate an already verified remote save or integration
- a later run rebuilds the mirror from `initial/current`

A stale mirror lock may be removed only after its recorded owner is safely classified as inactive.

## Local Unpublished Initial Handoffs

A person or earlier failed process may have placed a candidate directly under the local visibility mirror:

```text
TRACKED_HANDOFFS/INITIAL/
```

Deliberate placement there indicates intent to include a document in the shared Initial collection. Private drafts belong elsewhere.

When the short mirror lock is available:

1. Compare direct Markdown files with verified `initial/current` and open remote runs.
2. Read each local-only candidate.
3. Exclude normal notes that do not clearly present repository-specific implementation preparation.
4. Reject symlinks, unreadable files, non-Markdown files, secrets, credentials, or sensitive content.
5. For a valid local-only Initial Handoff, preserve the author's content, apply only minimum required normalization, assign a fresh hash when needed, create a recovery run branch, and push it remotely.
6. Do not rewrite or delete the mirror source before remote verification.
7. After successful integration, refresh the mirror from `initial/current`.

If the mirror lock is temporarily unavailable, defer this local-only scan rather than blocking remote investigation or remote publication.

## Concurrent Top-Level Sessions

Independent top-level sessions are not subagents of one parent.

Each session must have:

- its own session token
- its own local temporary worktree
- its own local work branch
- its own remote `tracked-handoffs/initial/run/<hash>` branch when it produces Handoffs
- hash-scoped filenames

They may investigate and push their own run branches concurrently.

They do not wait for a shared publication lock before remotely saving their results.

Only integration into `initial/current` is shared, and it is resolved through normal fetch, append-only rebuild, push rejection, and bounded retry.

## Direct Execution

Direct execution is the default.

1. Apply startup synchronization and remote run recovery.
2. Inspect the requested product source directly and read-only.
3. Generate one unique run hash.
4. Apply the Eligibility Gate.
5. Write complete Initial Handoffs for justified concerns.
6. Push one verified remote run branch when Handoffs exist.
7. Integrate open runs into `initial/current`.
8. Verify the remote current collection.
9. Refresh the local mirror when possible.
10. Return only the allowed response.

Do not launch subagents merely because a task is broad.

## Delegated Execution

Use subagents only when the user explicitly requests them.

The parent agent owns all Git synchronization and publication.

The parent must:

1. Complete startup synchronization and remote run recovery once.
2. Record the shared product source context.
3. Create a separate temporary writable output area for each subagent.
4. Assign a unique 12-character hash to each delegated producing run.
5. Give each subagent a bounded objective and minimum sufficient context.
6. Require read-only product-source inspection.
7. Forbid subagents from fetching, branching, committing, pushing, or writing outside their assigned temporary `TRACKED_HANDOFFS/INITIAL/` area.
8. Collect each successful subagent result.
9. Publish one remote `initial/run/<assigned-hash>` branch per successful delegated run.
10. Integrate all valid open runs into `initial/current`.
11. Return all newly integrated paths, or the top-level no-handoff response when none qualified.

Each subagent must return only created paths or exactly:

```text
NO_HANDOFFS_CREATED
```

Subagents do not add the explanatory second line. The parent applies the top-level Return Contract.

When more than one subagent is used for the same work set, each prompt must directly include all objective, scope, output, safety, filename, eligibility, and response rules. Do not rely on repository-local agent instructions to communicate essential constraints.

For such multi-subagent work, instruct each subagent to ignore repository-local `AGENTS.md` instructions for that delegated assignment and follow the parent-supplied objective, scope, constraints, output path, filename contract, and response contract instead. This does not override system instructions, user requirements, tool policy, security boundaries, or this skill.

## Handoff Eligibility Gate

Create an Initial Implementation Handoff only when current repository evidence supports concrete unfinished implementation work worth preserving for later reconciliation, planning, or implementation.

Before creating a file, answer all four questions:

1. What current behavior, defect, gap, duplication, risk, or required change creates real implementation work?
2. What concrete target direction is supported by repository evidence?
3. Is the concern substantial enough for a later planning agent to act on?
4. Does preserving this source-grounded Handoff add useful input for later reconciliation, planning, or implementation?

If any answer is no, uncertain, speculative, stylistic, or only optional cleanup, do not create the Handoff.

These are not sufficient reasons:

- the user asked for a review
- an alternative exists but is not recommended
- the current implementation is already appropriate
- the result is keep-as-is, no action, or insufficient evidence
- a possible future requirement may make a change useful
- the output format appears to expect a file

Repository comparison determines whether the supplied source still describes real unfinished implementation work. It is not a semantic reconciliation or deduplication pass over the Initial collection.

An existing Initial Handoff with similar, overlapping, or apparently sufficient coverage is not by itself a reason to return `NO_HANDOFFS_CREATED`. When the supplied source and current repository still confirm unfinished work, create a new source-grounded Initial Handoff and record relevant overlap, dependency, or prior Handoff paths where useful. Later Reconcile work decides which Initial Handoffs should be combined, retained, superseded, or discarded.

Only reuse already created paths instead of creating a new run when recovering the same producing run or completing its interrupted publication. Do not suppress a new independent producing run merely because another Initial Handoff discusses the same topic.

Finding nothing is valid.

## Markdown Source Validation

Treat every supplied or discovered Markdown document as advisory input, not proof that work remains open.

Compare it with current:

- source
- tests
- configuration
- manifests
- schemas and migrations
- workflows
- public contracts
- Git state

Create a Handoff only when the current repository still confirms concrete unfinished implementation work.

A source document may be historically useful even when no new Handoff is justified. Do not automatically edit or delete it.

## Handoff Hash and Filename Contract

Use one unique 12-character lowercase hexadecimal hash per direct or delegated producing run.

Do not use sequential placeholders, agent numbers, model names, repeated characters, or timestamps alone.

Use this filename pattern:

```text
initial-handoff-<handoffhash>-NN-<topic>.md
```

Examples:

```text
initial-handoff-7f3a91c2d4e6-01-domain-contracts.md
initial-handoff-7f3a91c2d4e6-02-storage-transition.md
```

Rules:

- `NN` begins at `01`
- use two digits
- order by dependency or implementation-preparation sequence
- use short lowercase hyphen-case topics
- every file in one run uses the same hash
- the branch name, filenames, headings, and internal run references use the same hash
- never overwrite an existing file

## Source Context Contract

Every Handoff must record:

- repository identity or normal remote identifier
- product branch name or detached source commit
- exact source commit at investigation time
- source publication state: remote, local-only, or unknown
- relevant working-tree state
- intended applicability: repository-wide, mainline-oriented, or branch/environment-specific

When evidence depends on uncommitted or unpushed product work:

- state the limitation
- identify relevant paths without copying secrets or large diffs
- preserve enough evidence for later revalidation
- do not claim that another computer can reproduce the exact source state
- do not create the Handoff when unavailable source details make the conclusion unsafe

## Topic Splitting and Ordering

Create separate Handoffs for materially different implementation boundaries, independent subsystems, foundation-versus-dependent work, or separately plannable data, API, UI, infrastructure, migration, rollout, or operational concerns.

Do not create one file per minor observation.

A useful fallback order is:

1. shared concepts and contracts
2. data and persistence foundations
3. core application behavior
4. external interfaces and integrations
5. UI or consumer adaptation
6. migration, rollout, observability, and cleanup

Repository-specific dependencies take precedence.

## Required Handoff Structure

Use this structure when relevant and omit empty sections:

```markdown
# Initial Implementation Handoff <handoffhash> NN: Topic

## Assignment
What the producing agent was asked to determine.

## Source context
Repository identity, product branch, exact source commit, publication state, working-tree state, and intended applicability.

## Intended outcome
The concrete implementation outcome this Handoff prepares for.

## Scope
Covered and excluded work.

## Source inspected
Repository-relative files, symbols, tests, configuration, workflows, and other evidence.

## Current state
How the relevant code currently works.

## Concrete direction
The recommended implementation-near target direction.

## Technical approach
Likely responsibility changes, contracts, data or control flow, integration seams, error handling, compatibility, and verification surfaces without writing the implementation or a full execution plan.

## Alternatives and recommendation
Realistic options, repository-specific trade-offs, and the recommended direction.

## Affected boundaries
Files, modules, APIs, schemas, configuration, tests, integrations, and ownership boundaries.

## Compatibility and constraints
Behavior and operational properties that must remain stable.

## Dependencies and ordering
Prerequisites and enabled follow-up work.

## Planning inputs
Decisions, acceptance concerns, and verification surfaces for a later planning agent.

## Risks and unresolved questions
Only genuine unresolved matters.
```

## Concreteness and Plain Language

Name actual repository-relative paths, symbols, responsibilities, data flows, configuration keys, contracts, tests, and observed behavior whenever practical.

Do not replace repository evidence with generic advice such as:

- improve separation of concerns
- make the architecture cleaner
- use a more scalable approach
- follow modern best practices

Use simple, direct language. Explain uncommon technical terms when they matter. Remove repeated framing and analysis narration.

## No-Implementation Contract

This skill must not:

- run product builds, tests, dependency or package restores, publishes, product applications, or product/repository setup, bootstrap, initialization, maintenance, migration execution, formatting, generation, or unrelated repository automation
- create a secondary product-source worktree for command execution or validation
- modify product source
- create migrations
- change product configuration behavior
- add product tests
- write production patches
- produce a complete coding-agent execution plan
- commit or push a product branch
- change any path outside `TRACKED_HANDOFFS/INITIAL/` on Initial storage branches

It may provide implementation-near technical direction inside Handoffs, but it stops before implementation.

## Return Contract

Path-only and `NO_HANDOFFS_CREATED` responses apply only when synchronization succeeded.

### One or more new Handoffs integrated

Return only repository-relative paths, one per line:

```text
TRACKED_HANDOFFS/INITIAL/initial-handoff-7f3a91c2d4e6-01-domain-contracts.md
TRACKED_HANDOFFS/INITIAL/initial-handoff-7f3a91c2d4e6-02-storage-transition.md
```

### No new Handoff qualifies

Return `NO_HANDOFFS_CREATED` on the first line.

Do not create an own remote run branch, result commit, or placeholder file for a no-Handoff result. Startup recovery and integration of older open remote runs must still complete as far as safely possible, and the local mirror should still be refreshed when available.

When the assignment was based on one or more supplied or named Markdown documents, add exactly one concise second line:

```text
NO_HANDOFFS_CREATED
The supplied Markdown was checked against the current repository and does not currently justify a separate unfinished implementation handoff; consider closing, archiving, or deleting it if it has no remaining documentation value.
```

This is only a recommendation. Do not modify the source document. Do not claim it is obsolete unless repository evidence specifically proves that.

### Remote run saved but current integration pending

Do not return created paths as fully synchronized.

Return one concise blocker stating that:

- the Handoffs are saved on the named remote run branch
- integration into `initial/current` remains pending
- the same request may be retried
- another computer can recover the open remote run

### Failure before remote run verification

Return:

- the intended Handoff path when known
- the exact blocker
- the preserved local worktree path when unpublished work remains
- the next safe user action

Do not claim the result was saved remotely.

## Failure Handling

Stop before investigation when:

- the writable remote or credentials are unavailable
- the legacy `tracked-handoffs` branch blocks the new namespace
- `initial/current` is malformed
- the already published Initial collection cannot be established safely

Continue safe work and report the specific remaining problem when one malformed or colliding open run does not prevent other valid runs from being integrated.

Preserve useful unpublished local work before cleanup.

After a verified remote run push, prefer remote recovery and do not keep unnecessary local worktrees merely because `current` integration is pending.

## Security and Privacy

Never publish:

- secrets
- credentials
- private keys
- tokens
- cookies
- private customer data
- sensitive personal data
- unsafe linked content
- large raw logs or data dumps

Name configuration keys and safe source locations without copying secret values.

## Completion Checklist

Before returning success, verify:

- no pre-existing product checkout or worktree was switched, detached, repurposed, committed, merged, rebased, reset, cleaned, or pushed
- no product build, test, dependency/package restore, publish, application, or product/repository setup, maintenance, migration, generation, formatting, or unrelated automation command was executed
- no secondary product-source worktree was created for command execution or validation
- the legacy branch does not block the Initial namespace
- `initial/current` and all consumed open runs contain only `TRACKED_HANDOFFS/INITIAL/`
- every producing result was first verified on its own remote run branch
- every returned path exists with identical content in verified `initial/current`
- no integrated Initial Handoff was overwritten, renamed, moved, or deleted
- no changed path outside `TRACKED_HANDOFFS/INITIAL/` was committed or pushed
- all safely recoverable open remote runs were processed
- integrated remote run branches were deleted when possible
- the local mirror was refreshed when the short mirror lock was available
- retained local artifacts still contain unpublished or unrelated work that must not be deleted
- the response follows the Return Contract exactly
