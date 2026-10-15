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
- Planned integration target (and actual refreshed base ref/SHA where known), **local** feature branch (`feature/product-evolution-<issue>-<topic>` unless repository policy requires another prefix), and workspace-local worktree location (ignored repository-local directory preferred, accessible sibling when needed). Distinguish local branch creation from later authorized remote publication; document deviations from repository conventions.

The original baseline, intent and policy must remain distinguishable from later decisions, including if the plan changes.

## During Implementation

Track material tasks (optional for trivial work), actual modifications, unexpected observations, scope decisions, failures, and retesting. Keep it concise and decision-oriented, not a transcript of every tool call. If a change is re-scoped, append what changed and why; do not rewrite the original assignment to make an unexpected outcome appear intentional.

## Final Outcome

Include:
- Actual behavior delivered and meaningful differences from the original proposal.
- Verification evidence with command/test names and observed results; contract and regression findings.
- Validation evidence if available, or an explicit statement that expected consumer benefit remains unverified.
- Reviewable Git change-set references, integration target, feature branch and where a human can inspect them; distinguish locally committed, pushed/published, ready for review, and integrated. Do not fabricate or self-reference the eventual commit SHA inside that same not-yet-created commit; a durable issue file can reference the branch/issue/PR, with exact final SHA reported in a post-commit handoff or external tracker update.
- **Cleanup timing depends on issue storage.** For an external tracker, update the issue with the **actual verified worktree cleanup outcome after removal**. For an issue stored as a versioned repository file, record cleanup as **pending/not yet verified** before its final commit; after removing the worktree, report the actual result (or exact surviving path/blocker) in the final handoff. Do not falsely mark cleanup as complete in a pre-cleanup commit. Keep the feature branch for review.
- Residual risks, follow-ups outside the finished increment, rollback considerations.
- Final state and rationale: **Done**, **Blocked**, or **Abandoned**; if no issue was created because no candidate met the criteria, return **No change** outside the issue.

Mark Done only after acceptance criteria and required durability/traceability gates are met. Never claim to have created, published, linked, or closed an issue without tool confirmation.
