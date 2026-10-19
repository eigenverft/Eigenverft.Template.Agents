# Execution Protocol — One Independently Published Step

This protocol is the general execution component derived from the practical Record → Implement → Verify → Package & Close lifecycle of Product Evolution. It neither discovers product opportunities nor performs semantic duplicate screening. Apply it to each step of an explicitly selected workstream. Read `IssueRecord.md` and `WorkspaceLifecycle.md` as equally binding parts of the package.

## 0. Establish the Exact Step

- Resolve the user's authorized input: direct task, review-skill findings or another compatible skill. Determine what the **current step** is meant to change and what is outside it. Do not reinterpret the selection criteria of an invoked domain skill as a general product search.
- Resolve exact stream identity and state: explicit new start, active conversation continuation, or explicitly selected previous stream. A new explicit `$execute-workstream` always requests a new stream and ID; do not append it to the previous stream. Continuation of the active stream uses its existing remote branch.
- Identify the target repository and the protected integration baseline or existing remote stream head. Reconfirm the actual remote state independently. For a resumed step, earlier `Done` commits and issue files are ordinary immutable baseline history, not open issues to rewrite.
- Perform read-only analysis/review against the stream's intended code snapshot, not against an unrelated invoking checkout. A temporary linked worktree may be needed **before** the issue is created for read-only orientation; no product edits or remote publication of a new stream may happen before a viable step is defined and recorded.
- Determine one bounded, cohesive change; document what is observed versus inferred, affected consumers/developer behavior, protected contracts, realistic acceptance criteria and verification route. Review skills themselves remain read-only. If no justified work emerges, return `No work` for the unstarted step and safely remove only any unused/unpublished local setup. Do not create a pretend issue or "improvement" merely to run the protocol.
- **Do not check for semantically similar finished issues, active PRs or already claimed work as a selection/skip rule.** Repeating identical input on independent streams is intentional and allowed. Check only technical conflicts, branch/ref identity and safety of actual modifications.

## 1. Record the Step Before Any Product Edits

1. Respect the target repository's usable issue-tracking convention. Prefer its existing accessible tracker or versioned per-issue format. If neither is suitable and policy allows it, use `issues/open/<topic>-<stream-id>-sNNN.md` inside the isolated stream worktree. Existing issue summary pages do not automatically become a tracker. Do not overwrite existing summaries or create a global issue index.
2. For a new stream, allocate the collision-resistant stream ID and exact `feature/ewrks/<topic>-<stream-id>` branch, then record stable stream identity, target repo, starting integration SHA and original assignment. For a continuation, retain the **same** branch/ID and derive the next distinct step number from that stream's own remote issue history and committed state.
3. Write the **single primary issue for this step** using [IssueRecord.md](IssueRecord.md). Start with `Before / Change / After / Evidence` (or direct translations). Initial `Change` is planned; initial `After` is explicitly `Not implemented yet`. Record the user/skill-provided task, baseline and scope, criteria and risks. There is **no Discover/Assess/Select candidate-comparison requirement**.
4. For a versioned issue, stage the issue alone and create a **dedicated issue-only baseline commit** before modifying any product file. Confirm the commit's actual diff contains no product changes. For an external tracker, ensure the issue actually exists durably; do not create a duplicate file merely to simulate a checkpoint. Link its ID in subsequent commits.
5. **Early publication gate on every step:** Push only the workstream branch to the authorized existing remote and independently verify that the actual remote ref is now at the new step's baseline commit (or, with an external issue, at the approved branch base). Even a resumed branch needs a fresh baseline for a new versioned issue. No product edit before this success.
6. If an issue cannot be durably recorded or early publication fails, report **Blocked before edits**. Preserve real issue, branch, worktree and uncommitted state safely; do not silently fall back to changing the caller's checkout, force-push, or treat a local scratch note as a durable issue.

## 2. Implement the Bounded Assignment

1. Recheck that the issue, branch, current step baseline commit and early remote publication are real. All edits happen only in the dedicated linked worktree.
2. Implement the smallest **complete** authorized outcome (or cohesive related findings) consistent with acceptance criteria. Touch dependent layers only when necessary; preserve relied-upon APIs, behavior, data and accessibility unless an authorized change explicitly covers them.
3. Use meaningful implementation commits when a coherent piece is finished or an important recoverability checkpoint exists. Each should explain actual effect, refer to the step issue and not combine unrelated work. Avoid per-edit noise, dummy commits and secret/ignored local files.
4. **Material changes of intent first, code second:** If evidence changes outcome, acceptance criteria, risk boundary or outer scope, stop affected implementation and append original versus revised decision, reason, and authorization to the *same step issue*. For versioned issues, make a distinct issue-only decision commit before coding to the new decision and verify its staged diff. For external issues, persist that history in the tracker before the new work. Do not silently rewrite the original assignment.
5. If review findings prove inapplicable, document what was observed. Do not manufacture a replacement product objective to force `Done`. A different or larger change is a new choice requiring valid authorization. Work that cannot safely meet the issued acceptance criteria becomes an honest `Blocked` handoff.
6. Do not automatically run a standalone skill's conflicting version of branch setup, issue management, pushing, merging, deployment or repository-wide synchronization. The outer workstream owns these stages; honor inner domain rules only within this boundary.

## 3. Verify and Record Real Evidence

- Run relevant tests, build, static checks or targeted reproduction steps supported by the environment; assess contract and regression consequences as well as unintended edits. Compare the actual outcome to the issue criteria and the original `Before` situation.
- Explicitly distinguish correctness verification from real consumer validation. Do not claim end-user value was measured just because tests pass.
- Record commands, relevant results, limits, failures, affected behavior and remaining risks in the issue. Do not invent tool execution or evidence.
- Repair within the agreed scope and repeat verification as appropriate. For material rescope, checkpoint the decision first. If a required check cannot be completed or a real blocker prevents a safe outcome, follow the `Blocked` handoff rather than declaring `Done`.

## 4. Close the Step (Not the Stream)

A step can finish while its workstream remains usable for later tasks.

### Verified Done — versioned issue

1. Confirm every intended product change and meaningful test artifact is committed and the complete branch diff and decision chronology are reviewable.
2. Update the **same step issue** in its opening `Change / After / Evidence` fields with the actual change and observable behavior in the same `Before` situation. Record tests, residual risks, explicit `Done` (implemented and verified, **not merged**) and the status of final remote publication, PR/merge and local cleanup as **pending**.
3. Move that exact issue file to `done/` in the established issue root (use `git mv` when available). Preserve filename, identity and earlier history; no duplicate.
4. Stage **only** the final issue closure/move, verify the staged diff, and make this the **last step commit**. No product file edits or subsequent issue-file commits after the dedicated closure commit.

### Verified Done — external tracker

- Keep the real issue identifier; do not invent a repository issue file or filesystem move. Record verified progress and implementation commit references in that tracker; close it after successful final remote publication and permitted cleanup according to tracker rules. An issue may be implementation-complete before the entire handoff succeeds.

### Blocked after issue creation

- Commit any safe and coherent implementation progress when possible and state its unverified status. Preserve valuable uncommitted work on uncertainty; do not discard it or claim verification.
- In the **same step issue**, record actual work, blockers, missing evidence, recovery conditions and status `Blocked`. For versioned issues, move the same filename to `blocked/` in a dedicated final issue-only status commit. For external trackers, update their native status.
- Push this same stream branch, verify its actual remote head and preserve local state if publication fails. `Blocked` is not merge-ready and does not close the overall stream or earlier completed issues.

## 5. Publish the Step's Final Head

1. Push **only the designated workstream branch** to the existing authorized remote using a normal non-forced update. Verify independently that the actual remote ref equals the **exact** local tip of the final status commit, not merely a previous step's commit or early baseline.
2. On failed remote publication, report `Blocked / publication pending`, preserve the local linked worktree and branch and any relevant committed/uncommitted state. Never call an incomplete handoff successfully published.
3. Do not auto-create a PR, merge into an integration/mainline branch, push other branches, delete a remote workstream branch, amend shared history or force-push.

## 6. Safe Local Cleanup and Handoff

Only **after** final remote publication is confirmed:

1. Examine tracked, untracked and ignored files plus nested paths for valuable unpublished state. Non-forcibly remove only the temporary worktree created/materialized for this step when safe, and verify it is absent from `git worktree list`.
2. Confirm no worktree holds the local branch, it is the exact stream branch owned/materialized for this step, its tip has not changed and equals the actual remote head. Delete only that local branch (ordinary `git branch -d`, or `-D` only when all identity/SHA/remote safety checks pass and Git's merge check alone prevents deletion); **retain the remote branch**.
3. On any cleanup uncertainty or failure, leave the artifact intact and report what remains. Safe preservation outranks nominal cleanliness.
4. Report the exact remote ref, stream ID, step/issue identity, final actual SHA, `Done` or `Blocked` state, publication verification, cleanup outcome and remaining unknowns. Explicitly state that the stream is **resumable** once the remote state is retained, even when the local branch/worktree was removed.
5. Stop. The next eligible conversation task is a **new step on the same stream** unless the user explicitly starts another `$execute-workstream`, selects another stream, opts out, or the active context is ambiguous. Do not continue with unrequested new tasks.

## Limits and Distinctions

- `No work` is only a *new step before issue creation* decision; it does not erase earlier valid stream history.
- `Done` is one verified step; `published` is an independently confirmed remote state; `locally cleaned` means this step's local artifacts are safely removed; `integrated` requires a separately authorized merge.
- Publication checkpoints reduce reliance on local state, but do not prove recovery of uncommitted edits lost during interruptions. This skill defines safe handling and honest reporting, not a guaranteed fault-tolerant runtime or cross-agent locking service.
