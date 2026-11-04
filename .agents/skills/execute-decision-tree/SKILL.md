---
name: execute-decision-tree
description: Use when the user requests a decision tree, explores alternatives for an unresolved issue, requirement, or problem, or continues an existing decision tree through a selection. Investigate existing context before generating concrete proposals, meaningful variants, implementation boundaries, evidence-gathering options, and a recommended happy path. Support iterative selections that narrow and re-root the decision space. Read-only.
---

# Execute Decision Tree

## Overview

Explore an unresolved issue through a hierarchical tree of meaningful decisions, proposals, variants, and dependent choices.

The goal is not to maximize the number of decisions, but to identify and explore the genuinely open ones while recommending a coherent path forward.

A meaningful way forward may involve implementation, partial implementation, preserving flexibility, limiting scope, or gathering additional evidence before committing to a solution.

## Activation And Scope

Use this skill when the user requests a decision tree, explores possible decisions for an unresolved issue, or continues an existing decision tree through a selection.

Determine the subject and scope from the available context.

Keep all investigation and output strictly read-only. Do not implement changes.

If the actual open point cannot be determined, ask for clarification rather than inventing a problem.

## Context Investigation

Before constructing a decision tree, thoroughly investigate the relevant existing context.

Examine the current implementation, available documentation, established conventions, previous decisions, related solutions, and any other evidence that may clarify the issue.

Follow relevant relationships and references to understand not just what exists, but why it exists and how the parts fit together.

Distinguish between what is implemented, intended, proposed, accepted, assumed, or still unresolved.

Do not assume that any single source is complete or authoritative. Consider relevance, consistency, and possible contradictions.

Use the investigation to identify constraints, existing commitments, reusable approaches, and decisions already effectively resolved.

Do not reopen established choices without a meaningful reason.

Where the available evidence strongly favors one approach, treat it as the working baseline instead of inventing competing alternatives.

If important evidence is missing or contradictory, make the resulting uncertainty explicit.

## Core Perspective

You are an experienced problem solver who explores the meaningful solution space before committing to a direction.

Think in terms of:
- What actually remains undecided?
- Which genuinely different approaches are possible?
- Which meaningful variants exist within those approaches?
- What would each proposal commit to?
- What can reasonably remain flexible or unresolved?
- How much of the problem should be addressed now?
- Which subsequent decisions depend on earlier choices?
- What additional evidence would materially improve a decision?
- What is the most sensible direction given the existing context?

Generate concrete proposals rather than collections of abstract questions.

Proposals may differ in approach, behavior, scope, complexity, implementation, flexibility, degree of commitment, or the knowledge they aim to produce.

A proposal may provide a complete solution, a functional initial implementation, a deliberately limited partial solution, an extensible foundation with a concrete starting implementation, or a focused investigation.

Do not confuse future extensibility with the absence of an initial implementation.

Allow branches to end at meaningful stopping points even when further expansion would be possible.

Separate actual decisions from uncertain future outcomes. Where appropriate, express future choices conditionally rather than pretending their outcomes are already known.

## Decision Space Reduction

Include only decisions and alternatives that remain meaningful after considering the existing context.

Avoid:
- Reopening sufficiently established decisions.
- Repeating existing solutions as hypothetical alternatives.
- Generating superficial variations.
- Forcing multiple choices where one is clearly appropriate.
- Expanding trivial implementation details.
- Treating optional future work as mandatory.
- Artificially completing every branch to the same depth.
- Introducing investigations that are unlikely to change a decision.

Explore recursively only while further branching reveals meaningful distinctions.

Related variants may appear at the same level or beneath a shared approach, whichever better communicates their relationship.

Do not force every proposal to have the same specificity, scope, or depth.

If no material decision remains open, say so instead of constructing an artificial tree.

## Implementation Scope And Boundaries

A proposal does not have to resolve the entire issue or represent the final possible implementation.

Explore meaningful differences in implementation scope, initial defaults, extensibility, and commitment boundaries.

A proposal may represent:
- A complete solution.
- A deliberately limited partial implementation.
- A functional initial implementation with a concrete default.
- An extensible implementation with only its initial variant implemented.
- A staged solution that postpones selected capabilities.
- A deliberate stopping point beyond which further work is optional.

Treat implementation boundaries as legitimate alternatives, not necessarily as incomplete decision trees.

An extensible approach can already include a concrete working implementation. Do not mistake replaceability for an unresolved initial implementation choice.

Distinguish between what would be implemented now, what remains unmet, and what is intentionally deferred or optional.

Generate sibling proposals when different starting implementations or stopping points offer meaningfully different tradeoffs.

Do not expand every possible future extension into a mandatory subtree.

Do not confuse a partial implementation with complete fulfillment of the original requirement.

## Investigation And Evidence-Gathering Proposals

A meaningful proposal may focus on gaining knowledge rather than implementing a solution.

Treat focused investigation, research, analysis, evaluation, experimentation, or reporting as valid decision alternatives when additional evidence could materially improve a consequential choice.

Such proposals may stand alongside implementation approaches, partial solutions, or other variants at the same level.

An investigation proposal should make clear:
- What uncertainty or question it addresses.
- What evidence or understanding it aims to produce.
- What concrete outcome or deliverable is expected.
- Which decisions the findings may inform.
- Where the investigation should reasonably stop.

Keep investigations proportionate to the uncertainty, risk, and cost of choosing incorrectly.

Do not propose additional research merely because uncertainty exists. Some uncertainty is acceptable, and many decisions can reasonably be made using existing evidence.

Prefer direct decisions when sufficient evidence is already available.

Do not turn every investigation into a prerequisite for implementation.

An investigation can itself be the recommended Happy Path or its current stopping point.

Selecting an investigation commits to that inquiry, not to any particular result or subsequent implementation.

Do not treat an investigation as completed before its findings actually exist.

Once new findings become available, reassess the remaining decision space using that evidence.

Do not represent speculative research outcomes as established facts or accepted decisions.

## Recommendations

For each meaningful choice, identify the preferred proposal with `★ Recommended`.

Base recommendations on available evidence, established constraints, relevant tradeoffs, practical value, complexity, reversibility, uncertainty, and future flexibility.

Prefer approaches that fit the existing system unless there is a concrete reason to diverge.

A recommendation may deliberately limit the current implementation while preserving future options.

When evidence is insufficient for a consequential commitment, consider whether a bounded investigation offers greater value than immediately choosing an implementation.

Recommend investigation only when its expected findings are likely to change or meaningfully improve the decision.

Do not automatically favor the simplest, most complete, most flexible, or most elaborate proposal.

Briefly explain the reasoning and any significant assumptions.

Recommendations must be mutually consistent across dependent decisions.

Never treat a recommendation as an accepted user decision.

## Selection And Re-rooting

When the user selects a node by its identifier, accept that proposal and its entire ancestor path.

A selection commits only to what those proposals actually specify.

Do not automatically accept descendants, optional extensions, deferred work, unspecified implementation details, or unknown investigation outcomes.

Preserve accepted decisions by their meaning rather than their identifiers.

After a selection:

1. Treat the accepted path as established context.
2. Discard the previous tree as the active decision space.
3. Promote the selected proposal to the new root.
4. Reassess which decisions remain genuinely open.
5. Eliminate incompatible or already resolved alternatives.
6. Generate a new tree only for the remaining relevant choices.
7. Reevaluate the recommended happy path.

Renumber every new active tree from scratch.

The new root is always `A`, with descendants such as `A1`, `A2`, `A1.1`, and `A1.1.1`.

Identifiers belong only to the current tree. For example, selecting `B1.1.1` makes that proposal `A` in the next iteration.

Accepted decisions remain valid unless the user explicitly revises them.

New evidence may expose conflicts, but must not silently overturn accepted commitments.

If an accepted proposal involves investigation, preserve its intended scope and outcome without treating the investigation as already completed.

When investigation findings become available, use them to reassess the remaining decisions.

If no meaningful decisions remain within the accepted scope, consider the decision process complete without forcing further branches.

## Output

Return a hierarchical decision tree rooted in the currently unresolved issue or selected proposal.

Use concise, concrete proposal names and hierarchical identifiers.

For each meaningful alternative:
- Describe the actual proposal.
- Explain its distinguishing consequences or tradeoffs.
- Indicate relevant boundaries, assumptions, or dependencies.
- Mark the recommended option with `★ Recommended`.

Make it clear when proposals are alternative approaches, variants of the same approach, conditional choices, or evidence-gathering activities.

After the tree, include a `Happy Path` showing the coherent recommended direction.

The Happy Path may end at a partial implementation, a concrete extensible baseline, or a focused investigation.

Distinguish what would be delivered or investigated now from what remains optional, deferred, or unresolved.

For subsequent iterations, briefly summarize accepted commitments and show only the newly rooted tree.

Reference important existing evidence when it materially explains a decision, without producing an exhaustive investigation report.

Do not produce implementation plans, modify code, invent unnecessary decisions, or add unrelated sections unless explicitly requested.
