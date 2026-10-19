---
name: execute-workstream
description: "Use when the user requests an explicitly invoked, resumable Git workstream via $execute-workstream, with an issue-backed, remotely published and locally cleaned-up change step for a supplied task or compatible skill. Subsequent in-context tasks may continue the active stream. Not for ordinary development, standalone read-only reviews, general Git operations or automatic activation."
---

# Execute Workstream

## Mission

Run **independent, durable, sequential change steps** on a single identifiable remote Git feature branch. Each completed step starts from the current remote stream head, records its own intent, implements and verifies its scoped work, publishes the final branch head, then safely removes its temporary linked worktree and own local feature branch. The **remote branch persists** for later steps; no clean local worktree is required between them.

This is an opt-in **execution lifecycle**, not a product-opportunity discovery policy, generic development skill, repository-wide sync command, or automatic merge process. The caller supplies the task, review skill, or other supported skill. The workstream handles *how the resulting authorized change is performed and handed off*, not *why that task should have been requested*.

A **stream** = one uniquely identified, remotely retained feature branch and its sequential history.
A **step** = one bounded assignment, one primary issue (when actual change begins), verification, final status, publication and local cleanup.
**Active stream** = the explicit conversation-level choice of which stream subsequent eligible prompts should target; it is not a persistent local checkout or guaranteed host-managed session state.

Read [ExecutionProtocol.md](references/ExecutionProtocol.md), [IssueRecord.md](references/IssueRecord.md) and [WorkspaceLifecycle.md](references/WorkspaceLifecycle.md) before creating, editing or publishing a step. Their requirements apply to *each* step, including resumptions.

## Activation and Conversation Semantics

- Explicitly starting with `$execute-workstream` means **start a distinct new stream**, even when another stream is already active or the new task resembles prior work. A second explicit start never implicitly appends to the prior stream.
- Example new stream: `$execute-workstream $review-code-quality`; or `$execute-workstream <user-defined task>`; or `$execute-workstream $some-compatible-skill <task context>`. Actual skill invocation and skill composition are **host-dependent**: do not claim these examples register slash commands or ensure automatic subskill invocation.
- **An active stream can be continued only after its remote branch has actually been published and verified.** If the first read-only review yields `No work` before the first issue/early push, local setup is cleaned and **no durable stream was established**; the generated candidate ID is not a valid continuation target. Do not silently fall back to an older active stream. A later request must explicitly start/select a real stream.
- Once a stream has been explicitly activated and the conversation retains an unambiguous active-stream assignment, subsequent eligible task prompts or named read-only review invocations (for example `$review-code-expression-naturalness`) **request the next step on that same stream** under this opted-in workflow; they must not start a new feature branch. Do not reinterpret unrelated questions or a plainly standalone read-only request as authorization to edit.
- A request to **continue/switch to stream <stream-id or exact remote ref>** selects that existing stream, after confirming repository, remote ref and identity. Such a selection is *not* a new `$execute-workstream` start. If the active stream cannot be established unambiguously, do not guess from the latest remote branch; request an exact stream identifier or stop with a clear boundary.
- This convention describes desired conversation-level orchestration. A `SKILL.md` **cannot guarantee** that a later turn naming only another skill automatically loads or executes this one. If the host does not retain/invoke this workflow in that turn, the other skill keeps its standalone behavior and authority. Never assert invisible persistence or silently expand a standalone review's permissions.
- A user can opt out, request a read-only-only run, switch streams, or explicitly override continuation. Later explicit instructions supersede earlier context within actual authority.
- Never activate merely because an ordinary coding prompt includes "change", a `review-*` skill is invoked in isolation, or a different execution skill is requested without the opt-in workstream context.

## Stream and Branch Identity

Default remote feature ref:

`feature/ewrks/<topic>-<stream-id>`

- `feature/` is the conventional branch family; `ewrks/` is this workflow's deliberately short namespace to reduce branch-derived paths in remote CI/CD builds. Use a **readable lowercase hyphenated topic first**, normally at most about 20 characters, followed by the stable, collision-resistant `stream-id`. Do not duplicate the workflow prefix in the topic. The branch's final `<topic>-<stream-id>` segment is also the **exact local worktree directory name**; the directory never includes the `feature/ewrks/` prefix.
- Prefer a securely generated **16-character lowercase Crockford Base32 ID** (or a comparably strong UUID/ULID if not supported), with enough entropy for independent concurrent invocations. Do not use only a timestamp, small sequential index, branch count, or task/skill name as the ID. Verify the exact branch name does not already exist locally or on the actual remote before publishing. On collision, generate a *new* ID; never force-push or reuse a different stream's branch.
- **Use one deterministic local worktree name matching the branch's final segment:** `.worktrees/<topic>-<stream-id>/`, inside the target repository's accessible checkout. Keep the `feature/ewrks/` prefix out of the directory name. This is the **only** permitted placement: no workspace sibling, `_tempWorkTrees/`, or alternative directory fallback. Apply the proven Product Evolution checks (Git state, full-tree ignore verification, scanner/build isolation, safe removal). If repository-local placement cannot be made safe and accessible, stop rather than silently choosing a different checkout location.
- Keep the exact stream ID, repo identifier, existing remote name, ref and initially selected base SHA in the first issue and user handoff. Later steps preserve the same ID/ref and record their own starting remote SHA.
- Each subsequent real change step gets a **new primary issue** with a stream-specific unique step identity; existing completed issues remain completed. For a repository-file fallback, use `issues/open/<topic>-<stream-id>-sNNN.md` with a monotonic stream-local step number (`s001`, `s002`, etc.); move the exact same file to `done/` or `blocked/`. Resolve the next number from the stream's own remote history and issue records, not semantic searches for related work.
- A new stream usually starts at the repository's verified integration-base remote SHA. For comparisons, the user may pin a specific, reachable and permitted base commit so **different streams start from the exact same baseline**, rather than inherit one another's changes.

## Input Composition and Authority

The inner task/skill and the outer lifecycle are different responsibilities.

1. **User-defined task**: interpret the supplied prompt, intended behavior, boundaries and evidence. Do not invent a product-improvement search, assess five alternatives, or redefine the requested objective.
2. **Read-only review skill**: run its analysis **read-only** against the selected stream snapshot, then use concrete, actionable findings as *input* to a separately authorized execution step. The review itself remains read-only. Do not edit, rewrite, automatically alter activation, or import review-skill rules into this orchestration beyond what their invocation requires. Do not read unrelated review skills.
3. **Other compatible skill**: preserve its domain-specific assignment and protections. If its execution has side effects, defer them until after the issue-only baseline and early remote publication gates; do not let an inner skill create its own conflicting branch/issue lifecycle, merge, deploy, or escape this stream. If its work cannot be separated into a read-only preparation followed by bounded execution, stop and report the incompatibility rather than bypass gates.
4. **One reviewable step**: take one cohesive, justified assignment or bounded related set of findings; do not require a first-viable-candidate contest or turn every finding into unrelated edits. Clarify only consequential ambiguity.
5. **No semantic duplicate screening**: do **not** search prior issues, PRs or branches to reject/skip work merely because the same outcome is already done or another run is comparable. Independent streams may deliberately repeat the same task. Technical Git ref collisions, ownership conflicts, active worktrees, safety hazards and overwrites still must be checked.
6. Preserve authorization, protected product contracts, user data, privacy/security, other agents' work and actual repository constraints. A review finding alone is not permission for breaking changes or unrelated edits.

## Step Lifecycle

| Stage | Required outcome |
| --- | --- |
| 1. Resolve | Determine **new vs continued stream**, target repository/ref/base, authorized task and a single reviewable step |
| 2. Materialize | Fresh remote refs; create or safely re-create the local stream branch and a dedicated linked worktree from the correct SHA |
| 3. Observe | Run read-only task preparation/review against **this stream snapshot**; define change and acceptance criteria; no product edits |
| 4. Record and publish intent | Establish primary issue; **issue-only baseline commit** for versioned issues; early remote push of the stream head, even on resumed streams |
| 5. Implement | Apply only the step's scoped work in the linked worktree, with honest, separately checkpointed scope decisions |
| 6. Verify | Relevant tests, compatibility, actual behavior and remaining uncertainty |
| 7. Close and publish | Last dedicated issue-status commit (`Done` or `Blocked`), final branch push, independent remote-head confirmation |
| 8. Clean and hand off | Safe non-forced linked-worktree removal, then remove **only this step's materialized local branch** after confirming remote identity and SHA |

On a new stream, there may be no remote ref until the issue-baseline publication gate; in a resumed stream, the existing remote ref is already durable but **the current step's new issue and baseline must still be published before code changes**.

A finding-free review or a justified decision not to change anything **before a new primary issue exists** may return **No work** for that step, with safe cleanup of an unused unpublished setup. Do not invent a cosmetic edit or issue. A pre-existing stream remains intact. Once a step's issue exists, preserve and truthfully close or hand off **that step** under the protocol; never silently discard it.

## Non-Negotiable Invariants

- **One stream, many steps; one primary issue per real step.** Each step is closed separately; the stream remains resumable after local cleanup. Do not use an earlier step's `Done` issue for later changes.
- The remote stream ref, not conversation memory, local directory or issue filename alone, is the durable Git history. A conversation may retain the active stream pointer; explicit ref/ID is required if that context is missing or ambiguous.
- Only the designated linked worktree may receive scoped step edits. Never use the invoking checkout or clean/switch/reset another person's work.
- Keep original issue intent, material decision changes and implementation commits reviewable in time order; never rewrite history to hide changed decisions. Record evidence accurately; verification is not proof of real-world value.
- Before any product edit, verify **this step's durable issue**, issue-only baseline commit where relevant and successful early publication of the new/resumed remote branch tip. Any remote publication failure is a stop, not permission to continue locally.
- After verification or a concrete blocker, commit and publish the honest `Done` or `Blocked` handoff; verify the **actual remote HEAD**. Only then attempt safe local cleanup; preserve valuable local artifacts on any uncertainty or failure.
- Never auto-merge, create a PR by default, delete a remote stream branch, force-push, introduce global coordination locks, conduct semantically motivated duplicate work searches, or claim a successful publication/cleanup without verification.
- Explicitly distinguish **step completed**, **remote published**, **local cleaned**, **stream resumable**, and **integrated**. Integration is separate and not implied by `Done`.

## Handoff

For each invoked step, report the target repository, **stream ID and readable remote ref**, whether the stream was **new or resumed**, source base SHA or resumed remote SHA, task/input source, issue/step identifier, meaningful change or `No work`, relevant verification, commit(s), publication result and final exact remote head, local worktree and feature-branch cleanup result, and `Done / Blocked / No work`. When the step is remotely published and locally cleaned, explicitly state that **the same stream can be materialized for another step** without changing its identity.

Do not report invented commands, issue IDs, commit hashes, results or guaranteed recovery from interruptions. Successful publication checkpoints reduce local dependence but do not guarantee survival of unfinished, unpublished work.
