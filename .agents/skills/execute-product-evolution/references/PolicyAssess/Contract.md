# Assess — Phase Contract

This file defines the common Assess behavior for every profile and future specialization. Read this file and exactly one active strategy file from this directory before assessment.

## Objective and Output

Compare evidence-backed Discover opportunities using the effective user/context/profile criteria. Remain read-only; do not modify product files or commit to an implementation.

Inputs: discovered candidates and evidence, protected consumers/contracts, operational constraints and applicable assessment emphasis.

Output to Select & Bound: a reasoned comparative assessment, exclusions and reasons, leading candidate(s), confidence, trade-offs, dependencies and unresolved evidence gaps. Qualitative comparison is sufficient; use numbers only when grounded in data.

## Hard Eligibility Gates (not weighted)

Exclude or investigate rather than approve candidates with:
- unauthorized breaking changes to relied-upon consumer contracts or loss of essential capabilities;
- unmitigated material safety, privacy, data integrity, accessibility or workflow harms;
- irreversible or destructive effects outside granted authority;
- no plausible path to a complete, verifiable and human-reviewable increment.

Expected benefit cannot compensate for a failed hard gate. Unknown material reliance is not assumed away.

## Evaluation Dimensions

Consider relevant product/consumer value, evidence quality, compatibility and UX impact, effort and feasibility, risk and reversibility, durable simplicity and maintainability, and increment viability. State material trade-offs and uncertainty. The active strategy sets **emphasis**, not the permission boundaries.

Users may specialize criteria in natural language. Such an emphasis must not implicitly alter the Discover search domain or Select & Bound change budget. Future specialized Assess strategies must preserve the hard gates and return a comparable assessment.
