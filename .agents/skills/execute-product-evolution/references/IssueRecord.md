# Primary Issue Record — Intent, Policy and Outcome

An issue is the **durable explanation of why the change was selected and what actually happened**, not merely a task checklist. Prefer the repository's usable issue mechanism and existing formatting. **When no suitable accessible tracker or issue-file convention exists and repository policy does not forbid one, this skill must establish a minimal versioned fallback** at `issues/open/<short-topic>-<YYMMDD>[-N].md` on the isolated feature branch, with final closure at `issues/done/<same-filename>.md`. Use the content below as the new file's format; general notes or issue-summary documents do not automatically count as a usable per-issue tracker and must not be overwritten. Do not add indexes, templates or further tracking infrastructure merely to create this one issue. Structure the content as follows, adapting headings to established local conventions where present. Do not create a separate policy report by default. **Write for a developer or reviewer trying to understand why this change is worth merging, not for a process auditor.** The product rationale comes first; the provenance, policy and Git details support it rather than replacing it.

## Product Improvement — Reviewer Summary (First)

Lead the issue with a **short, concrete explanation in product terms**, not a task list, file inventory or sequence of tool calls. Populate the *intended* outcome in the initial issue-only baseline commit; update this **same section** with the *actual* outcome in the final issue closure commit. Preserve the difference between what was expected and what was demonstrated.

- **Problem and affected people/workflow:** What currently happens, who is affected (users, operators or developers), and what observed evidence supports that claim? Describe an actual product or development experience, not just a code smell or missing test.
- **Why this matters:** What concrete friction, failure, risk or wasted effort does the current behavior cause? Why is improving it worthwhile compared with leaving it as is? For purely internal changes, explain the impact on maintainability, reliability or developer work instead of inventing end-user benefits.
- **Before → intended after:** State the change in behavior or capability a reviewer should expect. Explain why this bounded increment is a useful solution, not only which files/functions are to be modified. Make assumptions and unvalidated benefit hypotheses explicit.
- **After implementation — actual improvement:** Once verified, summarize what materially changed, which original problem it addresses, important deviations from the intended outcome, and any remaining limitation. Before implementation, mark the actual result as *pending* rather than presenting planned benefits as facts.
- **Evidence and confidence:** Point briefly to the relevant observed baseline and verification results below. Distinguish working code and passing tests from measured consumer benefit; do not assert user impact without evidence.

Keep this summary readable in a brief review glance; omit boilerplate, repeated policy labels, invented metrics or promotional claims. A technically correct change without an intelligible reason or describable improvement is **not** adequately documented for review.

## Required Pre-Implementation Content

### Understood assignment and provenance
- What request and relevant prior context were understood as authorization for this cycle?
- Why is autonomous product evolution being run, and which user-specified goals/constraints apply?
- Distinguish stated facts from reasonable assumptions.

### Effective evolution policy and pre-read selection
- Before opening any phase-policy references, the agent must determine the policy source for **each of the three phases** from user assignment and already-known context. Preserve **what was selected and why** in this issue; the issue is the durable record, not a separate policy log.
- **Discover:** selected source (`references/PolicyDiscover/Default.md`, `Balanced.md`, `Ambitious.md` or a named authorized specialization / fully specified user instruction), selection reason, effective search domain, opportunity types, audience, and source of refinements.
- **Assess:** selected source and selection reason, effective criteria, evidence thresholds, hard exclusions, and source of refinements.
- **Select & Bound:** selected source and selection reason, effective change budget, cohesion/reviewability limits, allowed consumer impact, and source of refinements.
- Record **why a non-default profile was justified** by an explicit profile invocation or unambiguous user/context instruction. If no such direction existed, record `Default.md (Conservative fallback)`. A vague improvement request does not justify loading `Balanced.md` or `Ambitious.md`.
- For a fully user-specified phase, record `Custom — no profile file read` and the governing instructions; still apply the phase's common contract. Explicit context can refine any chosen default independently.
- Distinguish explicit user request, established project/conversation context, selected preset, future specialization, and assumptions. A profile label or file name without **resolved effective criteria** is insufficient.
- If later evidence requires a policy change **before the issue exists**, first record the transition and reason in working context before reading the replacement strategy; transfer the full relevant selection history when opening the issue. **After issue creation**, append each new selection, reason, and changed boundary to the issue before loading the replacement strategy. Preserve the original selection and intent.

### Selected improvement and baseline
- Supporting pre-change evidence and relevant source references for the **reviewer summary above**, without repeating the whole product explanation.
- Decision details: why this bounded improvement was selected over credible alternatives, with evidence limits or trade-offs that do not fit in the short summary.
- Consumer groups, contractual and behavioral invariants, permissible UX changes, known compatibility risk.
- Included/excluded scope, acceptance criteria, expected verification and available rollback/mitigation.
- Date or relevant version/revision reference so future reviewers can reconstruct the *before* state.
- Planned integration target (and actual refreshed base ref/SHA where known), **local** feature branch (`feature/pevo/<short-topic>-<YYMMDD>[-N]` unless repository policy requires a different naming scheme), and workspace-local worktree location (ignored repository-local directory preferred, accessible sibling when needed). **After this initial issue record exists, push the feature branch early before implementation and verify the remote ref**; for external issues, link the published branch in the tracker when supported. Distinguish this start checkpoint from later publication of the finished branch; document deviations from repository conventions.

### Incidental Discoveries (Out of Scope)
- Include this section **only when noteworthy incidental observations actually arose** in Discover (or during the bounded work). Give each a short description, where/why it was noticed, and what remains unknown. Separate observation from speculation; do not claim unmet user demand or established value without evidence.
- These entries are **not** part of the selected improvement, acceptance criteria or implementation scope. Do not investigate, assess, prioritize, implement, or create additional issue files merely to fill this section. Keep the stable heading so a future human or specialized review skill can locate the notes in existing issues, without automatically promoting them to product opportunities.

The original baseline, intent and policy must remain distinguishable from later decisions, including if the plan changes.

## During Implementation

Track material tasks (optional for trivial work), actual modifications, unexpected observations, scope decisions, failures, and retesting. Keep it concise and decision-oriented, not a transcript of every tool call. If a change is re-scoped, append what changed and why; do not rewrite the original assignment to make an unexpected outcome appear intentional.

**Reviewable chronology:** For a versioned issue, its first Git commit must contain the **original request, selected approach, boundaries and acceptance criteria without product edits**. If the agreed direction changes materially, append the prior and new decisions with reasons and create a **separate issue-only decision commit before the implementation relying on that change**. Keep the issue identifier stable. Subsequent implementation commits cite the issue and explain the actual work and verification, so reviewers can compare what was agreed with what happened and when. For an external tracker, record the same decisions durably there before affected implementation; reference the issue in Git commits instead of adding a duplicate file. Record actual checkpoint commit IDs when available, without inventing future/self-referential hashes.

## Final Outcome

**First update the Product Improvement reviewer summary above** with the actual before/after improvement, the reason it matters, and an honest distinction between verified behavior and unmeasured hoped-for benefit. Then include supporting details here:
- Actual behavior delivered and meaningful differences from the original proposal, with enough detail to investigate the implementation.
- Verification evidence with command/test names and observed results; contract and regression findings.
- Validation evidence if available, or an explicit statement that expected consumer benefit remains unverified.
- Reviewable implementation checkpoint references, target branch, feature branch and actual test evidence; distinguish implementation verified, remotely published, ready for review and actually integrated. A versioned issue file cannot contain its own not-yet-created closure commit SHA; record the actual SHA in the final handoff.
- **Versioned issue closure is part of the last feature-branch commit.** Once implementation acceptance criteria pass and product changes are already committed, update the **same** issue file to status `Done` (meaning implementation verified, **not** integrated) with final outcome, test results, accepted scope changes and residual risks. As the **same final closure commit**, move that issue file into the existing tracker `done/` directory or `done/` under the existing issue root when no completed directory is established; preserve its identifier/history. For example `issues/open/184-topic.md` → `issues/done/184-topic.md`. Do not duplicate it. On Blocked/Abandoned results, do **not** mark Done or move to `done/`.
- **Operational facts still pending at that commit:** the remote feature branch already exists from the early issue checkpoint, but publication of **this final closure commit**, PR/merge and temporary-worktree removal occur afterward; record those as **pending/not yet verified** in the versioned issue. After the final verified push and worktree cleanup, report the actual remote ref, closure commit SHA, and cleanup result in the final handoff rather than issuing another commit or fabricating the result in the issue. For external trackers, perform closure/update after successful branch publication and cleanup; no filesystem move applies.
- Residual risks, follow-ups outside the finished increment, rollback considerations.
- Final state and rationale: **Done**, **Blocked**, or **Abandoned**; if no issue was created because no candidate met the criteria, return **No change** outside the issue.

Set a versioned issue file's `Done` status **only for implementation verified against acceptance criteria**; the final skill result is successful/Ready for Review only after the completed feature branch is published and the temporary worktree has been safely removed. Neither state means merged. Never claim to have created, published, linked, moved, or closed an issue without tool confirmation.
