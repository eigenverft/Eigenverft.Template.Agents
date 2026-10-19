# Per-Step Primary Issue — Durable Intent and Results

The workstream is the durable **remote branch**. An issue is a **single step's** accountable explanation of what was requested, why its work was justified, and what actually changed. Do not keep appending independent steps to one closed issue. Earlier issues and commits remain intact when later steps extend the same remote branch.

## Issue Identity and Storage

- Prefer a suitable accessible issue tracker or the repository's usable per-issue file convention. A generic todo or summary document is not automatically a lifecycle-managed issue.
- If the repository has neither usable tracker nor per-issue convention and permits issue files, use:
  - Initial: `issues/open/<topic>-<stream-id>-sNNN.md`
  - Verified: `issues/done/<same-filename>`
  - Blocked: `issues/blocked/<same-filename>`
  - Honor existing issue roots, naming conventions and status directories when suitable, instead of creating a second tracking system.
- `<stream-id>` stays constant for that remote stream (new streams use `<YYDDMM>-<N>` with the number allocated per topic/day). **Do not confuse** the stream's daily branch number `N` with the issue's `sNNN`: `sNNN` is the next unoccupied, monotonically increasing step number in **this stream**, determined from its own remotely published issues/history, not by searching semantically similar tasks in unrelated branches.
- For an external tracker, use its actual unique issue ID. No extra versioned issue file is required solely to make a Git checkpoint. For a versioned fallback, the filename is the issue's stable identity when moved between lifecycle directories.
- A new explicit workstream with a deliberately repeated task creates a new ID, remote feature ref and step issue; repeated content is not grounds to suppress or combine those records.

## Human-Readable Opening — Required

Lead with these four direct sections (or translations). Their **descriptions concern observable change**, not the agent workflow. Name the specific situation and its consequences clearly.

### Before
What currently happens in the concrete situation, who or what encounters it, where it occurs and what practical limitation is observed? Separate confirmed behavior from hypotheses. For internal changes, explain the real operational/developer consequence rather than inventing a user impact.

### Change
What specific change is **planned** to improve that same situation? The initial issue is a commitment to bounded *intent*, not a claim that edits have already happened. At closure, update this to what actually changed while keeping decisions and deviations below reviewable.

### After
At issue creation explicitly write **"Not implemented yet"** (or equivalent). At verified closure, replace this with what demonstrably happens *in the same concrete case* as Before, and why it matters. Do not merely write "tests passed", "refactored" or "better UX".

### Evidence
At baseline, record how Before was observed and the relevant source or reproduction location. At closure, add actual checks and their observed results for After, limitations and any consumer validation still unmeasured. Passing a test is verification of tested behavior, not evidence of broad real-world benefit.

## Required Step Baseline Context

Include concise sections after the plain opening:

**Assignment and source**
- Original user prompt and relevant refinements, or exact referenced inner skill and its task input. For review-driven work, record concrete *findings selected for action* and their supplied evidence, without inventing review output or copying unrelated review instructions.
- Whether the operation is a brand-new stream or continuation. If continuation, identify the prior remote stream tip used as the base; distinguish it from an integration branch baseline.
- Explicitly distinguish user requirements, known context, observations, assumptions and limitations. Do not add a Product-Evolution-style Discover/Assess/Select scorecard or compare five imaginary candidates.

**Stream and step identification**
- Repository identity, authorized remote, full `feature/ewrks/<topic>-<stream-id>` ref and stable Stream ID.
- Initial branch base SHA for a new stream, or the remote stream HEAD SHA before this step for a continuation; source of verification.
- Step ID/issue name or external tracker ID, creation context, local linked worktree path and branch identity. Distinguish remote ref from short local name.
- Current and intended integration branch, where relevant. Integration itself is separately authorized.
- Do not claim future commit SHAs or pushes exist in the initial issue. Update known checkpoint references only after they are verified.

**Boundaries and acceptance**
- One cohesive change, included/excluded scope, observable success criteria, expected tests and affected consumer/API/data or developer contracts.
- Risks, rollback/reversibility, important unknowns and whether another skill has requirements for this specific change.
- If no credible actionable finding or no authorized scope exists **before issue creation**, do not create this issue solely to report `No work`. Report the absent step and clean unused local setup safely.

## Baseline and Decision Commit Chronology

- For a versioned issue, the **first commit of this step** contains the original issue only, without product edits. On a continued stream it follows previous steps' completed commits; it is *not* the first commit of the entire remote branch.
- Publish this step's baseline commit to the existing remote stream ref **before** any product file change. A remote branch from an earlier step is not sufficient proof that this new step's issue has been published.
- For material subsequent changes of outcome, scope boundary, authorization or acceptance, **append** the original versus new decision and reason in the **same issue**, then record a separate issue-only decision commit before dependent product edits. Keep original wording/history distinguishable, not silently overwritten.
- Reference the primary issue from meaningful implementation commits. Do not require extra administrative files, a duplicate issue, a separate policy log or a commit per trivial file edit.

## During Implementation

Record only material facts: completed behavior changes, deviations, consequential discoveries, resolved/remaining risks, verification outcomes and referenced commit IDs. Keep the issue understandable to the next human reviewer rather than a transcript of every command.

Findings from read-only review skills do not independently authorize breaking changes or unrelated improvements; the bounded selected change does. If an inner skill cannot run without bypassing required issue/worktree boundaries, document the incompatibility and make an honest Blocked handoff when the issue already exists.

## Final Step Outcome

At `Done` closure:
1. Update **Change / After / Evidence** at the top with the actual, verified outcome and any unmeasured limits.
2. State actual implementation, tests with outcomes, contract/regression checks, acknowledged residual risk and differences from baseline plan.
3. Preserve original assignment, baseline and any decision checkpoints; record meaningful implementation commit references.
4. Status `Done` means **implemented and verified**, *not* remotely published, locally cleaned or merged. The final status/issue-move commit is the **last commit of this step**, after intended product edits have been committed.
5. For versioned issues, move the same file from `open/` to `done/` in that final dedicated issue-only commit, preserving filename and history. Before its own commit exists, state that final-head publication, PR/merge and cleanup are **pending**. Report actual later verification in the final user handoff, not by adding a subsequent issue-file commit to satisfy a circular requirement.
6. For external trackers, record actual implementation and verification, then update/close the real issue only after the final remote publication and permitted cleanup are verified. No Git file move.

At `Blocked` handoff:
1. Explain exact blocker, safe work already committed, missing evidence, unsafe/unpublished state and what condition would allow resumption.
2. Preserve the same issue identity; for versioned issues, move it from `open/` to `blocked/` in a separate final issue-only status commit, then publish and verify the remote branch. For external trackers, update their existing status.
3. Do not mark a failed or unverified step Done. A published Blocked issue remains an accountable record on a still-resumable stream; it is not ready for merge.
4. If publication fails, do not assert that the remote contains the final status. Preserve recoverable local work and report the exact mismatch.

## Handoff Distinctions

Report the verified **stream remote ref and current SHA**, step issue, change and tests, status, final push, local branch/worktree cleanup and remaining risks. Say whether the **step** is Done/Blocked/No work, whether its result is published, and whether the **stream** remains available for a new step.

Avoid semantic duplicate searches, invented review findings, unsupported feedback claims, assumed remote identity and false claims of interruption recovery.
