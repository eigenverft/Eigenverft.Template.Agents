---
name: auto-execute-preserve-fix-rationale
description: Apply automatically when correcting defects in existing behavior, source files, scripts, configurations, pipelines, or other maintained artifacts. Preserve non-obvious, evidence-supported repair reasons through brief local comments only when doing so is safe for the actual file format and its consumers. Skip routine fixes, experiments, speculative explanations, and unsafe or uncertain comment contexts.
---

# Auto Execute Preserve Fix Rationale

Preserve important knowledge about why a corrective change is necessary, without adding routine commentary or changing the intended behavior of the affected artifact.

Apply this skill during defect correction without requiring explicit invocation. It governs whether to preserve repair rationale, not how to investigate or implement the repair.

## When to Preserve Rationale

Add a localized explanation only when all conditions hold:

- The change corrects a concrete defect or restores intended behavior rather than introducing a new requirement.
- The repair addresses an established failure condition, constraint, or unexpected interaction.
- The reason for the specific correction is not sufficiently apparent from the resulting artifact and its surrounding context.
- Losing that reason could plausibly lead a future maintainer or agent to undo, simplify, or alter the correction and reintroduce the defect.
- A comment can be added without affecting parsing, execution, validation, generation, deployment, or other processing.

Relevant cases may include edge conditions, compatibility workarounds, ordering dependencies, unusual configuration values, or external system constraints. None of these categories automatically requires a comment.

## Comment Content

- Explain the non-obvious reason or constraint, not merely what the implementation does.
- Describe the established failure condition and, when useful, what the safeguard prevents.
- Keep the explanation concise and close to the relevant change.
- State only supported facts. A confirmed observation may be documented without claiming an unverified root cause.
- Reference an existing test, issue, or specification when it adds meaningful context. Never invent references.
- Follow the surrounding language and comment conventions.

## Format and Execution Safety

- Treat comments as potentially significant until their safety is established for the actual file format, parser, toolchain, and consumers.
- Do not introduce comments into formats that prohibit them, such as standard JSON.
- Do not assume that editor support, a file extension, or a parser's optional comment support makes comments safe for every consumer.
- Do not change a file's format, extension, parser configuration, or processing rules merely to permit comments.
- Avoid comment forms or placements that could act as directives, alter generated output, interfere with tooling, or otherwise affect behavior.
- If safe comment syntax and placement cannot be established, do not add a comment.

## Boundaries

- Do not comment on ordinary, self-explanatory fixes, routine refactoring, experiments, or temporary diagnostic changes merely because they relate to a defect.
- Do not invent explanations, preserve uncertain hypotheses as facts, or add comments that merely repeat the implementation.
- If a correction makes an existing nearby comment inaccurate, update or remove that comment when safe and relevant.
- Do not expand the requested repair, alter its implementation strategy, or create separate documentation, issues, or tests solely to satisfy this skill.
- Do not force a comment when the value of preserving the rationale is uncertain.

When the criteria are not met, leave the artifact uncommented. A missing comment is preferable to an unnecessary, misleading, or behavior-changing one.
