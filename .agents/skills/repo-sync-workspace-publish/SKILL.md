---
name: repo-sync-workspace-publish
description: Discover one or more Git repositories from explicit targets, container directories, current context, workspace roots, or equivalent workspace interfaces, then safely synchronize and publish their complete intended shareable state. Preserve local commits and working changes, integrate remote changes without history rewriting, commit only understood publishable work, use normal pushes, and verify actual remote heads. Use for single-repository, multi-repository, workspace handoff, or sync-everything-and-push requests; do not use for local-only commits, branch-to-main promotion, or force-push workflows.
---

# Repo Workspace Sync And Publish

## Overview

Discover the exact Git repository set selected by the user, then synchronize and publish each repository's understood shareable state. Targets may be one repository, paths inside repositories, several explicit paths, a non-repository container whose immediate children are repositories, or workspace roots supplied by the current environment.

For every selected repository, preserve existing commits, working changes, staging state, and pre-existing stashes; integrate current remote work safely; publish with a normal push; and verify the actual remote head afterward. The successful endpoint is stronger than "the push succeeded": every selected repository is verified, no relevant shareable work remains only locally, and deliberately local state is reported clearly.

The skill is capability-based. It may use command-line tools, workspace APIs, MCP-style interfaces, or equivalent agent tools. No particular vendor, host, workspace product, directory layout, Git server, or tool implementation is required.

## Activation And Authority

Use this skill only when the user explicitly asks for end-to-end synchronization that includes publication, such as:

- apply the skill to a repository path or working directory
- synchronize several repositories and push
- apply the skill to a container directory or workspace
- prepare the selected repository state for continuation in another environment
- integrate current remote state, preserve local work, and publish the result

Invoking this skill with an explicit target is an end-to-end publication request unless the user limits it to discovery, planning, review, or status. An explicit non-repository container target selects its immediate Git repository children according to the discovery contract below.

Do not use this skill for:

- a local-only commit or commit plan
- promoting a feature branch into `main`, `master`, or another mainline branch
- a review-only, status-only, or plan-only request
- rebasing, amending, resetting published history, or force-pushing
- cloning or creating a local checkout from a remote-only repository unless separately requested
- an unresolved target set

Explicit activation authorizes read-only discovery, fetch, safe integration into each selected current branch, local commits for understood in-scope work, normal pushes to unambiguous current-branch destinations, and verification. It does not authorize:

- force-push or history rewriting
- creating, replacing, deleting, or exposing credentials
- persistent account, Git, hosting-CLI, credential-helper, or remote-URL configuration changes
- deleting branches or pre-existing stashes
- creating pull requests, releases, tags, or repository settings unless separately requested
- expanding the target set beyond the discovery rules
- product feature work, refactoring, cleanup, dependency upgrades, backlog execution, or fixes unrelated to the exact synchronization task
- product builds, test campaigns, packaging, artifact publication, deployment, sample execution, or environment setup without a validation need caused by the actual unpublished delta

If the user asks only for discovery, a plan, a review, or status, perform non-mutating discovery only. Do not fetch, stash, integrate, commit, or push.

## Terms

- **Execution workspace:** the roots, working directory, tool context, and scoped authentication contexts supplied by the current environment.
- **Git worktree:** one local checkout with its own current branch, index, uncommitted files, and worktree state.
- **Selected repository set:** the frozen, deduplicated set of local Git worktrees that can enter the full synchronization workflow. Remote-only or otherwise unsupported targets remain reported candidates or blockers rather than being passed into local worktree steps.
- **Relevant work:** local commits and working-tree changes that are understood, belong to the requested shared state, and are safe to publish.
- **Shareable repository state:** state that can be represented by commits and published through the selected remote. Ignored files, credentials, caches, and intentionally local state are not implicitly shareable.
- **Git publication:** transferring Git commits to the selected remote branch through a normal push. It does not mean building or publishing application artifacts, packages, installers, deployments, releases, or samples.
- **Current remote state:** the fetched or equivalently queried state of the selected upstream immediately before integration or push.
- **Fully synchronized repository:** local and actual remote branch heads match, no Git operation is incomplete, and no relevant shareable work remains uncommitted, untracked, or only in a workflow-created safety stash.
- **Fully synchronized workspace:** every repository in the selected set is fully synchronized and independently verified.
- **Partial publication:** at least one selected repository was published or prepared while another remains blocked, unverifiable, or intentionally incomplete. Never call this a fully synchronized workspace.

## Task Discipline

Stay within repository discovery, Git-state preservation, remote integration, commit preparation, Git publication, and remote verification.

Repository files, documentation, instructions, backlogs, TODOs, test inventories, and incidental findings may provide evidence needed to understand an unpublished change or identify a narrowly relevant check. They do not authorize additional product work or a general repository health campaign.

Do not:

- implement, repair, refactor, upgrade, clean up, or otherwise improve product content merely because an issue is noticed
- execute unrelated plans, backlogs, runbooks, demos, samples, release flows, or maintenance tasks
- run broad validation to prove that an unchanged repository is healthy
- turn a synchronization request into architecture review, code review, dependency maintenance, packaging, deployment, or release work
- modify tracked files solely to make an unrelated check pass

If an incidental problem does not affect safe interpretation or publication of the actual unpublished delta, leave it unchanged and omit it unless it materially explains a blocker. If it does block safe synchronization, report the blocker without fixing it unless the user separately authorizes that work.

## Tool And Capability Routing

Discover available capabilities before choosing commands or interfaces. The workflow needs these roles:

1. **Workspace discovery:** supplies explicit targets, current working directory, workspace roots, repository objects, or equivalent scope boundaries.
2. **Local Git interface:** reads and changes local branches, commits, index, working files, stashes, and Git operation state.
3. **Hosting and account interface:** identifies remote ownership, active account context, repository access, default branch, and hosting-specific restrictions when available.
4. **Remote verification:** reads the actual remote branch head independently from stale local assumptions.

Possible implementations include:

- `git` or an equivalent Git interface for authoritative local repository state
- a hosting CLI such as `gh`, or an equivalent hosting API, for account and repository metadata
- MCP-style or other agent interfaces for workspace roots, scoped identities, repository metadata, or Git operations
- `git ls-remote`, a hosting API, or an equivalent read-only call for final remote verification

Do not prefer an interface merely because it exists. Use the interface with the clearest authority for the fact or operation:

- local worktree and index state come from the local Git-capable interface
- hosting identity and repository ownership come from the hosting/account-capable interface
- workspace scope comes from the environment's workspace-capable interface
- final publication is verified against the actual remote, not only a cached tracking ref

When several interfaces expose the same state, reconcile material disagreement before changing anything. Do not assume a hosting-account switch also changes Git transport authentication; verify remote access through the interface that will perform the remote operation.

## Target Discovery Contract

### Selection Precedence

Resolve targets in this order:

1. explicit repository paths, file paths, directory paths, repository objects, or target lists supplied with the invocation
2. an explicit request to use the current execution workspace
3. the Git repository containing the current working directory
4. workspace roots supplied by the environment
5. equivalent repository or workspace selections exposed through an available interface

The most explicit valid selection wins. Do not silently add repositories from a lower-precedence source after a higher-precedence source resolved successfully.

### Resolve A Filesystem Target

For each explicit path or workspace root:

1. Resolve the canonical absolute path without following unbounded link or junction chains.
2. If it is a file, begin with its parent directory.
3. Ask the local Git interface whether that path is inside a Git worktree.
4. If it is inside a worktree, select that worktree's top-level directory and do not scan beneath it by default.
5. If the directory is not inside a worktree, inspect only its immediate child directories for Git worktrees.
6. Select an immediate child only when that child's resolved Git top-level corresponds to that child checkout; do not absorb a parent repository accidentally.
7. Report ordinary directories, inaccessible paths, bare repositories, and unsupported targets as skipped or blocked with a reason.

Recognize both `.git` directories and `.git` files used by worktrees or submodules through the Git-capable interface. Do not rely only on filesystem name checks.

### Containers, Nested Repositories, And Submodules

An explicit non-repository container directory selects all immediate Git worktree children. This interpretation does not require a second confirmation when the resulting set is unsurprising and the invocation clearly requests publication.

Do not recursively scan inside a selected repository by default. Nested repositories, submodules, vendored checkouts, fixtures, and repositories below immediate container children require an explicit recursive or additional-target request. When recursion is requested, stop traversal at each selected Git boundary unless the user clearly asks to include nested repositories too.

Avoid traversal outside the selected scope through symlinks, junctions, mount points, or equivalent links unless explicitly requested.

### Workspace Targets

When the user selects the current workspace, apply the filesystem resolver to every workspace root supplied by the environment:

- a root that is itself a Git worktree selects that worktree only
- a non-repository root selects its immediate Git worktree children
- several roots produce the union of their resolved repositories

If the environment provides repository objects rather than paths, use their stable identifiers and local worktree capabilities when available. A remote-only repository object can be inspected, but it cannot enter the selected repository set unless the interface exposes equivalent local branch, index, worktree, and commit operations. Keep it as a reported blocked target and do not clone automatically.

### No Explicit Target

When no target is supplied:

- if the current working directory is inside exactly one worktree, select that worktree
- otherwise resolve available workspace roots
- if one repository resolves, select it
- if several repositories resolve and the user did not request the whole workspace or all repositories, list them and ask for scope
- if none resolve, return a no-target result without mutation

### Normalize, Deduplicate, And Freeze

Canonicalize and deduplicate targets by worktree top-level path. Repeated references to the same worktree select it once.

Do not collapse distinct worktrees merely because they share a common Git directory; they may have different branches and local changes. Mark shared Git storage and never run mutating Git operations concurrently against those worktrees.

Before fetch or any other mutation, freeze and report the selected set with:

- canonical worktree path or stable repository identifier
- how it was discovered
- current branch or detached state when locally available
- remote host and owner when discoverable
- selected local, hosting/account, and remote-verification interfaces
- skipped or blocked candidates and reasons

Proceed without another question when the explicit invocation resolves predictably. The number of immediate repositories beneath an explicitly selected container is not surprising by itself. Stop and ask only when discovery reveals materially unexpected scope or authority, such as unrelated owners, ambiguous remotes, recursive repositories not requested, results outside the selected boundaries, or several equally plausible authentication contexts.

## Multi-Repository Orchestration

Repository publication is not atomic across several remotes. Reduce partial publication risk with two phases.

### Phase A: Prepare Every Selected Repository

For every selected repository, execute per-repository steps 1 through 8:

- confirm target and remote
- resolve and verify authentication
- capture the baseline
- fetch and classify
- preserve local work when necessary
- integrate remote work
- restore preserved changes
- prepare commits and run only validation required by the unpublished delta

Do not push any selected repository until every selected repository has completed preparation successfully. If one repository has a critical blocker, stop before publication by default and report the prepared and blocked repositories. Continue preparing or publishing independent repositories despite such a blocker only when the user explicitly requested best-effort behavior.

Read-only discovery may run concurrently when safe. Perform mutating Git operations sequentially by default, especially for worktrees sharing Git storage or authentication context.

### Phase B: Publish And Verify

When every selected repository is prepared:

1. Choose a stable publication order. Use a known dependency order when evidence supports one; otherwise use canonical target order.
2. For each repository, execute per-repository steps 9 through 11 immediately before moving to the next repository.
3. Re-verify the active account context and actual remote target before each push.
4. If a repository fails after earlier repositories were pushed, do not rewrite or roll back published history automatically. Stop or continue only according to explicit best-effort authority and report partial publication precisely.

For a single selected repository, execute steps 1 through 11 directly; the same safety gates apply.

## Per-Repository Workflow

### 1. Confirm Repository And Publication Target

For the selected worktree, resolve and report:

- exact Git top-level directory
- current branch and whether `HEAD` is attached
- upstream tracking branch
- relevant remote and remote URL
- intended remote branch

Prefer the current branch's configured upstream. Use remote ownership, the remote default branch, and the user's stated target only to resolve ambiguity; do not silently change the upstream or remote URL.

Stop for this repository when:

- `HEAD` is detached
- no publication branch can be determined safely
- several remotes or owners are equally plausible
- the resolved target no longer matches the frozen discovery result

When no upstream exists but one remote and same-named target branch are unambiguous, an explicit refspec push is allowed later. Do not add upstream configuration automatically.

### 2. Resolve Authentication Context Safely

Determine whether the remote operation requires a specific existing account, organization, tenant, or hosting context. Derive the expected identity from the remote URL and repository owner, then inspect available contexts and the active identity using read-only checks.

An existing account selection may be performed without another question when the available interface provides a workspace-scoped, sandbox-scoped, session-scoped, per-call, or otherwise isolated context switch. A hosting CLI account switch is also allowed when the execution environment is known to isolate its configuration and the switch only selects an existing account. After switching, verify repository access with a read-only metadata or remote-head query and through the transport that will fetch or push.

Do not:

- perform an interactive login
- create, replace, delete, or expose credentials, tokens, or keys
- change a shared or persistent machine account context without explicit user permission
- change Git configuration, credential helpers, or remote URLs to bypass an authentication problem

If no matching usable context exists, several contexts are equally plausible, or switching would require persistent shared configuration, stop and ask the user. Record the initial context, contexts checked, any isolated switch, and the context ultimately used without exposing credential material.

### 3. Capture The Baseline Before Fetch

Inspect and retain enough information to restore or explain the starting state:

- local `HEAD`
- current branch and upstream
- concise status including staged, unstaged, untracked, deleted, and renamed paths
- remotes
- ahead/behind information currently recorded locally
- running merge, rebase, cherry-pick, revert, bisect, or other Git operation
- existing stashes and their identifiers

Stop if a Git operation is already incomplete. Do not absorb or overwrite work whose owner or purpose is unclear.

Inspect candidate changes for generated output, ignored files, local runtime state, and likely secret-bearing paths. Never print secret values. Existing ignored files are not normal publication candidates.

### 4. Fetch And Classify The Branch Relationship

Fetch the selected remote through the chosen Git-capable interface. A typical command-line implementation is:

```text
git fetch --prune <remote>
```

If fetch fails, do not integrate, commit, or push this repository. Report the error and the captured local baseline.

Compare local `HEAD` with the fetched upstream and classify it as exactly one of:

- **in sync:** ahead 0, behind 0
- **local ahead:** ahead greater than 0, behind 0
- **local behind:** ahead 0, behind greater than 0
- **diverged:** ahead greater than 0, behind greater than 0

For local-only and remote-only commits, inspect commit lists and changed paths. For divergence, also inspect the merge base, changes on both sides, same-file edits, renames, deletions, and dependent project or configuration changes.

### 5. Preserve Working Changes When Integration Requires A Clean Tree

Do not create a stash merely because changes exist. Create one only when the required fast-forward or merge cannot safely proceed with the current working tree.

Before stashing:

- record all pre-existing stashes
- identify staged, unstaged, and untracked changes
- do not include ignored files unless the user explicitly requests their preservation in this workflow

Create one uniquely named safety stash including untracked files, record its exact stash reference and object ID, and verify that the tracked working tree is clean. If the stash fails or the tree remains unsafe, stop without integrating.

Never delete or rewrite a pre-existing stash.

### 6. Integrate The Fetched Remote State

Apply the branch case:

#### In Sync

No integration is required.

#### Local Ahead

Do not merge or rebase. The local branch already contains the fetched upstream state.

#### Local Behind

Advance only by fast-forward against the already fetched upstream. A typical command-line implementation is:

```text
git merge --ff-only <upstream>
```

If fast-forward unexpectedly fails, stop and re-evaluate. Do not substitute a merge, reset, or rebase silently.

#### Diverged

Create a uniquely named local safety branch at the original local `HEAD`. Keep it unless the user later requests cleanup.

Proceed with a merge only after the overlap analysis shows that the result can be understood safely. Prefer a merge over rebase so existing commits are not rewritten. Start the merge without automatically finalizing the merge commit when the available interface supports that review point.

Before completing the merge, inspect:

- the full staged result
- unexpected deletion or rename outcomes
- project, dependency, build, data-format, and configuration effects
- source and test changes that must remain consistent

Resolve conflicts only when the correct combined behavior is supported by repository evidence. Do not choose one side merely to make Git clean. If a safe resolution is not possible, abort only the merge started by this workflow, preserve the safety branch, restore any workflow-created stash, and ask the user with the exact conflicted paths and options.

Never use force-push, destructive reset or clean commands, or rebase as an automatic fallback.

### 7. Restore The Workflow-Created Stash

Restore only the exact stash created by this workflow. Apply it first with its staging information when possible; do not pop it immediately.

Verify that:

- all prior staged, unstaged, and untracked changes are present
- the staging state is restored as far as the interface supports
- no conflicts were introduced
- the selected stash is the workflow-created stash, not a pre-existing one

Drop that stash only after successful verification. If restoration conflicts, keep the stash, preserve the integrated branch state, and investigate without guessing. Report that complete repository synchronization is blocked.

### 8. Prepare Relevant Local Work For Publication

Inspect the complete resulting working-tree and staged diff. Also inspect every local-only commit that would be published, including its full changed-path set and relevant diff, rather than assuming an existing commit is safe merely because it is already committed.

Classify every changed path and unpublished change as:

- **commit now:** understood, in scope, safe, and complete
- **hold:** explicitly excluded, generated, ignored, sensitive, or intentionally local
- **needs review:** unclear ownership, incomplete intent, suspected secret, or risky behavior

Group `commit now` changes into coherent commits that preserve a usable progression. Stage only exact intended paths and use concise messages derived from the changes. Do not force-add ignored files, silently change tracking policy, or combine unrelated work merely to empty the worktree.

Check both newly created and previously existing local-only commits for unintended generated output, secret-bearing material, unrelated work, and changes outside the selected publication intent. Do not rewrite an existing commit automatically when a problem is found; stop and report the exact non-secret concern and safe options.

#### Delta-Based Validation Gate

Determine the complete unpublished delta against the current remote state before running any validation.

- When there are no local-only commits and no relevant working-tree or staged changes, skip product builds, tests, packaging, artifact generation, publish commands, deployments, samples, and runtime exercises. An unchanged repository needs only Git and remote-state verification.
- When the unpublished delta changes only documentation or non-executable metadata, use only a directly relevant lightweight check when one is necessary. Do not run a product build merely because a build command exists.
- When the unpublished delta changes code, build logic, tests, or runtime behavior, choose the smallest targeted check that gives reasonable confidence in those exact changes.
- Expand to a broader build or test suite only when the delta is broad enough to require it or the user explicitly requested broader validation.
- Do not run product publish, packaging, deployment, installer, sample, environment-provisioning, or network-heavy workflows as generic synchronization checks. Such a command requires separate user authority or a direct validation need created by the unpublished delta with no safer narrower check.

Validation is evidence for the unpublished delta, not a new task. Do not inspect unrelated failures, fix pre-existing problems, or continue into additional checks after the smallest sufficient validation has passed.

A failing directly relevant check blocks claiming a fully synchronized publish unless the user explicitly accepts publication with that known failure. A skipped check should be reported only when useful, including the reason it was unnecessary or outside scope.

If relevant work remains under `needs review`, stop before claiming complete synchronization. Existing safe commits may be published only when doing so does not misrepresent or break the shared state; report the result as partial.

### 9. Recheck The Remote Immediately Before Push

Fetch or query the selected remote again through the selected interface. Compare the live remote branch with the local branch.

If the remote advanced, do not push. Return to classification and integration using the new remote state. In a multi-repository run, return this repository to preparation and re-evaluate whether other prepared repositories remain valid. If the remote changes repeatedly or safe integration becomes unclear, stop rather than racing another contributor.

Before push confirm:

- target remote and branch remain unambiguous
- active authentication context can access the exact target
- no Git operation is incomplete
- no unresolved conflicts exist
- local history contains the current remote history
- relevant checks passed or an explicitly accepted limitation is recorded
- no suspected secret or unintended file is staged or committed for publication

### 10. Publish Without Rewriting History

Use a normal push to the selected branch. Never use force, force-with-lease, or another history-rewriting path.

With a configured upstream, push the current branch normally. Without an upstream, use an explicit remote and refspec only when both are unambiguous; do not add upstream configuration automatically.

If push is rejected or authentication fails, do not bypass the rejection. For a non-fast-forward rejection, fetch and classify again. For permission, policy, or protected-branch rejection, report the blocker and required user or repository-owner action.

### 11. Verify The Actual Remote Result

Do not rely only on the local tracking ref after push. Query the actual remote branch head through an independent read-only remote interface and compare it with local `HEAD`.

Confirm:

- local `HEAD` equals the actual remote branch head
- ahead and behind are both zero against current remote state
- no conflict or incomplete Git operation remains
- the working tree contains no unreported relevant work
- the workflow-created stash was restored and removed, or remains intentionally as a reported blocker
- all pre-existing stashes remain untouched
- any safety branch created for divergence is named and reported

Only then mark this repository fully synchronized.

## Failure And Recovery Rules

- If an unexpected file, repository, worktree, or commit appears during the workflow, stop and re-inventory before continuing.
- If target discovery changes after it was frozen, stop before mutation or publication and resolve the scope again.
- If fetch fails, make no integration or publication changes for that repository.
- If integration fails, preserve the original `HEAD` through the safety branch and abort only operations started by this workflow when safe.
- If stash restoration fails, keep the stash and do not claim that local work was fully restored.
- If validation fails, report the exact failed check and do not hide it behind a successful push.
- If push fails, never force it; preserve local commits and report the visible reason.
- If account selection is ambiguous or persistent shared configuration would be required, ask before switching.
- In a multi-repository run, never imply atomic rollback after any repository has been published.

## Final Report

For one repository, keep a successful report compact. For several repositories, start with a concise per-repository result table.

Include:

- requested target and how it resolved
- selected repositories and skipped or blocked candidates
- repository, branch, upstream, and publication target for each selection
- initial authentication context and any isolated context selection
- initial and final local/remote heads and ahead/behind state
- whether fast-forward, merge, or no integration was used
- safety stash or safety branch created and its final state
- commits created and published
- validation commands and results, or that validation was skipped because there was no unpublished delta
- push and independent remote-head verification result
- remaining local, excluded, incomplete, sensitive, or stashed work
- whether each repository and the overall selected workspace are fully synchronized

Expand only for surprising discovery, divergence, conflicts, partial publication, authentication problems, failed validation, or failed push. Never reproduce secret values in the report.
