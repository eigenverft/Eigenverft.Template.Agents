---
name: auto-execute-product-workhistory-and-documentation
description: "Apply automatically when working in a software product repository, including exploration, planning, implementation, review, debugging, testing, maintenance, and documentation. Consult relevant documentation at task start, including during read-only work. Read-only tasks permit reading and reporting only. For tasks that permit changes, preserve applicable local work history and maintain self-contained documentation in English for user, operations, developer, product, and management audiences through task-bounded updates, creation, and consolidation. Prioritize the user's task and its authorized scope."
---

# Auto Execute Product Work History and Documentation

**Development status:** Internal beta for practical evaluation. Static package validation does not establish reliable automatic activation or documentation quality in practice.

Maintain useful, current product documentation and concise local tracing of delivered work as part of ordinary software work. These are separate duties: work history records what happened; audience documentation explains the product for future use and development. Neither depends on an explicit documentation request.

**Ownership hierarchy: Product -> Audience -> Content.** Keep local-only work tracing at `docs/<product>/workhistory.md`; organize reader documentation under `docs/<product>/<audience>/`. Each audience publication must be independently understandable. Intentional, audience-appropriate repetition is valid and creates a maintenance obligation.

Build coverage incrementally from verified knowledge. Do not turn a small task into a complete documentation campaign or produce a file for every implementation detail.

## Operating Contract

At task start, identify the affected product and consult its relevant documentation and applicable local work-history context. Use the discovery procedure in Section 6 without performing a repository-wide audit.

For ordinary **writable** product work:

1. **Identify the product.** Reuse an established product identity or determine its boundary from delivery and consumption evidence.
2. **Consider all five audiences.** Check `user`, `operations`, `developer`, `product`, and `management` for relevant knowledge and consequences. This does not require five separate investigations or five new documents.
3. **Complete the primary work.** Establish and verify its actual outcome. Documentation may be written earlier when needed for the task or when it records already confirmed knowledge; do not describe pending outcomes as delivered.
4. **Fulfill the writing triggers.** Before declaring completion, correct affected explanations, write useful missing explanations, and consolidate relevant fragmented material as required by Section 6. A shared-component change can affect several products or audiences.
5. **Record delivered work locally where applicable.** Follow Section 4, including its temporary-checkout exception. Work history never substitutes for audience documentation.
6. **Handle actual blockers explicitly.** Complete independently supported portions and identify the specific evidence, authority, product assignment, or writable-scope limitation preventing the remainder.

For an explicit documentation assignment, follow its selected topic, audiences, and requested outcome. Research may be broader when documentation is the primary task. Do not turn a request limited to one documentation area into permission to edit other areas; report material consequences outside the allowed scope.

Read-only tasks permit relevant reading and reporting, not documentation or history edits. Keep all duties proportional to the user's task. Do not create empty directories, speculative content, or bookkeeping merely to demonstrate compliance.

## 1. Identify the Product

A documentation product is primarily an **independently delivered and consumed software offering**. A project, solution, executable, package, deployment, or directory is evidence, not a sufficient definition by itself.

1. Check existing `docs/<product>/` areas and reuse a fitting identity rather than creating a synonym.
2. If the boundary is missing, use the current task, publication and delivery configuration, exposed interfaces, and actual consumption. Investigate only enough to establish the affected offering.
3. Treat internal or inseparable components as part of the offering they implement.
4. Treat separately published and independently consumed deliverables, such as a library package or distributable tool, as separate products when warranted.
5. Group technical outputs that together deliver one offering. A separately deployed backend is not automatically a separate product.
6. Consider all affected products when an implementation is shared. If ownership remains ambiguous, use a justified established target or identify the unresolved boundary; do not invent one.

A repository can contain several products, and a product can have several technical outputs. A local work-history path is only a clue to product identity; confirm the offering against shared documentation, delivery and consumption evidence, or explicit user decisions rather than treating the local path alone as authoritative.

## 2. Establish the Target Audiences

Use these **five broad audiences** as the default vocabulary. Classify readers by their relationship to this product, not their job title. One person may need several perspectives.

| Audience | Readers and documentation responsibility | Coverage expectation |
| --- | --- | --- |
| **`user`** | Product consumers, including external developers integrating a library, SDK, CLI, or API. Explain offered capabilities, use, integration, examples, constraints, and troubleshooting. | Expected for independently consumed products. |
| **`operations`** | Installers, administrators, operators, and technical support. Explain setup, deployment, configuration, monitoring, recovery, and operational safeguards. | Applicable when meaningful operational or administrative duties exist. |
| **`developer`** | People maintaining or changing the product. Explain development setup, architecture, ownership, interfaces, verification, and non-obvious implementation rationale. | Expected for implementations maintained in the repository. |
| **`product`** | Readers defining and understanding concrete product capabilities and domain behavior. Explain scope, requirements, business rules, constraints, supported product decisions, and unresolved functional questions. | Expected for identifiable products. |
| **`management`** | Readers directing the product's evolution. Explain supported vision, strategic direction, priorities, guardrails, and documented trade-offs or transitional decisions. | Consider for every product; write supported direction when a trigger applies, without inventing strategy. |

### Coverage Decisions

- Check all five perspectives for every affected product. Missing directories do not establish inapplicability or justify ignoring a writing trigger.
- Distinguish an audience being inapplicable from lacking evidence for a particular explanation. Do not invent operational duties, strategy, or product intent to populate an area.
- A library consumer belongs to that library's `user` audience; a library maintainer or architect belongs to `developer`. Product and strategic concerns remain distinct even when the same person owns both.
- Prefer the five standard names for new areas. Preserve established equivalent names when renaming would cause unnecessary disruption; do not create parallel synonyms or split audiences by job title.
- An additional audience needs a demonstrated reader need that cannot coherently fit the existing perspectives. Vision is a topic within `management`, not a sixth audience.
- Coverage is a cumulative product goal. Each ordinary task must fulfill Section 6 within its investigated subject, not establish a complete baseline for every audience. A missing overview or unrelated chapter does not prevent a useful first contribution.

## 3. Documentation Layout and First Content

Use this ownership layout for newly established documentation:

```text
docs/
  <product>/
    workhistory.md  # local-only, when applicable (see Section 4)
    user/
      <documentation for product consumers>
    operations/
      <documentation for operators, when applicable>
    developer/
      <documentation for product maintainers>
    product/
      <documentation for concrete product behavior and decisions>
    management/
      <documentation for direction, priorities, and guardrails>
```

This describes ownership, not a requirement to create empty folders. The work-history file is local-only and must not become a publication dependency.

A first document must identify the product and topic sufficiently for its audience, answer a concrete reader question, and include the verified context, prerequisites, and material limits needed to understand or act on that answer. It may cover one useful subject; do not imply comprehensive product coverage. Create the required directories together with real content.

Extend a fitting page. Give a topic its own page when no existing page can hold its explanation coherently, not merely because it is a new task or feature. Make new content findable through ordinary documentation navigation. If no entry point exists, the first useful page may serve as one; add suitable navigation as the content grows. No fixed filename or template is required.

Write all new, revised, and consolidated audience documentation in English, regardless of the conversation language or the existing document's language. When working with non-English material, translate the complete affected explanation and its necessary context while preserving meaning, qualifications, and decision status; do not expand into unrelated content merely to translate it. Preserve identifiers, commands, paths, and quotations that require their original form.

For every claim you write, revise, or absorb, preserve whether it is observed behavior, a wish, a provisional working objective, an approved decision, or an unresolved assumption. State this naturally where it matters; no compulsory per-file status schema is needed. Record user intent at the strength expressed: a tentative remark or scoped implementation request does not by itself establish an adopted product-wide requirement or strategy.

Organize by durable reader questions and workflows, not by task chronology. Integrate new knowledge into the explanation instead of accumulating dated development notes. Preserve historical rationale where it helps, with its status clear.

Do not require ISO frameworks, audience registries, `product.yaml`, `audience.yaml`, metadata catalogs, diagrams, or predefined topic subdirectories. Useful content determines the structure inside each audience.

## 4. Product Work History

Maintain **`docs/<product>/workhistory.md`** as a small, local-only trace of user requests and actually delivered outcomes for that product in persistent working checkouts. It is not versioned product documentation. This trace normally receives an entry after every completed writable product task, **even when no audience documentation needed changing**. It belongs to the product root, not to an audience subtree.

- **Short-lived checkout exception:** If the workflow performs scoped edits in a temporary worktree or equivalent disposable checkout and its handoff is designed to push/publish the changes and clean up that checkout, **skip local work-history tracing for this run**. Do not create or update `workhistory.md`, add an ignore rule solely for it, or write the trace to the invoking checkout or another persistent location. Determine this exception from the workflow design, even if its push or cleanup later fails. This exception does not affect normal audience documentation or the workflow's Git/issue lifecycle.
- **Existing trace:** If the product's `workhistory.md` already exists in a persistent checkout, append the completed work entry without rechecking ignore rules, migrating files, or performing Git bookkeeping for the trace.
- **First entry only:** If the file is missing, first check whether its path is effectively Git-ignored. Only when it is not, add `docs/*/workhistory.md` to the repository's `.gitignore` (creating `.gitignore` if needed and permitted). If the task includes a final commit/push, establish the missing ignore rule beforehand. Write the first actual history entry only after the delivered outcome is known, never as an empty placeholder. If the ignore rule cannot be established within the permitted writable scope, skip local tracing and briefly report the limitation; do not force-add the trace or modify another checkout.
- Never stage or commit `workhistory.md`. Its local convenience is not a substitute for durable Git commits or issue records.
- Prefix every entry with the **actual local calendar date of the work** in `YYYY-MM-DD` ISO format, followed by a space, `#`, and the next sequence number for **that date in that product file** (`#1`, `#2`, ...). Read existing entries to choose the next number; never write the literal placeholder `YYYY-MM-DD`.
- Keep entries very short, preferably one line. State **what the user requested** and **what was delivered**; add interpretive context only when essential to understand the outcome. Record completed facts, not intentions or predicted results.
- Use a single `## Work history` heading and simple line-oriented entries. Example structure (not a real product entry):

  `2026-06-17 #1 Request: Fix login redirect; Delivered: Corrected redirect handling and added regression coverage.`

- Append rather than rewrite history. Preserve concurrent entries; if another writer has appended in the meantime, re-read the file and choose the next available sequence. Do not renumber earlier entries or duplicate an entry when retrying the same completed task. Correct a material factual mistake locally; do not treat the file as an exhaustive changelog, conversation log, or release log.
- If the work genuinely affects multiple independently documented products, record a brief product-specific outcome in each affected product's history. Do not assign internal components their own history unless they are independently delivered products.
- Work history can mention relevant audience-documentation updates, but does not substitute for maintaining those documents. Audience publications must not depend on links to the work-history file.
- Do not record secrets, sensitive user details, raw conversations, unsupported motives, or unrelated activity. Respect read-only and explicitly restricted work. If no product can be responsibly identified, report that uncertainty rather than inventing a product path.

## 5. Independent Documentation and Publication

Treat each `docs/<product>/<audience>/` subtree, or its established equivalent, as a **self-contained publication unit**:

- Readers must not need another product's or audience's documentation to understand essential content.
- Keep essential explanations, instructions, examples, and assets within the audience publication. Do not depend on shared includes, symlinks, fragment registries, or special build-time resolution.
- **Deliberate duplication is valid.** Adapt repeated facts to their readers and keep every affected current representation consistent.
- External and cross-audience links may provide provenance or further reading, but cannot replace essential explanations.
- A source reference can establish authority without making the local explanation authoritative over that source. Summarize applicable material accurately and preserve its governing status.

When a Section 6 trigger requires a coherent explanation whose relevant material lives outside the standard layout, absorb that topic into the standard audience documentation or an established equivalent. A different path alone is not a reason to move a useful, coherent publication. Reconcile former locations and navigation while preserving their independent reader and publication roles. This bounded consolidation is part of documentation maintenance; it does not require a separate repository-wide migration request or authorize unrelated restructuring.

## 6. Required Incremental Documentation

### 6.1 Find the Existing Knowledge

At task start, read the affected product's documentation entry points and the pages relevant to the work. Include task-related README, operational, design, and decision material outside the standard layout.

If no entry point exists, inspect the product's available introduction and documentation names or headings. Search repository documentation using the affected capability, workflow, interface, configuration, component, and alternative names encountered during the task. Read credible matching passages with enough surrounding context to understand their meaning and status.

Follow references that answer the same reader question, explain a necessary prerequisite or consequence, or establish a claim's authority. Repeat targeted searches when newly discovered relevant facts or names require them. Stop expanding when remaining material concerns other questions. Do not inventory unrelated products or pursue links merely because they exist.

Use implementation, tests, configuration, and task evidence already examined to verify relevant claims. Additional investigation must resolve a concrete uncertainty needed for the selected explanation, not manufacture coverage of untouched areas.

### 6.2 Apply Mandatory Writing Triggers

The documentation subject is the behavior, interface, workflow, configuration, or decision the task changes or needs to verify, together with material prerequisites, constraints, and consequences needed to explain it. Reading a surrounding component does not make all of its contents documentation work. Do not expand into neighboring topics merely because the investigation encountered them.

Before completing writable work, documentation must be changed when any of these conditions holds within that subject:

1. **Changed accuracy:** The delivered work makes an existing explanation false, incomplete for its stated purpose, or materially misleading.
2. **Missing reusable explanation:** The task establishes a verified, reusable answer to a concrete reader question that suitable documentation does not adequately answer.
3. **Fragmented explanation:** Current supported information needed to answer the selected reader question is divided across sources, or exists only in material that does not serve that reader, and no suitable maintained audience publication explains the subject coherently. A nonstandard path alone does not satisfy this trigger.

Useful answers must support a concrete use, operation, product decision, maintenance, or verification need. Constraints, failure causes, ownership boundaries, recovery steps, and supported rationale can qualify even when behavior did not change. A first encountered but material constraint can qualify; a prior request or repeated incident is not required. Do not invent hypothetical reader questions merely to create documentation. Incidental implementation details and activity summaries alone do not.

Proportionality limits the subject and necessary explanation; it does not cancel a writing trigger inside that subject. Do not impose a fixed number of audiences or pages, or leave known triggered work undone merely because another audience was prioritized.

For each trigger, identify the audience and question being answered. This is a working decision, not a requirement to create a register or report. Check all five perspectives, but do not create several audience pages by mechanically copying the same fact.

An explicit documentation assignment is governed by its requested outcome and scope; it does not depend on a code change or a newly discovered fact to require work.

### 6.3 Write the Smallest Complete Explanation

Correct or extend a suitable standard document or established equivalent publication. If none exists, create the first or next useful page in the appropriate product-audience area now. Missing overall structure, an incomplete manual, or absent documentation for other audiences is not a reason to postpone an actionable explanation.

Supply the context, prerequisites, rules, exceptions, consequences, and supported rationale needed to answer the selected question. Keep scope honest. A standalone fragment or unexplained link is not a useful first document; a complete manual is not a prerequisite.

When information is scattered, synthesize its applicable substance into a coherent explanation for the reader. Do not copy excerpts into a pile or replace the explanation with a source list. Preserve meaningful qualifications and evidence references where they help verify authority, status, or disagreement.

When one fact affects several current audience publications or products, update their relevant representations. Keep them independently understandable without forcing identical wording or unnecessary new pages.

### 6.4 Preserve Meaning and Reconcile Former Locations

Apply Section 3's statement-status rule to all writing, including initial creation and accuracy corrections, not only consolidation.

Technical evidence can establish current behavior, including domain behavior described in `product` documentation as implemented behavior rather than an approved requirement. Approved intent, priorities, and strategic direction require evidence that actually supports that intent. Do not turn an implementation constraint into a product requirement or invent a deliberate transition merely because the code differs from a vision.

When implementation does not meet a documented requirement or decision, retain that intent with its supported status and identify the discrepancy. Correct an inaccurate account of current behavior without silently superseding the intended rule.

Resolve conflicting intent only when explicit supersession or other reliable decision evidence establishes what governs. Newer code or a newer document alone is insufficient. Write useful supported portions, state the precise unresolved disagreement, and preserve the evidence needed to resolve it.

Complete the topic's transition within the permitted writable scope:

- In former current-use documents, transfer useful unique content before replacing superseded passages with a concise pointer or necessary consistent summary. Preserve unrelated sections and relied-upon entry points; do not delete a mixed document because one section was absorbed.
- Preserve each entry document's independent publication role. Retain the self-contained introduction, prerequisites, and essential instructions its readers need; do not replace required content with links unavailable in that publication or reduce a useful entry document to a pointer merely because detailed material was absorbed.
- Update relevant navigation and known inbound references found in the focused search. Do not leave located current instructions competing with the maintained standard explanation.
- Preserve historical plans, decisions, and retrospective records with their original meaning and status. Where needed and permitted, add a scoped note pointing to current guidance instead of rewriting the historical record.
- Do not claim that local consolidation supersedes a separately governing specification or externally maintained source. For external or read-only sources, provide a self-contained account where permitted, identify relevant authority and version or date, and disclose material conflicts or synchronization limits that cannot be corrected.
- Intentional audience-specific repetition remains valid. Reconcile accidental competing guidance, not every repeated sentence or every historical reference.

### 6.5 Complete or Identify the Specific Blocker

Mandatory writing can normally wait until the primary outcome is verified. Earlier writing is required when it is needed to perform the task correctly; already confirmed knowledge may also be documented during the work. Do not record predicted outcomes as delivered facts.

Before declaring completion, check the three triggers against the outcome and knowledge obtained. Finish every triggered correction, creation, and consolidation within scope. Verify that the explanation matches its evidence, is findable, is independently understandable for its audience, and is consistent with located current representations. For consolidation, also check transferred content, old passages, relevant links, and preserved rationale.

If a triggered explanation or explicit documentation assignment lacks evidence needed to finish it, write independently useful supported portions without misleading readers about unresolved prerequisites. If no safe useful content can be supported, create no placeholder; identify the exact required question and missing evidence. Do not use unrelated uncertainty to suppress established content.

Leaving documentation unchanged is valid when no trigger holds: suitable documentation already answers the relevant questions accurately and coherently, or the task yields no missing reader-relevant knowledge. A read-only restriction, explicit scope limit, insufficient evidence, or unresolved product ownership can instead block a triggered action. Name that concrete limitation without presenting the obligation as fulfilled.

Absence of evidence for an unstated product intent or management strategy does not by itself trigger writing or create a blocker to report. This does not excuse an unresolved material conflict encountered in the selected topic or an unfulfilled explicit documentation request.

A known, supported action must not be replaced by a TODO, a work-history entry, an audience check, or a proposal to document it later. Missing folders, unchanged behavior, and incomplete overall coverage are not blockers.

Keep the no-change reasoning internal unless it helps the user. Report meaningful documentation changes and actual blockers or unresolved consequences; do not append a routine documentation compliance report to every small task.

## Evidence, Priority, and Safety

- Follow explicit user and repository instructions, writable boundaries, and read-only restrictions. The primary task takes priority; documentation work accompanies it within the authorized scope.
- Do not invent product boundaries, audiences, workflows, commands, requirements, business intent, support guarantees, or release facts to fill gaps.
- Do not alter application behavior or tests for documentation convenience, or record secrets, sensitive details, or raw conversations.
- Do not independently commit, push, publish, or start a separate workflow without authorization.
- Do not claim complete product coverage or repository-wide consistency from a bounded task. Untouched areas may remain undocumented and require later work or an explicit documentation assignment.
- These instructions define behavior when the skill is considered. Static validation or written activation rules do not demonstrate reliable loading or practical compliance by every agent environment.

**Success means that completed writable work leaves every triggered product explanation accurate, useful, findable, and independently understandable, with located competing current guidance reconciled and any remaining obligation specifically identified as blocked. Local work tracing is maintained where applicable.**
