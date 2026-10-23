# Workspace Lifecycle — Rematerializable Workstream Branch

## Durable Versus Temporary State

- **Durable:** the actual remote stream ref `refs/heads/feature/ewrks/<topic>-<stream-id>`, its commits and the per-step primary issues/decision history. The ID and readable topic remain stable across the stream's life.
- **Temporary per step:** one local feature ref, one linked Git worktree, local caches/verification outputs and any not-yet-published work.
- **Conversation-local:** the active stream pointer (repo, remote, exact ref and ID). It can be used for implicit continuation only while known unambiguously. It is not a reliable cross-session lock, recovery database or substitute for remote verification.
- No semantic duplicate search: different stream IDs are intentionally permitted to carry identical task text, reviews or code changes for experiments. A repeated task does not imply branch reuse. Only *explicit continuation* or an unambiguous active-stream choice reuses a remote branch.

## Safe Start or Continuation

1. Identify actual Git repository root, remote configuration, repository instructions, current worktrees, checked-out branches, local status, available tracked/untracked/ignored changes and integration conventions. Preserve all pre-existing worktrees, branches, indexes, stashes and modified state.
2. **Refresh actual remote state** where authorized, e.g. `git fetch --prune <remote>` and query the actual remote heads independently where needed; a stale `origin/<branch>` is not enough to select a safe base or claim remote publication. Never fetch as a pretext to reset, switch, stash or clean the caller's worktree. If required remote confirmation fails, stop rather than guess: a remote-backed, early-published workstream cannot complete its required gates offline.
3. **New explicit start (`$execute-workstream ...`):** choose the starting base using **New-Stream Base Selection** below (never implicitly the caller's checkout). Choose a readable topic and its next **per-topic, per-day Git-verified** `<YYDDMM>-<N>` stream ID as defined in `SKILL.md`; use `feature/ewrks/<topic>-<stream-id>`. Confirm the selected local and actual remote ref and worktree path are unused. If occupied before publishing, select the next available number; never overwrite or claim an existing ref. Record the actual base ref and SHA.
4. **Continuation:** resolve exact repo/remote/`feature/ewrks/<topic>-<stream-id>` from an unambiguous opted-in conversation active stream or explicit user-supplied stream ID/ref. Confirm the exact remote branch exists, query its current SHA, and treat **that exact SHA** as the next step's baseline, including every previously published step. Never restart from a repository integration or mainline branch by mistake; never pick a different recent branch just because its topic looks similar.
5. Detect any residual local branch or registered worktree for the same stream. A previous interrupted or incompletely cleaned step may own it. Do not delete, overwrite, reset or silently reuse it when its provenance and state are uncertain. If the requested continuation conflicts with valuable local work, remote advancement or another active checkout, stop and report the exact local/ref conflict and recovery options.
6. Use the **single required linked-worktree location** `<repo>/.worktrees/<topic>-<stream-id>/` inside the accessible repository checkout. The final directory segment must exactly match the branch slug after `feature/ewrks/`. Keep the original Product Evolution checks for Git state, ignored nested trees, scanners, mounts and safe cleanup, but **do not offer a sibling or any alternative location**. Verify all conditions under **Worktree Placement and Isolation** before creation. If this path is unsafe or unavailable, stop and report the constraint.
7. Create the **new local feature branch only for this materialization** and check it out solely in the new linked worktree, from the exact confirmed SHA: for a new stream use its selected starting base; for continuation use the confirmed remote stream head. A continuation may re-create the *same local branch name* because successful prior cleanup deleted that local name; it is not a new durable stream. Verify path, local branch, base SHA, clean initial state and sole worktree ownership.
8. Run read-only preparation/review against the linked worktree's code snapshot before committing to an actionable step. If no justified step emerges *before a primary issue or remote branch publication*, clean only the temporary unpublished setup when all ownership and safety checks pass. No fake issue or artificial empty commit.

## New-Stream Base Selection

Choose the starting commit by **branch role**, not a prescribed name:

1. Honor an explicit, permitted user-specified branch or commit first.
2. Otherwise follow the repository's documented **normal integration branch for new feature work**. Names such as `develop`, `development` or `integration` are examples, not requirements.
3. Without a documented rule, use a clearly identifiable development/integration branch if one exists; in a simple single-mainline repository, use its primary branch (for example `main`, `master` or `trunk`). Do not create a missing development branch.
4. Do not treat the current checkout (including a `hotfix/*` branch), or names such as `testing` or `staging`, as automatic evidence of the intended base. If multiple credible bases remain and their roles are unclear, resolve the ambiguity **before** creating the worktree or branch.
5. Refresh and verify the selected remote ref and exact commit SHA; record the ref and SHA in the first step issue. If a specific commit is explicitly pinned, verify that SHA instead. Selection does **not** merge, fast-forward, reset or otherwise change the invoking checkout.

**Continuations do not repeat base selection:** they always materialize from the independently confirmed current remote HEAD of their **existing stream branch**, regardless of changes to integration branches.

## Worktree Placement and Isolation — Fixed Repository-Local Layout

This file **fully specifies** the repo-local linked-worktree isolation and cleanup gates carried over from Product Evolution; the running workstream needs **no access to or execution of the original skill**. The only allowed checkout path is `<repo>/.worktrees/<topic>-<stream-id>/`, with no sibling placement. The `<topic>-<stream-id>` segment is exactly the suffix of the full remote ref `feature/ewrks/<topic>-<stream-id>`; omit only the `feature/ewrks/` namespace from the filesystem directory. Remote CI/CD derives paths from the compact branch name, while the local developer worktree remains readable.

1. Resolve the **real Git repository root** and registered worktrees before creating anything. Inspect `git status`, branch and upstream, `git worktree list --porcelain`, remote state, uncommitted changes and repository-specific rules. **Assume the invoking checkout may be in active use by a developer or another agent:** it remains read-only to this workstream even when its status looks clean. Never edit, switch, reset, revert, clean or commit it, including during cleanup and handoff. If invoked from an existing linked worktree, resolve the actual accessible repository checkout whose `.worktrees/` tree will contain the new worktree; do not assume an inaccessible path.
2. Compute the **single** target `<repo>/.worktrees/<topic>-<stream-id>/`. It must be under that Git checkout, reachable through the available workspace mount, unused, not a tracked-path collision, and not owned by any other registered linked worktree or user. On a later step in the same stream, re-use **exactly this directory name**, but only after the previous step's worktree was safely removed.
3. **Before creating the directory**, verify its *entire enclosing `.worktrees/` tree* is ignored by the containing checkout, for example through `git check-ignore -v`. Respect existing ignore patterns. When needed, add a **local-only** rule in the actual shared Git directory's `.git/info/exclude` without overwriting existing entries; avoid editing the tracked `.gitignore` purely for this worktree. Verify the resulting ignore behavior and check symlink/junction and path conflicts.
4. Check whether recursive scanners, solution/project discovery, builds, tests, lint, file watchers, packaging, deployment or indexing would unintentionally traverse nested worktrees despite Git ignores. Exclude `.worktrees/` from such operations where safe and supported, and do not stage or package its contents. If the repository/tooling cannot safely accommodate this exact path, **stop**. Do not work around it by using a sibling path, a host-global directory, a different short name or the original checkout.
5. Create or rematerialize the local `feature/ewrks/<topic>-<stream-id>` branch **only in this linked worktree**, from the verified selected starting SHA for a new stream or the confirmed exact **remote stream HEAD** for continuation. Verify checkout location, branch identity, initial SHA and clean status. The worktree path is not an alternate storage location for durable work.
6. After successful final remote publication, enforce the complete preservation gates defined below: inspect tracked/untracked/**ignored** valuable state; non-forcibly remove only the worktree created for this step; verify its absence; confirm local branch identity and exact equality with the independently verified remote SHA; then remove **only** that local branch, keeping the remote stream ref. If any condition fails, preserve the state and report why. These cleanup rules apply identically to each resumed step.

Required layout:

```text
mounted-project-workspace/
  MyProduct/
    .git/
    .worktrees/                          # entirely ignored; excluded from incompatible scanners
      <topic>-<stream-id>/               # one linked worktree for the active step
```

**No placement fallback.** A missing/safety-blocked `.worktrees/<topic>-<stream-id>/` means this step cannot run under the prescribed isolation model. Before an issue is created, report blocked preparation without manufacturing an issue-status commit; after issue creation, follow the actual `Blocked` handoff rules, preserving local work. Never modify the caller's checkout to avoid the block.

## No-Work Cleanup Before Any Issue

If read-only inspection/review finds **no actionable authorized step**, and this invocation has not created its primary issue, any product edit, its own commit or a new remote stream publication, treat the temporary checkout as **unused local setup**, not a Done or Blocked issue:

1. Confirm the exact local worktree and branch were created **by this invocation** and still point at the recorded starting SHA. On a continued stream, this starting SHA is the verified remote stream HEAD; on a new stream, it is the verified selected starting base. Confirm no other worktree uses that branch.
2. Inspect tracked, staged, untracked and ignored state for any valuable work; check that no own commits or remote updates occurred. Never remove a worktree with uncertain ownership, valuable changes or publication state.
3. Only when all checks pass, use non-forced `git worktree remove <exact-created-path>`, verify it is gone, then delete only this run's untouched, unpublished local branch using ordinary `git branch -d -- <exact-branch>` when Git's merge check permits. If it refuses or anything is uncertain, preserve the remaining branch and report its exact identity; do not force-clean. The **existing remote stream** on continuation is never changed or removed.
4. Report `No work` and the actual cleanup outcome without inventing a primary issue or status commit. If an issue, new commit or remote publication already exists, this disposal procedure does **not** apply: follow the honest issue/status and publication handoff rules instead.

## Per-Step Record and Early Publication

1. Follow [IssueRecord.md](IssueRecord.md): one new primary issue for each actual step. On a brand-new stream, use its `s001` identity; on a continuation use the next stream-local identity (for example `s002`), derived from committed issue records without screening semantic duplicates.
2. Write the issue file inside the linked worktree and commit the original issue **alone**, with acceptance criteria and baseline facts, before product edits.
3. **Push the exact local stream branch early** to its authorized remote and verify the actual remote head equals this step's issue-only baseline commit. This applies to both new and resumed streams. In the latter case, the new baseline extends an already published branch; do not mistake existence of an older remote ref for successful publication of the current step.
4. Remote advancement since materialization or rejection of a non-fast-forward push is a conflict, **not** authority to force-push, silently rebase away other steps or overwrite another actor's work. Preserve local state and report it. If early publication cannot succeed, **stop before product edits** and safely retain the local issue/worktree/branch for recovery.

## Implement, Verify and Publish

- Edit code, docs, tests and issue files only inside this linked worktree and the selected step boundary. Commit coherent pieces of actual implementation. Keep issue-only decision commits separate whenever intent or outer scope changes materially.
- Do not create a new durable branch on every continued step; the worktree/local branch are **rematerializations of the same remote stream**.
- After tests pass, finish the same issue with `Done` and its final dedicated status/move commit; on an actual blocker, issue `Blocked` with recoverability details and a dedicated issue status commit. See [ExecutionProtocol.md](ExecutionProtocol.md).
- **Push the final workstream HEAD**, then query the actual remote and verify that the remote SHA is precisely the local final commit SHA. A successful command exit by itself is insufficient.
- Do not push arbitrary other branches, open a PR without a separate request, merge, push tags, force-update refs, or remove the remotely retained stream branch.

## Cleanup After Confirmed Final Publication

1. Confirm the final local branch commit is remotely retained and the worktree's tracked/index state and untracked and **ignored** files contain no valuable unpublished changes. Examine potential secrets, build outputs, local data, symlinks/junctions and generated artifacts before disposal. If uncertain, **do not delete**.
2. Remove only **the worktree created for this materialization** with non-forced `git worktree remove <exact-path>`. Verify it is absent from `git worktree list`. Never force-remove an unknown worktree, recursively delete a directory as a shortcut or prune unrelated worktrees.
3. Confirm that no registered worktree checks out the local branch; that its identity exactly matches this step's own materialized feature branch; that local tip remains at the remotely confirmed final SHA; and that the remote stream ref still exists at this SHA.
4. Delete only the local branch belonging to this materialization. Prefer `git branch -d -- <exact-branch>`. If the local branch is intentionally unmerged to mainline and Git's merge check alone blocks deletion, `git branch -D -- <exact-branch>` is permitted **only** after all identity, worktree-absence and exact remote-SHA checks succeed. This is verified removal of a redundant local ref, not forced deletion of unbacked-up commits.
5. Keep the **remote stream branch** and all previous step history intact. Its remote tip is the next step's starting commit. A clean local machine after each step is the desired normal state.
6. If final publication or any cleanup precondition fails, preserve what remains and report exact file path, branch, reason, current SHAs and resumption route. Do not promise there is no local residue when safety required keeping something.

## Boundaries and Interrupted Work

- Successful remote checkpoints make finished steps reconstructible from the remote. They do **not guarantee** an interrupted uncommitted or unpushed change is safe, nor do they guarantee a remote lock, reconnect logic or automatic conflict reconciliation.
- An unfinished previous step with a live local checkout/issue must be resolved or consciously handed off before re-creating its branch elsewhere. Do not silently turn its pending work into a new step.
- An explicit *new* `$execute-workstream` produces a **different** stream identity, branch and first step, regardless of overlap with an active existing stream. It does not clean, integrate or retire the old remote stream.
- If the user explicitly selects a previous stream, that selection wins over the conversation's latest active pointer after actual remote identity is verified.
- Do not auto-delete local artifacts from other streams, even if the user calls them "old". Only remove the exact current-step materialization after the safety gate above.
