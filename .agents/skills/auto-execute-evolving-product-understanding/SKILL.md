---
name: auto-execute-evolving-product-understanding
description: Apply automatically during ordinary repository work to incrementally reconstruct product and domain understanding from information naturally encountered. Briefly review existing agent-maintained knowledge at task start, complete the requested work without documentation-driven investigation, then reflect once on meaningful new insights. Maintain compact domain clues and working hypotheses, promote supported knowledge into coherent domain documentation and a glossary, and clean up incorporated provisional records. Never invent business intent or expand the requested task.
---

# Auto Execute Evolving Product Understanding

Gradually develop and preserve a coherent understanding of a product's business meaning, terminology, processes, constraints, and relationships through ordinary repository work.

The purpose is to help future maintainers understand what the product does, how its business concepts relate, and why particular behavior matters.

This is not a code documentation, architecture inventory, or standalone domain analysis workflow.

## Knowledge Root

All documentation managed by this skill belongs exclusively under:

`docs/agent-domain-understanding/`

Use the following paths relative to that root:

- `01-domain-clues.md`
- `02-working-hypotheses.md`
- `context/glossary.md`
- `context/` for additional domain-topic documents

Keep this knowledge base separate from other documentation systems. Do not relocate, merge into, or modify unrelated project documentation merely to satisfy this skill.

## Operating Rhythm

Apply the following lightweight sequence during ordinary repository work:

1. **Orient once.** At task start, briefly review the existing knowledge maintained by this skill. Read the provisional records and skim established domain topics as needed to understand what is already known.
2. **Initialize if missing.** Create the knowledge root and minimal document skeletons when absent, unless the task explicitly prohibits repository changes.
3. **Complete the actual task.** Work normally. Do not interrupt the requested work to update documentation, investigate domain questions, or gather extra evidence for this skill.
4. **Reflect once afterward.** Review meaningful domain information naturally encountered during the completed task and compare it with existing knowledge.
5. **Update only when worthwhile.** Record new insights, reconcile evidence, promote supported conclusions, or correct existing knowledge when justified. Otherwise make no knowledge changes.

Do not turn this sequence into a separate documentation task.

The normal task always takes priority.

## Stage 1 — Domain Clues

Collect compact, meaningful fragments that may contribute to understanding the product's domain.

Possible inputs include:

- Observed product behavior and meaningful test scenarios.
- Domain terminology, concepts, and relationships.
- Relevant statements from task descriptions or developer discussions.
- Existing documentation, configuration, and domain-related implementation.
- Apparent exceptions, unexplained business constraints, or contradictions.
- Tentative interpretations suggested by the encountered information.

Capture only information with plausible value beyond the current task.

Distinguish what was observed, what someone stated, and what the agent inferred. Speculation is permitted here when clearly identified and grounded in a concrete clue.

Avoid routine technical details, trivial changes, generic possibilities, and conversation transcripts.

## Stage 2 — Working Hypotheses

Develop tentative domain understanding by connecting relevant clues.

Look for relationships between business processes, states, responsibilities, terminology, constraints, and outcomes.

A useful hypothesis explains more than an isolated observation.

- Combine clues that genuinely support a shared interpretation.
- Identify assumptions and unresolved questions.
- Retain meaningful contradictions rather than forcing consistency.
- Distinguish demonstrated system behavior from inferred business intent.
- Consider source quality and independence. Repeated implementations of the same assumption do not necessarily provide independent confirmation.
- Refine or reject earlier hypotheses when new information warrants it.

Do not invent a coherent business story simply because the fragments could fit one.

Hypotheses remain provisional until their supported conclusions can be documented responsibly.

## Stage 3 — Grounded Domain Understanding

Maintain coherent, human-readable explanations of sufficiently supported domain knowledge.

This stage is the primary documentation intended for the development team.

Organize explanations around business topics, processes, concepts, and their relationships rather than code structure.

Prefer connected explanations that help readers understand:

- What a domain concept or process means.
- What purpose it serves when that purpose is supported.
- How it relates to other concepts and processes.
- Which important conditions, constraints, or distinctions apply.
- What behavior is established and what remains uncertain.

Source code and tests may provide useful evidence and navigation references, but should not determine the structure of the documentation.

A supported description of existing behavior is not automatically proof of the intended business rule.

Do not present inferred motivations as confirmed domain requirements.

This stage represents grounded, maintained understanding, not immutable or infallible truth.

## Domain Vocabulary and Glossary

Maintain a domain glossary as part of Stage 3.

Its purpose is to help the team understand the product's business language, not to catalog identifiers, types, methods, or database fields.

- Define meaningful domain terms using understandable business language.
- Explain the applicable domain context when a term has different meanings in different areas.
- Preserve relevant alternative names and distinctions when supported.
- Recognize terminology conflicts or ambiguous meanings as useful provisional knowledge.
- Do not invent official terminology or assume stakeholder agreement.
- Maintain concise, independent glossary entries with source references where useful.
- Update established definitions when reliable new evidence changes their meaning or scope.

Uncertain definitions belong in the provisional stages until sufficiently supported.

The glossary helps reconstruct a shared domain vocabulary; it does not declare a Ubiquitous Language by itself.

## Knowledge Promotion and Cleanup

Treat the stages as a knowledge lifecycle rather than three permanent copies of the same information.

### Stage 1 to Stage 2

When several clues support a meaningful interpretation, consolidate them into a working hypothesis.

Preserve relevant evidence, qualifications, and open questions.

After the destination has been updated, remove clues whose useful content has been fully incorporated. Keep distinct unresolved information.

### Stage 2 to Stage 3

When a conclusion is sufficiently supported, integrate it into the appropriate domain explanation or glossary entry.

Promote only what the evidence establishes. Unresolved interpretations may remain provisional.

After successful integration, remove or reduce the corresponding working hypotheses.

### General Cleanup

- Merge duplicate provisional knowledge.
- Remove disproven or obsolete hypotheses when they no longer provide useful context.
- Preserve meaningful unresolved contradictions.
- Retain source information needed to evaluate established conclusions.
- Update or correct existing domain explanations when new reliable evidence warrants it.
- Avoid duplicating complete explanations across stages.
- Update the destination before cleaning up the source.

Stages 1 and 2 are compact working knowledge, not archives.

Stage 3 is the maintained domain knowledge base.

## Provisional Record Format

The first two stage documents use plain, line-oriented records.

Each document has one stable top-level Markdown heading followed by independent one-line entries.

Do not use tables, nested lists, multiline records, or extensive prose in these documents.

Use this general structure:

YYYY-MM-DD HH:MM:SSZ [stable-id] [kind] Claim or hypothesis. Evidence: source references.

Illustrative examples:

2026-10-08 19:39:00Z [S-a81f] [observed] Cancelled invoices retain their identifiers. Evidence: InvoiceCancellationTests.

2026-10-08 19:42:00Z [H-b29c] [inferred] Cancellation may preserve transaction history while ending the financial claim. Evidence: S-a81f; underlying reason unconfirmed.

These are examples of record structure, not claims about any actual product.

Use accurate timestamps with a timezone and distinct stable identifiers. Do not invent timestamps, source references, or supporting evidence.

Keep records concise but sufficiently meaningful to evaluate later.

For the glossary, use compact, independently editable Markdown entries.

For established domain topics, use normal explanatory Markdown prose.

## Concurrent Work and Merge Safety

Assume multiple developers and agents may update the knowledge base through different branches.

Keep changes localized and merge-friendly.

- Append new provisional records as independent lines.
- Preserve stable record identifiers and avoid unnecessary reordering.
- Do not routinely sort, reformat, or rewrite entire provisional files.
- Modify or remove only the records directly affected by an update or promotion.
- Preserve separately contributed observations and evidence when reconciling concurrent changes.
- Do not use timestamps alone to decide which conflicting knowledge is correct.
- Prefer separate topic documents when established domain explanations become substantial.
- Avoid large shared documents when natural domain-topic separation is possible.

Line-oriented records reduce merge complexity but do not guarantee conflict-free Git merges.

Do not overwrite another contributor's knowledge merely because one version is newer.

## Evidence and Knowledge Quality

Evaluate the specific conclusion supported by the available evidence rather than applying a fixed number-of-sources threshold.

One authoritative source may establish a narrow fact. Multiple weak or dependent sources may still be insufficient for a broader conclusion.

Maintain the distinction between:

- Observed or documented product behavior.
- Plausible interpretations and inferred business relationships.
- Explicitly supported business intent or requirements.

An unresolved business reason must remain unresolved, even when the corresponding system behavior is well established.

Keep evidence references as stable and useful as practical.

Never fabricate product motives, stakeholder decisions, causal explanations, or evidence.

## Scope and Safety

- This skill is secondary to the user's actual task and repository instructions.
- Do not perform additional repository searches, investigations, interviews, or code changes solely to improve domain documentation.
- Do not create documentation updates merely to demonstrate activity.
- Do not persist secrets, credentials, sensitive conversation details, or inappropriate internal information.
- Do not infer confidential business facts beyond the available evidence.
- Do not alter application behavior, test strategy, implementation scope, or delivery workflow for this skill.
- Respect read-only requests and explicit restrictions on file modifications.
- Do not independently create commits, push changes, or initiate a separate review workflow.
- When no meaningful domain insight is gained, leave the knowledge content unchanged.

The desired outcome is not growing documentation volume. It is a gradually clearer, more accurate, and better connected understanding of the product's domain.
