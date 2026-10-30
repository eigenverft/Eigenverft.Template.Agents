# 3.3 Tree-like Candidate Refinement — Kandidaten präzisieren

**Responsibility:** Refine broad investigation directions into smaller, meaningful questions before committing to expensive validation.

During migration:
- For each promising broad candidate, ask which distinct, concrete subquestions it contains. Split only where different state, rules, behavior, access paths, ownership, security properties, or other domain-relevant concerns justify separate investigation.
- Use the *already available context* for a lightweight relevance check: **worth investigating**, **not worthwhile**, or **too broad — refine again**.
- Drop irrelevant or redundant parent directions after a concrete worthwhile branch has emerged. Do not transfer a parent's assumed defect or severity to its children.
- Retain a branch when material uncertainty makes further inspection worthwhile; uncertainty is not evidence that a concern is false.
- Refine locally as needed; do not require a printed tree, formal node statuses, a fixed depth, or exhaustive branching.
- Keep the boundary clear: **refinement identifies investigation-worthiness, not factual validity**. Source-grounded validation follows in Evaluation.

**Result:** Focused, distinct questions that can be examined with evidence.