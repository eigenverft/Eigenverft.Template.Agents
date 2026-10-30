# 2.9 Method Contract

**Responsibility:** Give the review agent a practical, domain-specific way to investigate relevant questions, evaluate evidence, and report well-supported conclusions.

During migration:
- For finding-oriented reviews, **begin by exploring several relevant directions** in the selected scope. Refine promising broad observations into more specific investigation questions, then assess those questions against evidence and credible alternatives. Tree-like refinement can help when one observation contains several distinct concerns; it does not require a formal tree, queue, or fixed candidate count.
- Describe which behavior, paths, sources, or invariants the agent should examine for this review's Objective and Evaluation Lens. Give concrete, positive instructions for gathering evidence and distinguishing candidates from qualified findings.
- **Encourage continued investigation across severity levels.** After finding several Critical, High, or Medium issues, keep looking for relevant Low-severity problems and other meaningful concerns within the remaining scope. Severity guides the assessment of findings, not which concerns deserve to be explored. Do not populate severity categories artificially.
- Before Reporting, reconsider material in-scope questions and credible counterarguments that could still change the assessment. Return to relevant investigation or evaluation where useful; otherwise report the supported conclusions, including zero findings, and any concrete limitations.
- Match the method's breadth and depth to the review's actual purpose. Retain effective specialist techniques and keep the work within Scope and Authority.
- Preserve known tested wording when comparing real experimental variants. Any alternative formulation is a separate design change whose effects remain to be observed.

**Result:** The target skill gives actionable guidance for a broad, thoughtful review without turning discovery or completion into a mechanical ritual.