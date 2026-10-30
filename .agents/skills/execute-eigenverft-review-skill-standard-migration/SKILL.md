---
name: execute-eigenverft-review-skill-standard-migration
description: Use when the user requests migration, restructuring, or standardization of an existing review skill toward the Eigenverft review-skill design standard. Preserve the review's specific purpose while improving workflow boundaries, request and scope handling, investigation and evaluation, and reporting contracts. Apply changes only to the authorized review-skill package; leave general skill lifecycle operations and independent read-only assessments to their respective skills.
---

# Execute Eigenverft Review Skill Standard Migration

Migrate an **existing review skill** to our evolving Eigenverft review-skill standard. This skill **edits the authorized review-skill package**; it does not perform the review itself. The standard is our design convention, not an official OpenAI standard.

## Migration procedure

1. Identify the selected review-skill package and authorized edit scope. Read its complete instructions and all behavior-changing references. Understand its purpose, current behavior, authority, method, and output.
2. Read the five chapter indexes below and their relevant detailed contracts. Migrate the target skill so that their responsibilities are represented coherently. Preserve domain-specific expertise; distinguish structural changes from intentional behavioral changes.
3. Re-read the resulting target skill and its references. Check coherence, technical validity, accurate links, and consequences of changed instructions. Run safe, available static validation; practical model runs are useful but do not prove universal behavior.
4. Report changed files, material behavior changes, deliberate deviations, validation, and remaining uncertainties. Do not commit, push, delete packages, or modify application code without separate authorization.

## Review-skill standard — chapter index

1. [01 · Skill Selection](references/skill-selection/README.md) — identity and applicability.
2. [02 · Review Setup](references/review-setup/README.md) — interpret the request and establish the review contract.
3. [03 · Investigation](references/investigation/README.md) — collect evidence and develop candidates.
4. [04 · Evaluation](references/evaluation/README.md) — validate, assess, and decide; return to Investigation when needed.
5. [05 · Review Reporting](references/review-reporting/README.md) — select results and apply the output contract.

These chapters describe the **review skill being migrated**, not five mandatory steps of the migration operation. Read the five indexes for a full migration; open their detailed references when designing the corresponding part. The phase order expresses primary responsibility, not strict linearity. Output and authority contracts remain effective across phases. Apply explicit rules where relevant, and justify purpose-specific variations instead of imposing a universal investigation algorithm.

## Change boundaries

Respect the user's scope and existing repository requirements. Preserve useful instructions, scripts, metadata, resources, and review authority unless the requested migration calls for an authorized change. The target review skill must not acquire permission to implement its own findings. Prefer positive, concrete agent instructions and keep the result practical rather than mechanically filling sections.
