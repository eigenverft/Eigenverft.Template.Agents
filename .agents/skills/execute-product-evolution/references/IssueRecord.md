# Primary Issue Record — Intent, Policy and Outcome

An issue is the **durable explanation of why the change was selected and what actually happened**, not merely a task checklist. Prefer the repository's usable issue mechanism and existing formatting. **When no suitable accessible tracker or issue-file convention exists and repository policy does not forbid one, this skill must establish a minimal versioned fallback** at `issues/open/<short-topic>-<YYMMDD>[-N].md` on the isolated feature branch, with verified closure at `issues/done/<same-filename>.md` or a Blocked handoff at `issues/blocked/<same-filename>.md`. Use the content below as the new file's format; general notes or issue-summary documents do not automatically count as a usable per-issue tracker and must not be overwritten. Do not add indexes, templates or further tracking infrastructure merely to create this one issue. Structure the content as follows, adapting headings to established local conventions where present. Do not create a separate policy report by default. **Write for a developer or reviewer trying to understand why this change is worth merging, not for a process auditor.** The product rationale comes first; the provenance, policy and Git details support it rather than replacing it.

Lead every issue with the four plain headings below (or their direct equivalents in the repository's language, e.g. **Vorher / Änderung / Nachher / Nachweis**). **Name the specific thing and what happens to it.** Use direct, ordinary wording, not abstract improvement claims, a list of changed files or a log of agent activity. **Clarity matters more than length:** use however many sentences are needed to make the real difference unambiguous; do not pad with generic phrases such as "improved UX", "more robust" or "optimized workflow" without saying exactly what changed. **Before and After must describe the same concrete situation** so a developer can compare them. For internal-only changes, describe the actual developer/operational behavior or risk instead of inventing user-facing benefits.

## Before

Describe the **observed pre-change behavior or state**, where it happens, who encounters it and precisely what is wrong or inconvenient about it. Explain the practical consequence in concrete words; separate observed facts from assumptions. Do not substitute a file name or test failure for the problem it represents.

## Change

Explain **what will be done** to address that specific problem, in straightforward terms. In the initial issue-only commit this is the **planned** change. At completion, state what **was actually changed**; keep meaningful differences from the original plan traceable in the supporting decision history. Describe the mechanism only as far as it helps someone understand the resulting difference, not as a technical activity list.

## After

In the initial issue-only commit write **"Not implemented yet"** (or its equivalent in the issue's language), rather than presenting an intended improvement as a fact; the intended outcome belongs under Change and the acceptance criteria below. In the final closure commit replace this with **what demonstrably happens now** in the *same situation* described under Before, and **why that concrete difference is useful**. Mention remaining limits when relevant. Do not replace an outcome with "tests passed", "refactoring completed" or unsupported claims of measured user benefit.

## Evidence

Record the observation supporting Before and, once implemented, how the claimed After behavior was checked (relevant test or reproduction steps and observed result). State what remains unmeasured. A passing test proves a checked behavior, not automatically real-world consumer value. Keep detailed test logs, policy decisions, scope and commit references in the supporting sections below.

These headings describe the **change itself**, not the agent's workflow; no separate reviewer-summary document, fixed word count or extra reporting layer is required.

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
- Supporting pre-change evidence and relevant source references for **Before / Change / After / Evidence** above, without repeating their concrete explanation.
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

Track material tasks (optional for trivial work), actual modifications, unexpected observations, scope decisions, failures, and retesting. Keep it concise and decision-oriented, not a transcript of every tool call. If the original approach proves misguided, identify **what made it appear safe or worthwhile** and why that information was not visible at the relevant code, contract or test. Where the gap is real, explain the rejected approach and the **useful, verified clarification or protection** delivered instead; a meaningful comment, description or test can be the finished increment. Append any material change of direction and its rationale before affected implementation; never rewrite the original assignment to disguise it or add empty documentation to manufacture Done.

**Reviewable chronology:** For a versioned issue, its first Git commit must contain the **original request, selected approach, boundaries and acceptance criteria without product edits**. If the agreed direction changes materially, append the prior and new decisions with reasons and create a **separate issue-only decision commit before the implementation relying on that change**. Keep the issue identifier stable. Subsequent implementation commits cite the issue and explain the actual work and verification, so reviewers can compare what was agreed with what happened and when. For an external tracker, record the same decisions durably there before affected implementation; reference the issue in Git commits instead of adding a duplicate file. Record actual checkpoint commit IDs when available, without inventing future/self-referential hashes.

## Final Outcome

**First update Change and After above** with what was actually changed and the observable result in the same case described under Before; add the supporting test/reproduction result to Evidence. Make clear what is verified versus still assumed or unmeasured. Then include supporting details here:
- Actual behavior delivered and meaningful differences from the original proposal, with enough detail to investigate the implementation.
- Verification evidence with command/test names and observed results; contract and regression findings.
- Validation evidence if available, or an explicit statement that expected consumer benefit remains unverified.
- Reviewable implementation checkpoint references, target branch, feature branch and actual test evidence; distinguish implementation verified, remotely published, ready for review and actually integrated. A versioned issue file cannot contain its own not-yet-created closure commit SHA; record the actual SHA in the final handoff.
- **Versioned issue closure is part of the last feature-branch commit.** Once implementation acceptance criteria pass and product changes are already committed, update the **same** issue file to status `Done` (meaning implementation verified, **not** integrated) with final outcome, test results, accepted scope changes and residual risks. As the **same final closure commit**, move that issue file into the existing tracker `done/` directory or `done/` under the existing issue root when no completed directory is established; preserve its identifier/history. For example `issues/open/184-topic.md` → `issues/done/184-topic.md`. Do not duplicate it. On Blocked, do **not** mark Done or move to `done/`: preserve the issue and move it to `blocked/` as specified below.
- **Blocked handoff, not Done closure:** When the run cannot safely implement or complete required verification, record status `Blocked` in this same issue, specifying the concrete obstacle, what code or evidence is already safely committed, what remains unverified, and what must change to resume. For versioned issues, keep the original filename and move `open/<same-filename>` to `blocked/<same-filename>` in a separate issue-only status commit after safely committing useful implementation progress. Publish the same feature branch again and verify its remote tip; when publication fails, preserve local work and report that the remote still lacks this status/progress. For external trackers, update the existing issue instead of creating a repository file. This status is a resumable handoff, **not** verified or merge-ready work; an authorized later integrator must verify it before declaring Done or merging.
- **Operational facts still pending at the final issue-status commit:** the remote feature branch exists only if its early publication succeeded; publication of the **new Done closure or Blocked handoff commit**, PR/merge and worktree cleanup are not yet verified. Record them as pending, not accomplished. Report the actual remote ref, status commit SHA, push result and cleanup outcome after attempting publication, without inventing a post-cleanup issue commit. For external trackers, use the actual tracker status and report separately whether feature-branch publication and cleanup succeeded; no filesystem move applies.
- Residual risks, follow-ups outside the finished increment, rollback considerations.
- An existing issue's final state is **Done** for a verified worthwhile change, or **Blocked** when safe implementation or required verification could not be completed, with the concrete reason. A disproved original idea alone is not a blocker: first look for a real, verifiable improvement that makes the newly discovered constraint understandable or protected at its source. **No change** is a pre-issue selection result only, reported outside any issue. Never infer Done from investigation or issue-only documentation alone.

Set a versioned issue file's `Done` status **only for implementation verified against acceptance criteria**; the final skill result is successful/Ready for Review only after the completed feature branch is published and the temporary worktree has been safely removed. Neither state means merged. Never claim to have created, published, linked, moved, or closed an issue without tool confirmation.
