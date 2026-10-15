# Primary Issue Record — Intent, Policy and Outcome

An issue is the **durable explanation of why the change was selected and what actually happened**, not merely a task checklist. Use the repository's actual issue mechanism and existing formatting. Structure the content to include the following information, adapting headings to local conventions. Do not create a separate policy report by default.

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
- Pre-change observable situation and evidence references.
- Opportunity and why selected over other plausible candidates; expected benefit and degree of confidence.
- Consumer groups, contractual and behavioral invariants, permissible UX changes, known compatibility risk.
- Included/excluded scope, acceptance criteria, expected verification and available rollback/mitigation.
- Date or relevant version/revision reference so future reviewers can reconstruct the *before* state.
- Planned integration target (and actual refreshed base ref/SHA where known), **local** feature branch (`feature/agent-product-evolution/<area>-<topic>-<issue-id>` unless repository policy requires a different naming scheme), and workspace-local worktree location (ignored repository-local directory preferred, accessible sibling when needed). **After this initial issue record exists, push the feature branch early before implementation and verify the remote ref**; for external issues, link the published branch in the tracker when supported. Distinguish this start checkpoint from later publication of the finished branch; document deviations from repository conventions.

### Incidental Discoveries (Out of Scope)
- Include this section **only when noteworthy incidental observations actually arose** in Discover (or during the bounded work). Give each a short description, where/why it was noticed, and what remains unknown. Separate observation from speculation; do not claim unmet user demand or established value without evidence.
- These entries are **not** part of the selected improvement, acceptance criteria or implementation scope. Do not investigate, assess, prioritize, implement, or create additional issue files merely to fill this section. Keep the stable heading so a future human or specialized review skill can locate the notes in existing issues, without automatically promoting them to product opportunities.

The original baseline, intent and policy must remain distinguishable from later decisions, including if the plan changes.

## During Implementation

Track material tasks (optional for trivial work), actual modifications, unexpected observations, scope decisions, failures, and retesting. Keep it concise and decision-oriented, not a transcript of every tool call. If a change is re-scoped, append what changed and why; do not rewrite the original assignment to make an unexpected outcome appear intentional.

**Reviewable chronology:** For a versioned issue, its first Git commit must contain the **original request, selected approach, boundaries and acceptance criteria without product edits**. If the agreed direction changes materially, append the prior and new decisions with reasons and create a **separate issue-only decision commit before the implementation relying on that change**. Keep the issue identifier stable. Subsequent implementation commits cite the issue and explain the actual work and verification, so reviewers can compare what was agreed with what happened and when. For an external tracker, record the same decisions durably there before affected implementation; reference the issue in Git commits instead of adding a duplicate file. Record actual checkpoint commit IDs when available, without inventing future/self-referential hashes.

## Final Outcome

Include:
- Actual behavior delivered and meaningful differences from the original proposal.
- Verification evidence with command/test names and observed results; contract and regression findings.
- Validation evidence if available, or an explicit statement that expected consumer benefit remains unverified.
- Reviewable implementation checkpoint references, target branch, feature branch and actual test evidence; distinguish implementation verified, remotely published, ready for review and actually integrated. A versioned issue file cannot contain its own not-yet-created closure commit SHA; record the actual SHA in the final handoff.
- **Versioned issue closure is part of the last feature-branch commit.** Once implementation acceptance criteria pass and product changes are already committed, update the **same** issue file to status `Done` (meaning implementation verified, **not** integrated) with final outcome, test results, accepted scope changes and residual risks. As the **same final closure commit**, move that issue file into the existing tracker `done/` directory or `done/` under the existing issue root when no completed directory is established; preserve its identifier/history. For example `issues/open/184-topic.md` → `issues/done/184-topic.md`. Do not duplicate it. On Blocked/Abandoned results, do **not** mark Done or move to `done/`.
- **Operational facts still pending at that commit:** the remote feature branch already exists from the early issue checkpoint, but publication of **this final closure commit**, PR/merge and temporary-worktree removal occur afterward; record those as **pending/not yet verified** in the versioned issue. After the final verified push and worktree cleanup, report the actual remote ref, closure commit SHA, and cleanup result in the final handoff rather than issuing another commit or fabricating the result in the issue. For external trackers, perform closure/update after successful branch publication and cleanup; no filesystem move applies.
- Residual risks, follow-ups outside the finished increment, rollback considerations.
- Final state and rationale: **Done**, **Blocked**, or **Abandoned**; if no issue was created because no candidate met the criteria, return **No change** outside the issue.

Set a versioned issue file's `Done` status **only for implementation verified against acceptance criteria**; the final skill result is successful/Ready for Review only after the completed feature branch is published and the temporary worktree has been safely removed. Neither state means merged. Never claim to have created, published, linked, moved, or closed an issue without tool confirmation.
