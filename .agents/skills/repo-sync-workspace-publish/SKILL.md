---
name: repo-sync-workspace-publish
description: Safely synchronize the current Git branch and its complete intended workspace state with its remote, preserving local commits and working changes, integrating remote changes without history rewriting, committing only understood publishable work, and pushing only when end-to-end publication was explicitly requested. Use for cross-machine handoff or sync-everything-and-push requests; do not use for local-only commits, branch-to-main promotion, or force-push and history-rewrite workflows.
---

# Repo Workspace Sync And Publish

## Overview

Synchronize one current Git branch and all understood work intended for sharing with its configured remote. Preserve existing commits, working changes, staging state, and pre-existing stashes; integrate current remote work safely; publish with a normal push; and verify the actual remote head afterward.

The successful endpoint is stronger than "the push succeeded": local and remote branch heads match, no relevant work remains only in the working tree or a newly created safety stash, and any work deliberately kept local is reported clearly.

## Activation And Authority

Use this skill only when the user explicitly asks for an end-to-end synchronization that includes publication, such as:

- synchronize everything and push
- prepare the repository for continuing on another computer
- integrate the current remote state, preserve local work, and publish the result

Do not use it for:

- a local-only commit or commit plan
- promoting a feature branch into `main` or `master`
- a review-only, status-only, or plan-only request
- rebasing, amending, resetting published history, or force-pushing
- publishing several repositories when the requested repository set is unclear

Explicit activation authorizes read-only discovery, fetch, safe integration into the current branch, local commits for understood in-scope work, a normal push to the unambiguous current branch destination, and verification. It does not authorize:

- force-push or history rewriting
- creating or replacing credentials
- persistent account, Git, GitHub CLI, credential-helper, or remote-URL configuration changes
- deleting branches or pre-existing stashes
- creating pull requests, releases, tags, or repository settings unless separately requested

If the user asks only for a plan, review, or status, perform discovery only and stop before fetch, stash, integration, commit, or push.

## Completion Terms

- **Relevant work:** local commits and working-tree changes that are understood, belong to the requested shared state, and are safe to publish.
- **Current remote state:** the fetched state of the selected upstream immediately before integration or push.
- **Fully synchronized:** local and actual remote branch heads match, no Git operation is incomplete, and no relevant work remains uncommitted, untracked, or only in a safety stash.
- **Partial publication:** existing commits were published, but some incomplete, unclear, sensitive, ignored, or explicitly excluded work remains local. Never call this a complete workspace synchronization.

## Workflow

### 1. Resolve Repository And Publication Target

Resolve and report:

- exact Git top-level directory
- current branch and whether `HEAD` is attached
- upstream tracking branch
- relevant remote and remote URL
- intended remote branch

Prefer the current branch's configured upstream. Use remote ownership, the remote default branch, and the user's stated target only to resolve ambiguity; do not silently change the upstream or remote URL.

Stop and ask when:

- `HEAD` is detached
- no publication branch can be determined safely
- several remotes or owners are equally plausible
- the requested scope spans repositories that were not clearly selected

When no upstream exists but one remote and same-named target branch are unambiguous, an explicit refspec push is allowed later. Do not use `git push -u` because it changes repository configuration.

### 2. Resolve Authentication Context Safely

Determine whether the remote operation requires a specific existing account or organization context. Derive the expected identity from the remote URL and repository owner, then inspect available contexts and the active identity using read-only checks.

An account selection is allowed without another question only when the available tool explicitly provides a temporary, workspace-scoped, sandbox-scoped, or session-scoped switch. After switching, verify repository access with a read-only metadata or remote-head query.

Do not:

- perform an interactive login
- create, replace, delete, or expose credentials, tokens, or keys
- run `gh auth switch` when it would modify shared or persistent machine state without explicit user permission
- change Git configuration, credential helpers, or remote URLs to bypass an authentication problem

If no matching usable context exists, or switching would require persistent configuration, stop and ask the user. Record the initial context, contexts checked, any scoped switch, and the context ultimately used without exposing credential material.

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

Fetch the selected remote before integration:

```text
git fetch --prune <remote>
```

If fetch fails, do not integrate, commit, or push. Report the error and the captured local baseline.

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

Advance only by fast-forward against the already fetched upstream:

```text
git merge --ff-only <upstream>
```

If fast-forward unexpectedly fails, stop and re-evaluate. Do not substitute a merge, reset, or rebase silently.

#### Diverged

Create a uniquely named local safety branch at the original local `HEAD`. Keep it unless the user later requests cleanup.

Proceed with a merge only after the overlap analysis shows that the result can be understood safely. Prefer a merge over rebase so existing commits are not rewritten. Start the merge without automatically finalizing the merge commit when the available Git command supports that review point.

Before completing the merge, inspect:

- the full staged result
- unexpected deletion or rename outcomes
- project, dependency, build, data-format, and configuration effects
- source and test changes that must remain consistent

Resolve conflicts only when the correct combined behavior is supported by repository evidence. Do not choose one side merely to make Git clean. If a safe resolution is not possible, abort only the merge started by this workflow, preserve the safety branch, restore any workflow-created stash, and ask the user with the exact conflicted paths and options.

Never use force-push, `reset --hard`, destructive clean commands, or rebase as an automatic fallback.

### 7. Restore The Workflow-Created Stash

Restore only the exact stash created by this workflow. Apply it first with its staging information when possible; do not pop it immediately.

Verify that:

- all prior staged, unstaged, and untracked changes are present
- the staging state is restored as far as Git supports
- no conflicts were introduced
- the selected stash is the workflow-created stash, not a pre-existing one

Drop that stash only after successful verification. If restoration conflicts, keep the stash, preserve the integrated branch state, and investigate without guessing. Report that complete workspace synchronization is blocked.

### 8. Prepare Relevant Local Work For Publication

Inspect the complete resulting diff and classify every changed path as:

- **commit now:** understood, in scope, safe, and complete
- **hold:** explicitly excluded, generated, ignored, sensitive, or intentionally local
- **needs review:** unclear ownership, incomplete intent, suspected secret, or risky behavior

Group `commit now` changes into coherent commits that preserve a usable progression. Stage only exact intended paths and use concise messages derived from the changes. Do not force-add ignored files, silently change tracking policy, or combine unrelated work merely to empty the worktree.

Run proportionate build, test, or validation commands when they are known and safe. A failing relevant check blocks claiming a fully synchronized publish unless the user explicitly accepts publication with that known failure.

If relevant work remains under `needs review`, stop before claiming complete synchronization. Existing safe commits may be published only when doing so does not misrepresent or break the shared state; report the result as partial.

### 9. Recheck The Remote Immediately Before Push

Fetch or query the selected remote again. Compare the live remote branch with the local branch.

If the remote advanced, do not push. Return to classification and integration using the new remote state. If the remote changes repeatedly or safe integration becomes unclear, stop rather than racing another contributor.

Before push confirm:

- target remote and branch remain unambiguous
- no Git operation is incomplete
- no unresolved conflicts exist
- local history contains the current remote history
- relevant checks passed or an explicitly accepted limitation is recorded
- no suspected secret or unintended file is staged or committed for publication

### 10. Publish Without Rewriting History

Use a normal push to the selected branch. Never use `--force`, `--force-with-lease`, or another history-rewriting path.

With a configured upstream, push the current branch normally. Without an upstream, use an explicit remote and refspec only when both are unambiguous; do not add `-u` automatically.

If push is rejected or authentication fails, do not bypass the rejection. For a non-fast-forward rejection, fetch and classify again. For permission, policy, or protected-branch rejection, report the blocker and required user or repository-owner action.

### 11. Verify The Actual Remote Result

Do not rely only on the local tracking ref after push. Query the actual remote branch head using `git ls-remote`, repository metadata, or another read-only remote query and compare it with local `HEAD`.

Confirm:

- local `HEAD` equals the actual remote branch head
- ahead and behind are both zero against current remote state
- no conflict or incomplete Git operation remains
- the working tree contains no unreported relevant work
- the workflow-created stash was restored and removed, or remains intentionally as a reported blocker
- all pre-existing stashes remain untouched
- any safety branch created for divergence is named and reported

Only then report that work can continue from another machine using the published repository state.

## Failure And Recovery Rules

- If an unexpected file or commit appears during the workflow, stop and re-inventory before continuing.
- If fetch fails, make no integration or publication changes.
- If integration fails, preserve the original `HEAD` through the safety branch and abort only operations started by this workflow when safe.
- If stash restoration fails, keep the stash and do not claim that local work was fully restored.
- If validation fails, report the exact failed check and do not hide it behind a successful push.
- If push fails, never force it; preserve local commits and report the visible reason.
- If account selection is ambiguous or persistent configuration would be required, ask before switching.

## Final Report

Keep successful reports compact. Include:

- repository, branch, upstream, and publication target
- initial authentication context and any scoped context selection
- initial and final local/remote heads and ahead/behind state
- whether fast-forward, merge, or no integration was used
- safety stash or safety branch created and its final state
- commits created and published
- validation commands and results
- push and independent remote-head verification result
- remaining local, excluded, incomplete, sensitive, or stashed work
- whether the full intended workspace is available for continuation from another machine

Expand only for divergence, conflicts, partial publication, authentication problems, failed validation, or failed push. Never reproduce secret values in the report.
