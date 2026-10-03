---
name: review-simpler-design-alternatives
description: Use when the user requests simpler design alternatives for a selected codebase, feature, mechanism, or workflow. Perform a read-only comparison of realistic ways to achieve the same required outcomes with materially less structural complexity, from small simplifications to different solution models. Report evidence-based alternatives, trade-offs, and optional quick wins; do not implement them.
---

# Review Simpler Design Alternatives

## Purpose

Review the selected scope for materially simpler ways to achieve the same required outcomes. Challenge the existing structure rather than treating it as a constraint. Compare realistic alternatives, identify which complexity disappears rather than merely moves, and distinguish practical quick wins from larger design changes.

The existing design need not be defective. This review asks whether a simpler solution would be worthwhile, not whether the current implementation is wrong.

## Scope And Review Contract

- Resolve the review target from the user's request and immediate context. If the target remains unclear, ask rather than choosing an unrelated scope.
- Establish the required outcomes and relevant constraints from the actual implementation, contracts, usage, tests, configuration, and other available evidence. Separate verified requirements from assumptions. Removing necessary capabilities or guarantees does not count as an equivalent simplification.
- Inspect enough surrounding context to assess each alternative, but do not turn the review into an unrelated repository-wide audit. Tie recommendations to concrete source locations or other identifiable evidence in the selected scope.
- Keep files, Git state, dependencies, and external systems unchanged. Return the review in chat; do not implement proposals or run builds, tests, workflows, or probes that could change state. Later implementation requires a separate user request.

## Review Questions

Do not accept the existing structure as given. Check whether the same effect can be achieved with a substantially simpler design.

Is this genuinely a different implementation, or merely the same idea in another form?

Which complexity exists only because of the chosen structure and could disappear entirely with a different model?

How would the same capability be built as simply as possible today if the existing implementation were not a constraint?

Which simpler solution models are commonly used, and how do they achieve the same effect with fewer mechanisms, states, and special cases? Treat familiarity as a source of candidates, not evidence that an approach fits this scope.

Deliberately consider multiple possible paths. Examine small simplifications as well as fundamentally different designs, and place meaningful target designs side by side.

For each approach, check the conditions under which it fits, its strengths, and how it differs from the alternatives.

Also check whether approaches can be combined meaningfully to produce an even simpler overall solution. Do not combine mutually exclusive designs or assume individually useful changes remain useful together.

Look not merely for less code, but for a simpler structure behind the code.

Prefer a few clear mechanisms over many specialized solutions where they still satisfy the required outcomes and constraints.

Evaluate approaches in terms of simplicity gained, complexity reduced, restructuring required, and the conditions under which they are useful. Consider the complete solution: dependencies, configuration, operation, and maintenance can absorb complexity removed from local code. Merely renaming, relocating, or hiding complexity is not a structural gain.

## Recommendation Threshold

Include an alternative only when the evidence supports a concrete complexity reduction and a plausible way to preserve the required outcomes under its stated conditions. Make unresolved prerequisites explicit rather than presenting them as established facts.

Do not force multiple alternatives, combinations, or quick wins. One worthwhile alternative is sufficient; none is a valid result. Stop when the plausible alternatives have been assessed enough to explain their gains, costs, and conditions, rather than continuing to generate hypothetical redesigns.

If no worthwhile simplification is supported, state that briefly and omit the table, short report, and quick-win list. If missing evidence prevents a conclusion, state that limitation instead of implying that no opportunity exists.

## Results Table

Assign each reported area a simple reference such as `A`, `B`, or `C`. Target designs within an area receive references such as `A1`, `A2`, or `A3`, even when only one alternative qualifies.

Combinations may be referenced as `A1+A2` or `A2+B1`. Describe why the combination is compatible and useful; do not treat it as the sum of its parts by default.

Use this table for qualifying alternatives. Identify the observed structure and its evidence in the current-structure column or a concise supporting note.

| Ref | Current structure | Required outcome | Possible target design | What becomes simpler or disappears? | Simplicity gain | Change effort | Risk | Prerequisites | Trade-offs |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Describe the required outcome independently of the current implementation. Explain the concrete mechanisms, states, or special cases reduced or removed by each target design.

Use qualitative ratings: low / medium / high / very high for simplicity gain, and low / medium / high for effort and risk. Avoid artificial precision; ratings are relative estimates, not measurements or guarantees.

List multiple target designs when multiple paths are plausible, not to fill the table.

## Short Report

Refer to alternatives using their table references so statements remain easy to trace. Include only useful sections, without repeating the table in prose.

### Largest Simplifications

Name the approaches with the greatest structural gain and briefly explain why.

### Best Gain-To-Effort Ratio

Highlight approaches that provide substantial simplicity with comparatively little restructuring.

### Fundamentally Different Designs

Identify approaches that replace the current solution model rather than merely simplify its implementation.

### Useful Combinations

Show combinations where they produce a better overall solution.

### Recommendation

Name the strongest candidates by reference and briefly justify their order.

Do not force a single winner. If approaches represent different useful target designs, explain when `A1`, `A2`, or a combination such as `A1+B1` is the better choice.

## Recommended Quick Wins

When supported, finish with a numbered list of concrete changes that appear comparatively safe and worthwhile to implement. Every item must refer unambiguously to one or more table references.

These are recommendations, not an execution whitelist or a guarantee of safety. Phrase them so the user can later request a selection, for example: `Implement 1, 2, and 5.`

For each item, give a short change title prefixed by its table reference, then describe the concrete change and what becomes simpler or disappears. State any necessary ordering, dependencies, or mutually exclusive choices so the numbered list is not mistaken for one cumulative plan.

Prefer ordering by:

1. High simplicity gain.
2. Low risk.
3. Low to manageable change effort.
4. Minimal dependency on other changes.

Include only changes that are sufficiently understood and justified. Uncertain, highly invasive, or unresolved-assumption-dependent proposals remain in the comparison, not in the quick-win list. Omit this section when none qualifies.

When useful, append a compact assessment such as `Gain: high | Effort: low | Risk: low`.

The result should be a short, selectable set of next actions without losing the reasoning from the table and report.
