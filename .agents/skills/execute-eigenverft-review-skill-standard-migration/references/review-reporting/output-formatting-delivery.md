# 5.8 Output Formatting & Delivery

**Responsibility:** Define and apply the target review skill's presentation and delivery contract. The contract must be understood during Setup so the review gathers the information it needs; this step applies it to the final response.

## Eigenverft reporting convention

For reviews with **severity-rated findings**, require a **Markdown overview table before the detailed findings**, with stable references and the severity vocabulary **Critical, High, Medium, Low**. These represent issue severity, not P1/P2 implementation priority, effort, or model confidence.

A suitable default table is:

| Ref | Severity | Concern / Proposed direction | Brief rationale |
| --- | --- | --- | --- |
| A | Medium | Concrete concern and possible improvement | Concise evidence-based reason |

The review type may add columns such as maturity, benefit, effort, or location, but should preserve fast scanability. After the table, provide details for each reference: relevant evidence, impact, reasoning, counterarguments or trade-offs, proposed direction, and meaningful uncertainty. Severity classifications must be grounded in the review's lens and basis. Do not require one finding at every severity.

## Other outcome cases

- **No supported findings:** State this clearly; omit an empty findings table and fictitious detail sections.
- **Limited or unresolved review:** Describe the material evidence or coverage gaps and distinguish them from supported findings.
- **Non-finding-oriented review:** Choose an equally explicit, efficient overview and sufficient detail; do not invent severity ratings for explanatory or verdict-only outcomes.
- **User-specific presentation:** Respect applicable language and delivery requests while retaining the explicit contracts of the chosen Eigenverft standard.

## During migration

Specify the output's required contents, optional/conditional sections, ordering, format, and channel. Check that a reader sees the central result quickly **and** can inspect enough detail to decide what to do with it. Avoid a generic "provide a clear report" instruction as the entire contract.

**Result:** The target review skill has a concrete, coherent and checkable presentation contract.