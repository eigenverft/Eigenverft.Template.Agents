---
name: tracked-handoff-sync-creation-softskill
description: Synchronize the repository-specific TRACKED_HANDOFFS collection through the dedicated tracked-handoffs branch without updating the current product branch, then investigate current source and create only concrete ordered hash-scoped implementation handoffs. Work directly by default and delegate only when the user explicitly requests subagents. Publish only TRACKED_HANDOFFS changes to the synchronization branch. On success return only created paths, or exactly NO_HANDOFFS_CREATED; on failure return the exact blocker.
---

# Tracked Handoff Sync Creation Softskill

## Purpose

Use this softskill to keep the complete tracked handoff collection synchronized across product branches and local clones before investigating the repository and preserving concrete implementation concerns.

Completion, supersession, and execution lifecycle remain intentionally outside this Create workflow.

## Intended operating model

This skill maintains one shared, append-only handoff collection for a repository.

The user may start independent Create sessions for different topics:

- on `main`, development, test, or feature branches
- on different computers
- in several concurrent sessions on the same computer
- directly or with explicitly requested subagents

Every top-level session must:

1. fetch the remote `tracked-handoffs` collection before investigating
2. begin with every handoff already published by earlier sessions
3. work in its own temporary local handoff worktree so other sessions cannot overwrite its files
4. create only new uniquely named handoffs for its own assigned topic
5. fetch the remote collection again before publishing
6. preserve handoffs published by other sessions while it was running
7. push the combined append-only result to remote `tracked-handoffs`
8. refresh the product-worktree visibility mirror from the successfully published remote state

A later session therefore sees every handoff that earlier sessions successfully pushed before that later session's initial synchronization. Results that are still being created or whose push failed are not yet globally synchronized.

The skill synchronizes only handoff documents. It never synchronizes, commits, or pushes product code merely because a handoff was created from that product state.

Core characteristics:

- the canonical published collection is the remote `tracked-handoffs` branch; the product worktree exposes a repository-root `TRACKED_HANDOFFS/` visibility mirror that may appear tracked, untracked, or ignored on that product branch and is not used as an authoring workspace
- the canonical transport is the dedicated `tracked-handoffs` branch
- synchronization and publication are part of every tracked handoff operation
- this Create workflow is append-only and never edits, moves, or deletes an existing published handoff; unpublished local handoffs may be normalized before their first publication
- every new handoff records the repository identity, product branch, exact source commit, source publication state, relevant working-tree state, and intended applicability
- only `TRACKED_HANDOFFS/` may be synchronized; no product path may be merged, restored, staged, committed, or pushed by this workflow

Default behavior:

- fetch the remote collection before investigation and start from every already published handoff
- create a unique temporary local worktree for this operation
- perform the requested investigation directly in the current product source
- write every justified handoff into the operation's temporary handoff collection
- fetch the remote collection again before publication
- publish the combined append-only handoff state to remote `tracked-handoffs`
- refresh the product-worktree visibility mirror from the successfully published remote state
- on success, return only created repository-relative paths, or exactly `NO_HANDOFFS_CREATED`

Delegated behavior applies only when the user explicitly asks to use one or more subagents. The parent synchronizes once and gives each subagent a separate temporary writable handoff worktree and local run branch. Subagents create files but do not publish. The parent collects the additions, fetches the remote collection again, publishes the combined result once, and refreshes the visibility mirror.

Do not launch subagents merely because an assignment is broad. A request such as `/tracked-handoff-sync-creation-softskill mach einen generellen Code-Review` runs directly unless the user also requests subagents.

An **Implementation Handoff** is:

- grounded in the actual repository source
- more concrete than a general review observation or recommendation
- close enough to implementation that a later planning agent can turn it into an implementation plan
- organized around one coherent, meaningful chunk of work
- explicit about likely code areas, contracts, dependencies, constraints, and unresolved decisions
- not itself a coding-agent implementation plan

The workflow is complete when synchronization succeeded and every justified finding was published as a tracked handoff, or when synchronization succeeded, no finding qualifies, and the result is exactly `NO_HANDOFFS_CREATED`.

Invoking this skill authorizes publication of justified handoffs without a separate approval prompt. Create remains responsible for evidence, eligibility, and content quality before publication. A later Reconcile skill may resolve overlap or contradiction between independently created handoffs; it is not a substitute for Create validation.

## Synchronization Contract

### Product worktree protection

Treat the current product worktree as the source state being investigated. Fetch remotes and inspect Git state as needed, but do not pull, merge, rebase, switch, reset, clean, configure an upstream for, commit, or push the current product branch as part of handoff synchronization or creation.

The tracked workflow may stage, commit, and push only repository-relative paths under:

```text
TRACKED_HANDOFFS/
```

It must not synchronize product code, runbooks, project notes, configuration, tests, `.gitignore`, or any other repository path.

### Canonical published collection

Use one repository-specific remote branch as the source of truth:

```text
<normal-writable-remote>/tracked-handoffs
```

Choose the writable synchronization remote deterministically:

1. Use the writable remote configured as the current product branch's upstream remote when one exists.
2. Otherwise use `origin` when it is writable.
3. Otherwise use the only remaining writable remote.
4. When several writable remotes remain and the repository does not identify one as primary, stop and report the ambiguity instead of guessing.

The synchronization branch transports only `TRACKED_HANDOFFS/`. Never merge that branch into `main`, development, test, feature, release, or another product branch. Never use a whole-branch checkout, restore, merge, or copy to synchronize the product worktree.

The branch may inherit ordinary repository history and files from its initial base commit. That does not authorize touching them: every commit created by this workflow must modify only `TRACKED_HANDOFFS/`, and all other paths in the synchronization worktree are out of scope.

The current product worktree may be on any normal branch, including `main`. Its root `TRACKED_HANDOFFS/` directory is only a local visibility mirror. The operation's writable collection lives in an operation-specific temporary worktree.

This Create workflow is append-only:

- it may add new uniquely named Markdown files directly under `TRACKED_HANDOFFS/`
- it must not edit, rename, move, or delete an existing published handoff
- it must not infer deletion from absence in one clone or branch
- it must not interpret completion, supersession, execution state, or lifecycle folders

### Required synchronization before investigation

Before inspecting the requested product topic:

1. Resolve the repository root and repository identity.
2. Record the current product branch or detached commit, exact source commit, upstream information, staged changes, unstaged changes, and relevant untracked state.
3. Preserve all current product work. Do not reset, clean, stash, rebase, merge, force-checkout, or otherwise rewrite it for handoff synchronization.
4. Fetch configured remotes so the remote `tracked-handoffs` state is current. Do not update the product branch after fetching.
5. Resolve the normal writable remote and whether its `tracked-handoffs` branch exists.
6. Generate a session token, create its local session record, and create a managed temporary local run branch and unique temporary worktree using the naming rules below. Base the worktree on the latest fetched `tracked-handoffs` state when that remote branch exists.
7. Use the temporary worktree as the only writable handoff collection for this operation. Do not create or edit handoffs in the product-worktree visibility mirror while investigating.
8. Before reading or refreshing the visibility mirror, inspect the publication lock. When no active owner may be writing the mirror, compare the visibility mirror and fetched remote collection using the local-file and append-only rules below. Preserve every recognized local handoff and every published handoff. When an active owner may be writing the mirror, do not read it; use the fetched remote as the stable published starting collection and defer mirror comparison until final publication.
9. If recognized handoffs were safely found only in the visibility mirror, publish them through the `Publication procedure` below in **intermediate mode** before beginning the new investigation. This pre-investigation publication is authorized by invocation of the skill and does not require another approval prompt. When an active local publisher prevents safe mirror access, continue from every globally published remote handoff and recover local-only handoffs after the lock becomes available before final publication instead of blocking the investigation unnecessarily.
10. When a published collection exists and no active lock owner may be writing the visibility mirror, refresh it from the fetched remote state for visibility without updating the product worktree index. When an active owner may be writing it, defer mirror refresh until final publication. When no synchronization branch and no handoff artifact exist yet, continue from a known empty collection and defer branch creation until an actual handoff exists.

If synchronization cannot establish the complete already-published collection, stop before investigation and report the exact blocker.

### Initial synchronization branch creation

When no local or remote `tracked-handoffs` branch exists:

- prepare the temporary run branch from the latest fetched commit of the remote default branch, not from an arbitrary local feature commit
- carry only repository-specific `TRACKED_HANDOFFS/` content into the first synchronization commit
- do not create placeholder files merely to initialize the branch
- create and push the branch only when an actual handoff artifact exists, including a recognized handoff found only in the visibility mirror or one created by the current operation
- configure the pushed branch normally without changing the current product branch

When no synchronization branch and no recognized handoff artifact exist, the complete synchronized starting collection is empty. Do not create or push an empty branch; continue the investigation and initialize the branch only if the run creates a justified handoff.

Invoking this skill authorizes this narrowly scoped branch creation and publication. It does not authorize a product-branch commit or push.

### Ignore handling

Do not modify `.gitignore` as part of this workflow. Check whether `TRACKED_HANDOFFS/` is ignored. When it is not ignored, stage normally. When an ignore rule hides it, use only an explicit path-scoped force-add for the intended handoff files in the temporary synchronization worktree when that is safe. Verify afterward that the synchronization commit contains no path outside `TRACKED_HANDOFFS/`.

A global or local ignore rule may make the visibility mirror less visible in `git status`; it does not change the remote collection's authority. The files must still remain readable in the filesystem and synchronizable by this skill.

### Local unpublished handoffs

A handoff may have been created manually or left local after an earlier push failure. Do not require it to have been produced by this skill. Deliberately placing a document that clearly presents itself as a handoff directly under `TRACKED_HANDOFFS/` indicates intent to include it in the published handoff collection; unfinished drafts that must remain private or local belong outside that directory.

For every readable Markdown file directly under `TRACKED_HANDOFFS/` that is not present on the fetched remote branch:

1. Read the file and decide whether it clearly describes repository-specific implementation work that should be preserved as a handoff.
2. Check for obvious secrets, credentials, private data, or unsafe linked content. Do not publish a symlink, unreadable file, non-Markdown file, or sensitive content.
3. When it is a handoff, copy it into the operation’s temporary handoff worktree. If its filename or heading does not follow the required filename and heading format, assign a fresh hash and valid filename there and update the unpublished heading and internal hash references consistently. Do not rewrite the visibility-mirror source file before publication succeeds.
4. Preserve the author’s content. In the temporary worktree, add or correct only the minimum structure needed for a usable handoff. Unknown branch, commit, or publication details must be marked `unknown`; never invent them.
5. If the file is clearly a normal note rather than a handoff, leave it local and exclude it from synchronization. It does not block the run.
6. Process every other safe local candidate first. Then stop only when a concrete safety problem exists or a filename collision cannot be resolved by the collision procedure below. Do not stop merely because the file was created manually.

A recognized local handoff is therefore a readable, safe Markdown document whose content clearly represents an implementation handoff, whether it was created by this skill, by another agent, or manually by a person.

### Append-only reconciliation rules

Compare handoffs by repository-relative path, filename, hash token, and content.

Apply these rules:

- a unique file present only on one valid side is preserved in the combined collection
- identical content at the same path is already synchronized
- when local and remote contain different content at the same path, read both before deciding: when the local file adds no distinct handoff value, keep the remote file and exclude the unpublished local duplicate from publication; otherwise assign the distinct unpublished handoff a fresh hash and filename and publish both; stop only when the collision cannot be classified safely
- similar topics or wording do not make files equivalent
- a missing file is not evidence of intentional deletion
- the union contains all distinct valid handoff files from the fetched remote, the recognized local handoffs, and this operation's new additions

A special hash-token race is handled before publication: when another operation has published the same token while this operation was still unpublished, assign a new token to this operation and update its unpublished filenames, headings, internal token references, and return paths consistently. Do not rename any published handoff.

### Managed temporary artifacts and startup recovery

Use 12-character lowercase hexadecimal identifiers with these roles:

- **Session token:** identifies one top-level operation and its local session record.
- **Handoff hash:** identifies the published handoff files produced by one direct or delegated investigation.
- **Artifact token:** names one temporary worktree and local branch.

For direct execution, use the same value for the session token, handoff hash, and parent artifact token. For delegated execution, keep one parent session token and use each subagent's assigned handoff hash as that subagent's artifact token. Retry artifacts reuse their related artifact token with a retry number suffix. Generate a separate artifact token only when two managed artifacts would otherwise receive the same name.

Use these local branch prefixes:

```text
tracked-handoff-run/<artifact-token>
tracked-handoff-retry/<artifact-token>-NN
```

Create one local session record at:

```text
<git-common-dir>/tracked-handoff-sessions/<session-token>.json
```

Record the host identifier, process identifier when available, start time, last heartbeat time, current phase, and all managed worktree paths and branch names owned by the top-level operation, including delegated and retry artifacts. Refresh the heartbeat at each major phase and at least every five minutes during a long investigation. A recorded operation is active when its process is verifiably running on the current host, or when process liveness cannot be checked but its heartbeat is newer than 15 minutes. It is verifiably abandoned when its recorded process on the current host is no longer running or its record is explicitly marked recovery-needed after a controlled failure. When process liveness cannot be checked and the heartbeat is older than 15 minutes, its lock lease may be recovered, but do not delete its worktree or branch based on age alone. Remove the session record after all managed artifacts are safely cleaned. When unpublished work must be retained, mark the record as recovery-needed and preserve its paths.

Never push these managed local branches or local session records. Only push the combined handoff state to remote `tracked-handoffs`.

At the beginning of each top-level run, inspect leftover session records and only the worktrees and local branches named by those records or using these prefixes. Never treat an unrelated worktree or branch as owned by this skill.

For each leftover managed worktree or branch:

1. Determine whether its recorded owner is still active. Leave an active operation untouched.
2. Read any unpublished files under its `TRACKED_HANDOFFS/` directory. Copy recognized handoffs into the current operation's temporary collection and publish them through the `Publication procedure` in **intermediate mode**; do not delete the source before publication is verified.
3. When a handoff is already published with identical content, treat its local copy as recovered.
4. When the operation is verifiably abandoned, the leftover contains no unpublished handoff value, and it has no changes outside `TRACKED_HANDOFFS/`, remove its worktree registration, worktree directory, local managed branch, and obsolete session record when safe. When abandonment is not verifiable, leave the artifacts in place and continue the current run if they do not block synchronization.
5. When it contains changes outside `TRACKED_HANDOFFS/`, do not delete or rewrite it. Recover any safe handoffs by copy, leave the remaining worktree in place, and continue the current run when that leftover does not prevent synchronization.
6. Process and publish every safe independent handoff before reporting a remaining recovery problem. A leftover is a blocker only when an unpublished handoff cannot be read or classified safely, or when it prevents the current operation from establishing or publishing the combined handoff collection. Mere existence of an old managed worktree or branch is not a blocker.

The recovery priority is: preserve unpublished handoffs first, synchronize everything safe, then report any unresolved concrete problem, and finally remove obsolete managed artifacts. Never delete useful unpublished work merely to obtain a clean local Git listing.

### Concurrent top-level sessions on one computer

Several independent skill sessions may investigate different topics concurrently on the same computer.

Each top-level session must have:

- its own uniquely named temporary worktree
- its own temporary local run branch
- its own operation hash token
- its own writable `TRACKED_HANDOFFS/` collection

No independent session may use the visibility mirror or one shared checked-out `tracked-handoffs` branch as a concurrent write location.

Only the short publication phase is serialized locally. Every worktree of the repository must use the same atomically created lock directory:

`<git-common-dir>/tracked-handoff-publication.lock`

Store owner metadata inside it containing at least the session token, host identifier, process identifier when available, acquisition time, last heartbeat time, managed worktree path, and managed branch name. Refresh the heartbeat before commit, before push, and before visibility-mirror refresh.

When the lock already exists:

1. Determine whether the owner is active, verifiably abandoned, or has an expired lock lease using the session-record rules above.
2. During initial synchronization, a verifiably active owner does not by itself block repository investigation. Do not wait solely for the lock. Use the latest fetched remote as the stable published collection and do not read or refresh the visibility mirror while the owner may be writing it. Continue the investigation, then fetch again and recover any local-only handoffs after the lock becomes available before final publication.
3. During an attempted intermediate or final publication, when the owner is active, check immediately and then at most five more times about 10 seconds apart, for no more than 60 seconds total. If it remains active, preserve the current operation's unpublished work and return the exact lock blocker instead of waiting indefinitely.
4. If the recorded process is on the current host and is verifiably no longer running, treat the lock as abandoned.
5. If process liveness cannot be checked, treat only the lock lease as abandoned when its heartbeat is older than 15 minutes and no matching managed operation can be shown to be active. Do not delete its worktree or branch based on age alone.
6. Before removing an abandoned or expired lock, inspect its recorded worktree using the startup-recovery rules above so unpublished handoffs are preserved. Then remove only the recoverable lock directory and continue.

A lock is a short local publication guard, not a permanent repository state. A stale lock should be recovered safely rather than leaving the repository blocked forever.

### Publication procedure

Use this procedure in one of two modes:

- **Intermediate mode:** publish handoffs found before the requested investigation or recovered while the run is still continuing. Keep the current operation's worktree, run branch, and session record after publication.
- **Final mode:** publish the complete result at the end of the run, then clean the current operation's managed artifacts when safe.

Both modes perform the same fetch, append-only combination, push, verification, mirror refresh, and lock release steps.

After the operation has zero or more unpublished handoffs in its temporary worktree:

1. Acquire the repository-wide local publication lock.
2. Fetch the remote `tracked-handoffs` branch again.
3. Rebuild the combined append-only collection from the latest remote files, recognized local handoffs, and this operation's unpublished additions.
4. Preserve all unique concurrent additions and resolve different same-path content using the collision procedure above.
5. Recheck this operation's hash tokens against the latest remote collection and repair only a still-unpublished token race as defined above.
6. Verify that staging and the prospective commit contain only paths under `TRACKED_HANDOFFS/`.
7. Commit the combined additions on this operation's temporary run branch only when there is an actual unpublished handoff change.
8. Push normally to the remote `tracked-handoffs` branch. Never force push.
9. If the push is rejected because another computer published first, fetch again and rebuild the attempt from the latest remote `tracked-handoffs` tip. Prefer a fresh uniquely named temporary retry branch and worktree, then reapply this operation's still-unpublished additions and recompute the append-only union. Make at most three safe publication attempts in total. Do not force push or rewrite the product branch. After the final failed attempt, preserve the unpublished work and report the exact failure.
10. After a successful push, fetch the remote branch again and verify that it contains this operation's new files and all concurrent files incorporated by the operation.
11. Refresh the recognized handoff files in the product-worktree visibility mirror from the verified remote state. Do not delete or overwrite ordinary local notes that were excluded from synchronization, and do not update or stage the product worktree index.
12. Verify that every published handoff in the remote collection is present with identical content in the visibility mirror. Extra ordinary local notes are allowed and are not part of this comparison.
13. Release the publication lock when owned by this operation. In intermediate mode, keep the current operation's worktree, run branch, and session record so the investigation can continue; remove only empty or fully recovered retry artifacts. In final mode, remove the current operation's temporary worktrees, local run or retry branches, and session record when they contain no unpublished handoff value and no changes outside `TRACKED_HANDOFFS/`. Preserve and report the temporary path when unpublished handoffs remain after failure.

When no new concern qualifies, do not create an empty commit. The required initial synchronization must still have succeeded. Previously recognized local handoffs may still require publication before returning `NO_HANDOFFS_CREATED`.

### Visibility mirror rules

The primary product-worktree `TRACKED_HANDOFFS/` directory exists for human and agent visibility only.

- read it when useful
- never use it as the operation's writable collection
- refresh recognized handoff files by file copy from the verified remote collection, not by switching branches or restoring the repository; leave excluded ordinary local notes untouched
- never stage or commit mirror changes on the product branch as part of this skill
- do not touch unrelated paths merely to make the product worktree appear clean
- expect the mirror to appear changed, untracked, or ignored relative to the current product branch

The remote `tracked-handoffs` branch remains the canonical transport regardless of the product branch's snapshot.

### Safety prohibitions

Never use the following for this workflow:

- force push
- `git reset --hard`
- `git clean`
- product-branch rebase or merge for handoff synchronization
- whole-branch merge of `tracked-handoffs` into a product branch
- whole-repository restore or checkout from the synchronization branch
- deletion, overwriting, or stashing of unrelated local work
- staging, committing, or pushing a path outside `TRACKED_HANDOFFS/`

### Synchronization blockers

Stop and report the exact blocker when:

- different content at the same repository-relative handoff path cannot be classified safely as a duplicate or a distinct handoff after both files were read
- the writable remote or required credentials are unavailable
- the remote keeps changing and three safe publication attempts cannot establish one published collection
- the current operation's required temporary worktree or run branch cannot be created, or a managed leftover prevents safe synchronization; inability to remove a harmless retained leftover alone is not a blocker
- the synchronization branch or prospective commit contains changes outside `TRACKED_HANDOFFS/`
- the local publication lock remains owned by a verifiably active operation after six checks over at most 60 seconds, or its ownership cannot be recovered safely
- source or repository state is too incomplete to support the requested handoff without unsafe assumptions

Do not claim cross-computer or cross-clone synchronization until the remote synchronization branch contains the final handoff state. Preserve safely written unpublished handoff content in its temporary worktree when publication fails, and report the temporary path.

## Execution Strategy

### Direct execution

Direct execution is the default.

1. Apply the Synchronization Contract.
2. Fetch the remote handoff collection and create a unique temporary local worktree from its latest published state; when no synchronization branch exists yet, use the initial empty-collection procedure defined above.
3. Confirm that this temporary collection contains every handoff already published before the operation starts.
4. Interpret the requested review or investigation scope.
5. Record the repository identity, current product branch, exact source commit, source publication state, relevant working-tree state, and intended applicability.
6. Inspect the current product branch and repository source directly.
7. Generate one short hash token for the logical handoff run.
8. Apply the Handoff Eligibility Gate to every finding.
9. Write the complete useful result for each justified concern into ordered append-only files in the temporary handoff worktree, including the required source context.
10. Fetch and incorporate the latest remote handoff additions again immediately before publication.
11. Run the `Publication procedure` in **final mode**: publish only the combined `TRACKED_HANDOFFS/` additions to remote `tracked-handoffs`, verify the published collection, refresh the visibility mirror, and clean the current operation's managed artifacts when safe.
12. On success, return only the created repository-relative paths, one per line, or exactly `NO_HANDOFFS_CREATED`.

A broad request such as a general code review is valid. Inspect the repository systematically, prioritize high-signal implementation concerns, and split justified findings by implementation boundary. Do not invent findings merely to make a broad review appear productive.

### Delegated execution

Use delegated execution only when the user explicitly requests a subagent or multiple subagents.

There is no separate named single-subagent mode:

- if the user asks for one subagent, launch one
- if the user asks for a specific number, launch that number
- if the user clearly asks for several subagents without a count, choose a small bounded number appropriate to the repository and task

The orchestrating agent must:

1. Fetch the remote handoff collection and create the parent's unique temporary local handoff worktree.
2. Confirm that the parent starts with every handoff already published before delegation.
3. Record the repository identity, current product branch, exact source commit, source publication state, relevant working-tree state, and intended applicability once for the delegated work set.
4. Define a bounded objective for each subagent.
5. Create a separate temporary writable handoff worktree and temporary local run branch for each subagent, all based on the same synchronized starting collection.
6. Brief each subagent with minimum sufficient context, including its exact temporary output path and the shared source context it must record.
7. Generate and assign a unique short hash token to each delegated run.
8. Include the eligibility, output-path, filename, source-context, no-handoff, no-product-implementation, and return contracts in every prompt.
9. Require each subagent to inspect the designated current product source read-only and derive its own findings; the separate handoff worktree is only its writable output area and must not replace the product source being reviewed.
10. Require each subagent not to fetch, publish, create synchronization branches, commit, push, modify any path outside its assigned temporary handoff output area, or manufacture a finding merely to complete the assignment.
11. Require each subagent to write justified handoffs only into its assigned temporary handoff worktree and return only paths, or exactly `NO_HANDOFFS_CREATED`.
12. Collect append-only additions from every successful subagent into the parent's temporary handoff worktree. When two unpublished additions use the same path, read both and apply the same collision procedure: exclude a duplicate from publication, assign a fresh hash and filename to a distinct handoff, or stop only when the collision cannot be classified safely.
13. Fetch the remote collection again, incorporate handoffs published by other operations, and run the `Publication procedure` in **final mode** once for the combined result.

When delegation is active, the orchestrating agent must not duplicate the delegated investigation merely to create an alternative answer in the parent context. Subagents are investigation workers in separate temporary handoff worktrees; the parent is the sole synchronization and publication owner.

### Concurrent independent sessions on one computer

This is different from subagents inside one request. Each independently started top-level skill session is the parent and publisher of its own task.

Several independent sessions may investigate different topics concurrently when all of these rules are followed:

- every session fetches the remote collection before investigating
- every session creates a unique temporary worktree and unique temporary local run branch; no two sessions check out or write through the same local synchronization branch
- every session writes new handoff files only in its own temporary worktree
- the primary product worktree's `TRACKED_HANDOFFS/` directory is a visibility mirror during investigation, not an authoring workspace or concurrent write location
- each session uses its own hash-scoped filenames, so normal additions do not share paths
- each short publication phase is serialized on that computer with one repository-local publication lock
- after acquiring the lock, the publishing session fetches remote `tracked-handoffs` again, incorporates everything another local session or computer already published, and only then pushes its own combined additions
- after a successful push, that session refreshes the visibility mirror from the published remote state
- a same-path content difference is resolved by comparing both files, assigning a fresh hash to a distinct unpublished handoff, or excluding an unpublished duplicate from publication; only an unresolved collision, failed push, unavailable remote, or unavailable publication lock is reported as a blocker

Therefore two sessions started at nearly the same time may begin from the same published collection, but the session that publishes second must include the first session's successfully pushed handoffs in its final published collection.

## When To Use

Use this softskill when:

- the user wants a repository review that produces durable implementation-preparation artifacts
- findings should survive beyond the current chat context
- a later agent will convert findings into plans or implementation work
- a broad review may produce several independently plannable concerns
- the user wants concrete preparation but not implementation yet
- the user explicitly asks one or more subagents to investigate independently

## When Not To Use

Do not use this softskill when:

- the user requested immediate implementation rather than preparation
- the task is a simple factual lookup with no repository-specific handoff value
- the requested artifact is already an implementation plan, issue set, patch, or code change
- no safe repository-local output channel exists
- repository-local analysis would expose secrets or sensitive data

## Delegated Briefing Rule

When subagents are used, brief them with **minimum sufficient context**.

Provide enough information to make each assignment safe and correctly scoped, but avoid steering the subagent toward the orchestrating agent's suspected diagnosis or preferred answer.

Normally provide only:

- the objective or concrete question
- the repository and permitted scope
- explicit exclusions
- hard compatibility requirements
- safety, environment, and policy constraints
- the assigned short handoff hash token
- the output location
- the filename contract
- the required handoff characteristics
- the required response contract

Normally omit:

- the orchestrating agent's suspected root cause
- its preferred architecture or solution
- conclusions from its own investigation
- long conversation history that can be rediscovered from the repository
- leading wording that asks the subagent to confirm a theory
- other subagents' findings

Minimal briefing means removing bias and irrelevant context, not hiding essential requirements.

## Multi-Subagent AGENTS.md Isolation Contract

This contract applies only when more than one subagent is used for the same work set.

Every subagent prompt in that work set must include an instruction equivalent to:

```text
For this assignment, ignore repository-local AGENTS.md instructions. Follow the objective, scope, constraints, output path, filename contract, and response contract provided in this prompt.
```

The orchestrating agent handles applicable repository setup once before delegation. Subagents inspect the designated product source read-only and write only to their separate temporary handoff output areas. Re-running repository-wide `AGENTS.md` or run-once flows independently can still mutate shared product state, cause conflicts, and repeat setup without improving the independent investigation.

When exactly one subagent is used, do not add the full `AGENTS.md` override. Normal read-only repository and harness guidance may still apply, but the delegated prompt's stricter rules remain mandatory: preserve the designated product source and write nothing outside the assigned temporary handoff output area.

The override is limited to repository-local `AGENTS.md` files. It does not override system instructions, harness policy, explicit user requirements, security boundaries, tool permissions, or this skill's no-implementation rules.

For multi-subagent work, do not rely on repository-local `AGENTS.md` to communicate essential constraints. Put the objective, scope, exclusions, compatibility constraints, safety constraints, output path, filename rules, and response contract directly into every subagent prompt.

## Assignment Framing

Make the assignment close to the implementation surface without turning it into an implementation plan.

Broad user requests are allowed. For example, `mach einen generellen Code-Review` means inspect the repository for concrete implementation concerns across its meaningful boundaries. Do not reject the request merely because it is broad.

For direct execution, derive a practical inspection scope from repository structure and available evidence.

For delegated execution, divide the work into bounded repository areas, responsibilities, or independent review perspectives. Avoid assigning several subagents the same leading diagnosis unless deliberate independent comparison is requested.

Useful concrete questions include:

- identify the current request path and the exact boundaries that would need to change
- compare existing implementations and recommend one concrete consolidation direction
- inspect the storage model and define target data and migration constraints
- review the authentication flow and identify enforcement and compatibility points
- determine which modules, interfaces, configuration keys, workflows, and tests are affected
- turn an observed failure mode into an implementation-near change handoff

Avoid replacing repository investigation with vague output such as:

- general best practices
- high-level thoughts
- metaphorical architecture descriptions
- unsupported modernization ideas
- speculative future improvements

Prefer actual repository paths, symbols, responsibilities, dependencies, and behavior.

## Handoff Eligibility Gate

An Implementation Handoff is justified only when repository evidence supports a concrete implementation concern worth preserving for a later planning or implementation step.

Before creating a file, the producing agent must be able to answer all of these questions:

1. What current behavior, defect, gap, duplication, risk, or required change creates real implementation work?
2. What concrete target direction is supported by repository evidence?
3. Is the concern substantial enough for a later planning agent to act on?
4. Would creating and processing this handoff add more value than leaving the current state unchanged?

If any answer is no, uncertain, purely speculative, or only a matter of taste, do not create that handoff.

The following are not sufficient reasons to create a handoff:

- the agent was asked to review an area
- an alternative exists but is not recommended
- the current implementation is already appropriate
- the only result is **keep as is**, **no action**, or **insufficient evidence**
- cleanup could be done opportunistically but is not worth planning now
- a possible future requirement might make a change useful later
- the agent wants to demonstrate that it inspected the repository
- the output format appears to expect at least one file

Finding nothing is a valid result. Quality and usefulness take precedence over file production.

When no concern passes this gate, the producing agent must:

- create no handoff files
- leave existing published handoff files unchanged; pre-existing unpublished local handoffs may still be normalized and published under the Local unpublished handoffs rules
- return exactly `NO_HANDOFFS_CREATED`
- add no explanation, summary, reviewed-area list, or fallback report

## Handoff Hash Contract

Every logical handoff-producing run must use a short filename-safe hash token.

Generate a 12-character lowercase hexadecimal token for every handoff run, including manually created handoffs that are normalized before publication. The token does not need to be cryptographically derived; it only needs practical uniqueness across concurrent and logically separate runs.

Examples:

```text
7f3a91c2d4e6
c84d2e6b51a9
91af07d4c3e2
```

Do not use repeated-character placeholders, sequential tokens, agent numbers, model names, timestamps alone, or long globally unique identifiers when a short hash is sufficient.

In direct execution, the current agent generates one token before writing handoffs for the logical review run.

Before writing, verify that no existing synchronized filename already uses that token. If it does, generate another token.

In delegated execution, the orchestrating agent generates and assigns a different token for every concurrent or logically separate subagent run. Each subagent must use the exact assigned token and must not invent, replace, shorten, expand, or normalize it.

Immediately before publication, compare the operation's tokens with the latest fetched remote collection. If another concurrent operation has published the same token, generate a replacement token and update only this operation's still-unpublished filenames, handoff headings, internal token references, and collected return paths before pushing. Never rename or rewrite an already published handoff.

## Source Context Contract

Every new tracked handoff must explain which product source state produced it. A global synchronized collection does not mean every recommendation applies equally to every branch.

Include this information in each handoff:

- repository identity or normal remote identifier when available
- product branch name, or detached source commit when no branch is active
- exact source commit at investigation time
- source publication state: available on the normal remote, local-only, or unknown
- relevant working-tree state: clean, dirty only in unrelated paths, or affected by relevant uncommitted paths
- intended applicability: repository-wide, mainline-oriented, or specific to a named feature or environment

Do not publish or modify product work merely to make the source context remotely available.

When relevant evidence depends on uncommitted or unpushed product changes:

- state that limitation explicitly
- identify the relevant paths without copying secrets or large diffs
- preserve enough current-state evidence in the handoff for later revalidation
- do not claim that another computer can reproduce the exact source state
- do not create the handoff when the conclusion cannot be supported safely without unavailable source details

A later Reconcile or Execute agent must treat this context as provenance, not as permanent truth, and revalidate the recommendation against the repository state it can actually inspect.

## Output and Synchronization Location Contract

Use exactly this repository-root location:

```text
TRACKED_HANDOFFS/
```

Apply these rules:

- resolve the repository root before synchronization or writing
- keep the canonical files stageable and trackable on the synchronization branch; the product-branch mirror may be tracked, untracked, or ignored; do not change `.gitignore` for this workflow
- synchronize and publish through the dedicated `tracked-handoffs` branch
- use a unique temporary worktree and temporary local run branch for each top-level operation instead of switching the primary product worktree
- synchronize, stage, commit, restore, and push only paths under `TRACKED_HANDOFFS/`
- never merge the synchronization branch into the current product branch
- in multi-subagent work, give every subagent a separate temporary writable output path and state that exact path directly in its prompt
- never overwrite an existing handoff; identical same-path content is already synchronized; for different same-path content, compare both files and either discard an unpublished duplicate, rename a distinct unpublished handoff with a fresh hash, or report an unresolved collision
- do not edit, rename, move, or delete an existing published handoff in this Create workflow; only unpublished local handoffs may be normalized before publication
- fetch and incorporate the latest remote append-only additions again immediately before publication
- push normally and never force push the synchronization branch
- if synchronization or publication cannot complete safely, return the exact blocker instead of claiming cross-branch or cross-clone success
- if no concern qualifies, create no new handoff file and return `NO_HANDOFFS_CREATED`; the required pre-work synchronization must still have succeeded

## Filename Contract

Use this exact filename pattern:

```text
handoff-<handoffhash>-NN-<topic>.md
```

Example using `7f3a91c2d4e6`:

```text
handoff-7f3a91c2d4e6-01-domain-contracts.md
handoff-7f3a91c2d4e6-02-storage-transition.md
handoff-7f3a91c2d4e6-03-api-compatibility.md
```

Rules:

- `<handoffhash>` is the exact short token for the producing run
- `NN` is a two-digit order number such as `01`, `02`, or `03`
- the order number appears immediately after the hash so filesystem sorting preserves sequence within the run
- `<topic>` is a short lowercase hyphen-case name for the actual implementation concern
- numbering starts at `01` for each hash-scoped run
- ordering follows dependency or implementation-preparation order
- every file from the same run uses the same token
- an existing file must never be overwritten
- never overwrite a filename collision; read both files, exclude an unpublished duplicate from publication, or assign a fresh hash and filename to a distinct unpublished handoff; report a blocker only when the collision cannot be classified safely


## Complete-Result Persistence Contract

When one or more concerns pass the Handoff Eligibility Gate, the handoff files are the complete useful result. The chat response is only a path handoff.

The producing agent must:

- preserve all useful source-based findings that pass the gate in the files
- avoid shortening the result merely to keep the response small
- move supporting detail into the appropriate handoff or a concise appendix inside it
- avoid leaving important reasoning only in the response
- avoid returning the complete report after the files were written successfully

When no concern qualifies, `NO_HANDOFFS_CREATED` is the complete successful response.

## Topic Splitting Contract

After at least one concern passes the gate, create multiple handoffs when the justified result contains:

- materially different implementation concerns
- independent subsystems or ownership boundaries
- a foundation followed by dependent work
- separate data, API, UI, infrastructure, migration, or rollout concerns
- more detail than one planning agent should process as one coherent work package

Split by implementation boundary or dependency, not arbitrary text length.

Each handoff should be:

- large enough to represent a meaningful chunk of future implementation work
- small enough for one planning session to understand and convert into a plan
- internally coherent
- independently nameable
- ordered relative to other handoffs from the same hash-scoped run

Do not create one file for every minor observation. Merge closely related findings that would naturally be planned and implemented together.

## Default Handoff Ordering

Use the repository's real dependency graph when available.

A useful fallback order is:

1. shared concepts, contracts, and compatibility decisions
2. data model, persistence, or state foundations
3. core application or domain behavior
4. external interfaces and integrations
5. UI, presentation, or consumer adaptation
6. migration, rollout, observability, and cleanup

The actual repository dependency order takes precedence.

## Handoff Size Standard

Create **medium to near-long** handoffs rather than tiny notes or exhaustive unbounded reports.

Include:

- enough source evidence to establish the current state
- enough concrete detail to define the implementation concern
- enough boundaries and constraints to prevent a later planning agent from repeating the full investigation
- enough dependency and risk information to order the work

Split a handoff when it contains multiple independently plannable outcomes or becomes difficult to navigate. Merge it when it contains only a few shallow observations without a substantial implementation boundary.

## Source-First Contract

Inspect the actual repository before writing conclusions.

Relevant evidence may include:

- source files
- project and package manifests
- entrypoints and composition roots
- configuration
- tests
- schemas and migrations
- workflows and deployment files
- existing runbooks and project notes
- public contracts and interfaces
- current Git state when relevant

Requirements:

- do not fill handoffs with generic practice disconnected from the repository
- make supporting source locations or observed behavior identifiable
- use repository-relative paths and symbol names whenever practical
- reduce confidence when source access is incomplete
- do not fill missing evidence with assumptions

## Required Handoff Structure

Use this structure unless the concern clearly requires a small variation:

```markdown
# Implementation Handoff <handoffhash> NN: Topic

## Assignment
What the producing agent was asked to determine.

## Source context
Repository identity, current product branch, exact source commit, source publication state, relevant working-tree state, and whether the concern is repository-wide or branch-specific.

## Intended outcome
The concrete implementation outcome this handoff prepares for.

## Scope
What is covered and what is intentionally excluded.

## Source inspected
Repository-relative files, symbols, configuration, tests, and other evidence.

## Current state
How the relevant code currently works and where responsibility lives.

## Concrete direction
The recommended target direction, stated in implementation-near terms.

## Technical approach
How the change could be realized technically: likely responsibility shifts, affected symbols and contracts, data or control flow, configuration or persistence changes, integration seams, error handling, and compatibility mechanics. Describe the implementation shape without writing the implementation or a step-by-step execution plan.

## Alternatives and recommendation
When more than one credible approach exists, compare realistic options, explain repository-specific trade-offs, recommend one, and state when another option would be preferable.

## Affected boundaries
Files, modules, APIs, schemas, configuration, tests, integrations, or ownership boundaries likely to matter.

## Compatibility and constraints
Behavior, contracts, environments, data, or operational properties that must be preserved.

## Dependencies and ordering
What must happen before this topic and what it enables afterward.

## Planning inputs
Concrete decisions, acceptance concerns, and verification surfaces the later planning agent must include.

## Risks and unresolved questions
Only genuine risks or decisions not safely derivable from the source.
```

Optional sections may include:

- `## Data and migration considerations`
- `## Interface examples`
- `## Candidate test surfaces`
- `## Rejected directions`
- `## Supporting evidence`

Do not add empty sections.

## Concreteness Contract

Handoffs must be concrete enough that a later planning agent can begin without repeating the entire investigation.

Good content resembles:

- `src/Orders/OrderController.cs` currently owns request mapping and payment orchestration; move orchestration behind an application-level boundary while preserving the controller contract.
- `PackageResolver` and `DepotResolver` duplicate version selection; consolidate the selection rule before changing acquisition behavior.
- The production route is configured in `ReverseProxySettings.Production.json`; development settings are outside the intended deployment change.

Avoid content such as:

- improve separation of concerns
- make the architecture cleaner
- use a more scalable approach
- consider modern best practices

Name actual files, symbols, responsibilities, data flows, contracts, and observed behavior whenever possible.

## Technical Direction Contract

Go beyond identifying affected areas and provide useful technical guidance about how the change could be realized.

When supported by repository evidence, describe:

- where responsibilities should remain, move, split, or consolidate
- which existing types, interfaces, methods, modules, configuration keys, schemas, or workflows are likely to change
- which new boundary or contract may be needed and why
- how request, control, event, state, or data flow should pass through affected components
- how compatibility, error handling, migration, rollout, or operational behavior could be preserved
- which tests or verification surfaces would prove the intended behavior

When multiple credible approaches exist:

1. name the realistic options
2. explain repository-specific advantages and disadvantages
3. recommend one concrete direction
4. explain why it best fits the observed code and constraints
5. state when another option would be preferable

Stop before implementation. Do not write production code, patches, complete method bodies, exact file-by-file edit instructions, shell commands, or a full ordered execution plan.

## Plain-Language Contract

Use simple, direct, easy-to-understand language.

- prefer short concrete sentences over dense abstract prose
- say what a component does, what should change, and why
- name real files, symbols, data, requests, events, and behavior
- explain uncommon technical terms when they first matter
- use headings and lists to make long findings easy to scan
- remove repeated framing, self-commentary, and analysis-process narration
- keep necessary technical detail while simplifying wording

Do not use metaphor, narrative framing, motivational language, or unnecessary meta terminology as a substitute for technical specificity.

## No-Product-Implementation Contract

The producing agent must not:

- modify product source
- create migrations
- change product configuration behavior
- add tests for future product behavior
- produce a complete coding-agent execution plan
- stage, commit, or push any path outside `TRACKED_HANDOFFS/`
- commit or push the current product branch as part of this workflow

Creating, synchronizing, committing, and publishing justified Markdown handoffs under `TRACKED_HANDOFFS/` on the dedicated `tracked-handoffs` branch are the only intended versioned repository-content mutations. Temporary worktrees, local managed branches, session records, and the publication lock are allowed only as uncommitted local coordination state defined by the Synchronization Contract. When no concern passes the gate, no new handoff content is intended, but pre-work synchronization may still update the local mirror or synchronization branch with previously existing handoff artifacts.

Read-only source inspection and the narrowly necessary Git operations defined by the Synchronization Contract are allowed.

## Delegated Prompt Contract

Every delegated prompt must carry instructions equivalent to the following. Add the concrete objective, scope, exclusions, and mandatory constraints before this contract without adding an unverified diagnosis.

```text
Handoff short hash token: <parent-supplied-handoffhash>
Repository identity: <parent-supplied-repository-identity>
Source product branch: <parent-supplied-branch>
Source commit: <parent-supplied-commit>
Source publication state: <parent-supplied-remote-availability>
Relevant working-tree state: <parent-supplied-state>
Intended applicability: <parent-supplied-applicability>

<When more than one subagent is used for this work set, insert this line; otherwise omit it:>
For this assignment, ignore repository-local AGENTS.md instructions. Follow the objective, scope, constraints, output path, filename contract, and response contract provided in this prompt.

Independently investigate the stated objective from repository source. Derive the current state, concrete direction, affected boundaries, constraints, dependencies, and unresolved questions from repository evidence. Do not assume or confirm an unstated diagnosis from the orchestrating agent.

Do not assume the assignment must produce a handoff. Create a handoff only for a concrete implementation concern supported by repository evidence, worth preserving for a later planning or implementation step, and having a recommended target direction. Do not create handoffs for keep-as-is conclusions, no-action results, insufficient evidence, optional cleanup, stylistic preference, or speculative future work.

When one or more concerns qualify, write the complete useful result into Implementation Handoff Markdown files under the exact temporary output path supplied by the parent. That path represents `TRACKED_HANDOFFS/` for this delegated run. Do not write into the product-worktree visibility mirror or another local agent-work directory.

Include a `Source context` section in every created handoff using the supplied repository identity, branch, commit, publication, working-tree, and applicability information. Treat it as provenance rather than permanent truth.

When no concern qualifies, create no files and return exactly:
NO_HANDOFFS_CREATED

Use exactly this filename pattern:
handoff-<handoffhash>-NN-<topic>.md

Use the exact short hash token supplied above in every filename. Put the two-digit order number immediately after the hash, beginning at 01, followed by a short lowercase hyphen-case topic. Never overwrite an existing file.

Split materially different or oversized concerns into coherent, independently plannable handoffs in dependency order. Each handoff must be medium to near-long: not a tiny note, not an unbounded research dump, and not a full implementation plan.

Ground every important conclusion in actual repository evidence. Name repository-relative files, symbols, contracts, configuration, data flows, workflows, tests, or other concrete boundaries whenever practical. Write in simple, direct language. Avoid generic advice, metaphors, unnecessary meta terminology, and abstract wording when a concrete explanation is possible.

Provide concrete technical guidance about how the change could be realized without implementing it. Compare credible alternatives, recommend one direction, and state when another option would be preferable. Do not write production code, patches, exact edit instructions, shell commands, or a full ordered execution plan.

Do not modify any file outside the exact temporary handoff output path assigned by the parent, including product code, configuration, migrations, tests, agent instructions, runbooks, or project notes. Do not perform Git synchronization, branch creation, staging, commits, or pushes; the parent agent exclusively owns synchronization and publication.

After successfully writing one or more files into the assigned parent-prepared temporary handoff worktree, return only their intended repository-relative `TRACKED_HANDOFFS/...` paths, one path per line. The parent agent will collect, publish, verify, and mirror them. When no handoff qualifies, return only NO_HANDOFFS_CREATED. Do not return summaries, topic descriptions, ordering commentary, excerpts, reviewed-area lists, or a report in your response.
```

## Return Contract

The path-only response and `NO_HANDOFFS_CREATED` apply only to successful runs. When synchronization or publication fails, return a short blocker message under the Failure Handling contract instead.

### Direct execution

When one or more handoffs are created, return only their repository-relative paths, one per line:

```text
TRACKED_HANDOFFS/handoff-7f3a91c2d4e6-01-domain-contracts.md
TRACKED_HANDOFFS/handoff-7f3a91c2d4e6-02-storage-transition.md
TRACKED_HANDOFFS/handoff-7f3a91c2d4e6-03-api-adaptation.md
```

When none qualify, return exactly:

`NO_HANDOFFS_CREATED`

### Delegated execution

Each successful subagent must return only created paths or exactly `NO_HANDOFFS_CREATED`.

After all requested subagents complete:

- if at least one handoff path exists, return only all created repository-relative paths, one per line
- omit individual `NO_HANDOFFS_CREATED` responses when paths exist
- if no subagent created a handoff, return only `NO_HANDOFFS_CREATED`

Do not paste complete handoff contents or no-finding explanations into the main conversation unless the user explicitly asks to read them there.

## Failure Handling

If synchronization cannot complete before investigation:

- do not continue from a knowingly incomplete handoff collection
- do not modify product source or unrelated repository paths
- return the exact synchronization blocker and the affected synchronization branch or path

If a justified handoff cannot be written or published:

- do not claim it was synchronized or saved remotely
- return the intended path and exact blocker
- preserve the safely written local handoff content in its temporary worktree when possible without overwriting another file, and report that temporary path
- include only the minimum fallback detail needed to avoid losing all useful work

On every controlled exit, including failure:

- release the publication lock when it is owned by the current operation
- remove empty or fully recovered retry worktrees and branches
- remove the current run worktree, branch, and session record only when no unpublished handoff value remains and no changes outside `TRACKED_HANDOFFS/` would be lost
- when unpublished work remains, mark the session record as recovery-needed and preserve the exact worktree and branch paths for the next run

An abrupt process or machine failure may prevent this cleanup. The next top-level run must then apply the managed startup-recovery and abandoned-lock rules before treating the leftovers as blockers.

In delegated execution, the parent agent remains responsible for resolving safe file placement and publication. Do not ask subagents to perform independent Git recovery or publication.

When source access is incomplete:

- state the missing source inside a handoff when a handoff can still be justified and published safely
- reduce confidence
- avoid filling gaps with generic assumptions

A broad review with no justified finding still returns `NO_HANDOFFS_CREATED`, but only after the tracked collection was synchronized successfully.

## Security and Privacy Contract

Never place secrets, credentials, private keys, tokens, cookies, private customer data, or sensitive personal data into a handoff or synchronization commit.

Document secret sources and configuration key names without copying secret values. Do not include large raw logs or data dumps. Summarize technically relevant evidence and point to the safe source location.

## Quality Checklist

Before direct execution:

- the Synchronization Contract was applied
- the synchronization remote and `tracked-handoffs` branch were resolved
- the current product branch and all unrelated local work are preserved
- every already-published remote handoff was available before repository investigation; safe local-only recovery was completed before investigation when the publication lock was available, or was explicitly deferred until final publication while another active local publisher owned the lock
- the repository identity, current product branch, exact source commit, source publication state, relevant working-tree state, and intended applicability were recorded
- synchronization did not interpret or change lifecycle state reserved for later skills
- the requested scope is understood
- broad review scope has been mapped to practical repository inspection
- one unique handoff hash was generated
- output location and filename pattern are known
- eligibility, source-first, concreteness, technical-direction, plain-language, and no-product-implementation rules are active

Before delegated execution:

- the user explicitly requested one or more subagents
- the parent completed synchronization before delegation
- each assignment is bounded and concrete
- each prompt contains only minimum sufficient context
- when more than one subagent runs, every prompt includes the `AGENTS.md` isolation instruction
- when exactly one subagent runs, no full `AGENTS.md` override is added, but the prompt still forbids product-source mutation and all writes outside its assigned output area
- every delegated prompt repeats all essential task constraints directly instead of relying on repository guidance
- every delegated run has a unique assigned handoff hash
- subagents are forbidden from synchronizing, committing, or pushing
- every subagent has a separate temporary handoff worktree and local run branch
- the designated product source is read-only and distinct from each subagent's writable output area
- output path, filename pattern, source-context contract, eligibility gate, and return contract are explicit

Before returning success:

- the response contains only created paths or exactly `NO_HANDOFFS_CREATED`
- when `NO_HANDOFFS_CREATED` is returned, no new handoff file exists for the run
- every new filename follows `handoff-<handoffhash>-NN-<topic>.md`
- every created handoff contains the required source context
- every operation token was checked against the latest remote collection
- every returned file exists in the refreshed product-worktree visibility mirror
- every created handoff was committed and pushed on `tracked-handoffs`
- the final publication phase fetched the remote collection again and preserved concurrent additions
- the visibility mirror contains every handoff from the successfully published remote state with identical content; excluded ordinary local notes may remain alongside it
- no path outside `TRACKED_HANDOFFS/` was staged, committed, restored, or pushed by the synchronization workflow
- the current product branch was not committed or pushed by this workflow
- current and abandoned managed worktrees, run branches, retry branches, and lock state were recovered or removed when safe; any retained artifact still contains unpublished or unrelated work that must not be deleted

## Typical Invocation Phrases

- `/tracked-handoff-sync-creation-softskill mach einen generellen Code-Review`
- `/tracked-handoff-sync-creation-softskill mach einen generellen Code-Review mit drei Subagenten`
- `Use $tracked-handoff-sync-creation-softskill to review this repository and create only justified implementation handoffs.`
- `Use one subagent and preserve only concrete repository-supported findings as handoffs.`
- `Use three independent subagents, keep the parent context small, and return only handoff paths or NO_HANDOFFS_CREATED.`
