# 2.3 Target

**Responsibility:** Identify the concrete object being reviewed: project, component, source tree, diff, document, system, or other supported subject.

During migration:
- Define how the agent resolves an explicit target and its related entry points.
- For an unspecified target, reuse the broad default defined under Request Resolution.
- If the target is a diff or subcomponent, follow relevant callers, consumers, tests, or contracts as *evidence*, while keeping the findings tied to the selected subject.
- Distinguish Target (the thing judged) from Scope (the limits and perspectives of the examination).

**Result:** The review subject is identifiable and can be described in the report.