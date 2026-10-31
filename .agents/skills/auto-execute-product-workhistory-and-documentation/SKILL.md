---
name: auto-execute-product-workhistory-and-documentation
description: "Apply automatically when working in a software product repository, including exploration, planning, implementation, review, debugging, testing, proofs, benchmarks, maintenance, and documentation. Read this skill at task start; no documentation request, behavior change, passing result, or final acceptance required. Consult relevant docs; for writable work, maintain local work history and self-contained English audience docs. Read-only means reading and reporting only. Respect the user's scope."
---

# Auto Execute Product Work History and Documentation

Maintain useful, current product documentation and concise local tracing of delivered work as part of ordinary software work. These are separate duties: work history records what happened; audience documentation explains the product for future use and development. Neither depends on an explicit documentation request.

**Ownership hierarchy: Product -> Audience -> Content.** Keep local-only work tracing at `docs/<product>/workhistory.md`; organize reader documentation under `docs/<product>/<audience>/`. Each audience publication must be independently understandable. Intentional, audience-appropriate repetition is valid and creates a maintenance obligation.

Build coverage incrementally from verified knowledge. Do not turn a small task into a complete documentation campaign or produce a file for every implementation detail.

## Operating Contract

At task start, identify the affected product and consult its relevant documentation and applicable local work-history context. Use the discovery procedure in Section 6 without performing a repository-wide audit.

For ordinary **writable** product work:

1. **Identify the product.** Reuse an established product identity or determine its boundary from delivery and consumption evidence.
2. **Consider all five audiences.** Check `user`, `operations`, `developer`, `product`, and `management` for relevant knowledge and consequences. This does not require five separate investigations or five new documents.
3. **Complete the primary work.** Establish and verify its actual outcome. Documentation may be written earlier when needed for the task or when it records already confirmed knowledge; do not describe pending outcomes as delivered.
4. **Fulfill the writing triggers.** Before declaring completion, correct affected explanations, write useful missing explanations, and absorb relevant isolated or scattered material into structured audience documentation as required by Section 6. A shared-component change can affect several products or audiences.
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

**Audience perspective determines the explanation; statement status determines what may be claimed.** These areas represent reader groups, not exclusive categories of facts. Describe the product for the questions, context, and level of detail each group needs. Actual capabilities, intended behavior, requirements, priorities, goals, and decisions may be relevant to several audiences. Adapt their explanations to each readership and preserve their status and authority under Section 3; do not populate every area with every type of statement.

| Audience | Readers and documentation responsibility | Coverage expectation |
| --- | --- | --- |
| **`user`** | Product consumers, including external developers integrating a library, SDK, CLI, or API. Explain offered capabilities, use, integration, examples, constraints, and troubleshooting. | Expected for independently consumed products. |
| **`operations`** | Installers, administrators, operators, and technical support. Explain setup, deployment, configuration, monitoring, recovery, and operational safeguards. | Applicable when meaningful operational or administrative duties exist. |
| **`developer`** | People maintaining or changing the product. Explain development setup, architecture, ownership, interfaces, verification, and non-obvious implementation rationale. | Expected for implementations maintained in the repository. |
| **`product`** | Readers responsible for shaping and understanding the product's capabilities and domain behavior. Explain what the product actually provides, the functional purpose supported by its behavior and context, its scope, properties, domain rules, and limits, as well as supported desired capabilities, requirements, priorities, decisions, and open functional questions. | Expected for identifiable products. |
| **`management`** | Readers assessing and steering the product's overall development. Explain what the product delivers and why it matters, consequences that inform product-level assessment or steering, risks, dependencies, and development prospects, as well as supported vision, goals, strategic direction, priorities, guardrails, and trade-offs. | Consider for every product; write when a trigger applies to this readership. |

### Coverage Decisions

- Check all five perspectives for every affected product. Missing directories do not establish inapplicability or justify ignoring a writing trigger.
- Distinguish an audience being inapplicable from lacking evidence for a particular explanation. Do not invent operational duties, strategy, or product intent to populate an area.
- A library consumer belongs to that library's `user` audience; a library maintainer or architect belongs to `developer`. Product and management readers may need different explanations of the same topic, even when one person holds both responsibilities.
- Prefer the five standard names for new areas. Preserve established equivalent names when renaming would cause unnecessary disruption; do not create parallel synonyms or split audiences by job title.
- An additional audience needs a demonstrated reader need that cannot coherently fit the existing perspectives. Vision is primarily a topic within `management`, not a sixth audience; other audiences may need its relevant context to understand their subject.
- Coverage is a cumulative product goal. Each ordinary task must fulfill Section 6 within its investigated subject, not establish a complete baseline for every audience. A missing overview or unrelated chapter does not prevent a useful first contribution.

## 3. Documentation Layout and First Content

Maintain audience documentation in the standard `docs/<product>/<audience>/` structure or an **established equivalent** as defined below. When creating a structure, use this ownership layout:

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
      <documentation for readers responsible for product capabilities and domain behavior>
    management/
      <documentation for readers assessing and steering the product's development>
```

This describes ownership, not a requirement to create empty folders. The work-history file is local-only and must not become a publication dependency.

An **established equivalent** is a coherent documentation structure that was already maintained as current product documentation before the task. It has recognizable product ownership, audience-oriented organization of related topics, and navigation for finding their explanations. It may use different paths or audience names and need not yet cover all five audiences. Correct stale passages within an otherwise maintained structure instead of automatically replacing it or creating a parallel structure.

Isolated README files, design notes, and other individual explanations do not qualify merely because they contain useful information or have readers. A directory or link list alone does not establish equivalence. Expanding an isolated file during the task does not make it an established equivalent.

A first document must identify the product and topic sufficiently for its audience, answer a concrete reader question, and include the verified context, prerequisites, and material limits needed to understand or act on that answer. It may cover one useful subject; do not imply comprehensive product coverage. Create the required directories together with real content.

Within the selected structure, extend a fitting page. Give a topic its own page when no existing page can hold its explanation coherently, not merely because it is a new task or feature. Make new content findable through ordinary documentation navigation. If no entry point exists, the first useful page may serve as one; add suitable navigation as the content grows. No fixed filename or template is required.

Write all new, revised, and consolidated audience documentation in English, regardless of the conversation language or the existing document's language. When working with non-English material, translate the complete affected explanation and its necessary context while preserving meaning, qualifications, and decision status; do not expand into unrelated content merely to translate it. Preserve identifiers, commands, paths, and quotations that require their original form.

For every claim you write, revise, or absorb, preserve whether it is observed behavior, a wish, a provisional working objective, an approved decision, a reasoned assessment or proposal, or an unresolved assumption. State this naturally where it matters; no compulsory per-file status schema is needed. Record user intent at the strength expressed: a tentative remark or scoped implementation request does not by itself establish an adopted product-wide requirement or strategy.

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

## 5. Independent Audience Documentation

Treat each `docs/<product>/<audience>/` subtree, or the corresponding audience area in an established equivalent defined in Section 3, as a **self-contained documentation unit**:

Audience documentation is repository-maintained product knowledge, not automatically software distribution content. Its inclusion in release artifacts requires explicit selection by the applicable publishing process.

- Readers must not need another product's or audience's documentation to understand essential content.
- Keep essential explanations, instructions, examples, and assets within the audience publication. Do not depend on shared includes, symlinks, fragment registries, or special build-time resolution.
- **Deliberate duplication is valid.** Adapt repeated facts to their readers and keep every affected current representation consistent.
- External and cross-audience links may provide provenance or further reading, but cannot replace essential explanations.
- A source reference can establish authority without making the local explanation authoritative over that source. Summarize applicable material accurately and preserve its governing status.

Absorb relevant supported knowledge from isolated or scattered documents into the selected audience documentation structure when Section 6 requires it. A coherent explanation in a source outside that structure does not remove this obligation. Reuse a qualifying established equivalent at its existing paths. Reconcile source locations and navigation while preserving their independent reader and publication roles. This bounded consolidation is part of documentation maintenance; it does not require a separate repository-wide migration request or authorize unrelated restructuring.

Within the selected subject, maintain independently used or published documentation surfaces alongside the structured audience documentation. Retain the information their readers need at each surface and adapt detail and wording to each publication. This is intentional duplication with a maintenance obligation; a complete explanation at one location does not automatically fulfill the other's role.

## 6. Required Incremental Documentation

### 6.1 Find the Existing Knowledge

At task start, read the affected product's documentation entry points and the pages relevant to the work. Include task-related README, operational, design, and decision material outside the standard layout.

Use these explanations to understand the product before implementation. They may provide broad orientation, describe actual behavior, or state desired behavior and requirements at different levels of specificity. Preserve their expressed status and authority under Section 3 rather than treating every description as a fixed requirement.

If no entry point exists, inspect the product's available introduction and documentation names or headings. Search repository documentation using the affected capability, workflow, interface, configuration, component, and alternative names encountered during the task. Read credible matching passages with enough surrounding context to understand their meaning and status.

Follow references that answer the same reader question, explain a necessary prerequisite or consequence, or establish a claim's authority. Repeat targeted searches when newly discovered relevant facts or names require them. Stop expanding when remaining material concerns other questions. Do not inventory unrelated products or pursue links merely because they exist.

Use implementation, tests, configuration, and task evidence already examined to verify relevant claims. Additional investigation must resolve a concrete uncertainty needed for the selected explanation, not manufacture coverage of untouched areas.

### 6.2 Apply Mandatory Writing Triggers

The documentation subject is the behavior, interface, workflow, configuration, or decision the task establishes, changes, or needs to verify, together with material prerequisites, constraints, and consequences needed to explain it. Reading a surrounding component does not make all of its contents documentation work. Do not expand into neighboring topics merely because the investigation encountered them.

Include the product-related development, delivery, and operational setup established or used in the task in this subject and check it for reusable knowledge, such as repository and remote arrangements, tooling and relevant versions, and supporting infrastructure. Apply the existing writing triggers for `developer` and `operations` according to the readers' responsibilities.

Before completing writable work, documentation must be changed when any of these conditions holds within that subject:

1. **Changed accuracy:** The delivered work makes an existing explanation false, incomplete for its stated purpose, or materially misleading.
2. **Missing reusable explanation:** The task establishes a verified, reusable answer to a concrete reader question that the selected audience documentation structure does not adequately answer.
3. **Missing structured coverage or fragmented explanation:** Supported information needed to answer the selected reader question is present in isolated or scattered documents, or in material organized for another readership, while the standard audience documentation or a qualifying established equivalent does not explain the subject coherently. An adequate standalone explanation still requires absorption when this structured coverage is missing. A different path within a qualifying established equivalent does not itself trigger relocation.

Useful answers must support a concrete need for use, operation, product understanding, product decisions, overarching assessment or steering, maintenance, or verification. Capabilities, properties, constraints, failure causes, ownership boundaries, recovery steps, and supported rationale or consequences can qualify even when behavior did not change. A first encountered but material constraint can qualify; a prior request or repeated incident is not required. Do not invent hypothetical reader questions merely to create documentation. Incidental implementation details and activity summaries alone do not.

For management readers, apply the existing writing triggers to verified product knowledge and development results. Verified first availability for use or trial, or a material change in capabilities, evaluation status, or verification evidence, requires creating or updating a concise account of the supported current state when management documentation does not adequately explain it. Include material limits and supported significance where relevant; assess related results already known within the investigated subject together. Management decisions or strategic intent are not prerequisites.

Proportionality limits the subject and necessary explanation; it does not cancel a writing trigger inside that subject. Do not impose a fixed number of audiences or pages, or leave known triggered work undone merely because another audience was prioritized.

For each trigger, identify the audience and question being answered. This is a working decision, not a requirement to create a register or report. Check all five perspectives, but do not create several audience pages by mechanically copying the same fact.

An explicit documentation assignment is governed by its requested outcome and scope; it does not depend on a code change or a newly discovered fact to require work.

### 6.3 Write the Smallest Complete Explanation

Correct or extend a fitting page within the standard product-audience structure or a qualifying established equivalent (Section 3). If no such page exists, create the first or next useful page in the appropriate product-audience area now. Missing overall structure, an incomplete manual, or absent documentation for other audiences is not a reason to postpone an actionable explanation.

Build each explanation from verified task knowledge and relevant existing descriptions, selecting and framing facts to answer the reader's concrete question under Section 2 rather than merely rewording an implementation account. Supply the context, prerequisites, rules, exceptions, consequences, and supported rationale needed to answer the selected question. Keep scope honest. A standalone fragment or unexplained link is not a useful first document; a complete manual is not a prerequisite.

When absorbing information from isolated or scattered sources, synthesize its applicable substance into a coherent explanation for the reader. Do not copy excerpts into a pile or replace the explanation with a source list. Preserve meaningful qualifications and evidence references where they help verify authority, status, or disagreement.

When one fact affects several current audience publications or products, update their relevant representations. Keep them independently understandable without forcing identical wording or unnecessary new pages.

### 6.4 Preserve Meaning and Reconcile Former Locations

Apply Section 3's statement-status rule to all writing, including initial creation and accuracy corrections, not only consolidation.

Use technical evidence to explain verified capabilities, properties, behavior, and limits to any relevant audience under Section 2. Distinguish these facts from claims about adopted requirements, priorities, or strategic direction, which require evidence that supports that authority. Reasoned assessments and proposals may explain implications when their basis and material uncertainties are clear; they do not establish an adopted decision. Do not turn an implementation constraint into a product requirement or invent a deliberate transition merely because the code differs from a vision.

When implementation does not meet a documented requirement or decision, retain that intent with its supported status and identify the discrepancy. Correct an inaccurate account of current behavior without silently superseding the intended rule.

Resolve conflicting intent only when explicit supersession or other reliable decision evidence establishes what governs. Newer code or a newer document alone is insufficient. Write useful supported portions, state the precise unresolved disagreement, and preserve the evidence needed to resolve it.

Complete the topic's transition within the permitted writable scope:

- Transfer useful unique content before reconciling source passages. Replace superseded passages with a concise pointer or consistent summary only where that preserves the source's reader and publication role. Preserve unrelated sections and relied-upon entry points; do not delete a mixed document because one section was absorbed.
- Preserve independently used or published documentation surfaces. For a repository introduction, package description, or comparable entry document, maintain the self-contained explanations, prerequisites, and instructions required by its readers alongside the structured audience documentation. Adapt the detail to each publication; absorption alone does not justify removing required information or replacing it only with a link.
- Update relevant navigation and known inbound references found in the focused search. Do not leave located current instructions competing with the maintained standard explanation.
- Preserve historical plans, decisions, and retrospective records with their original meaning and status. Where needed and permitted, add a scoped note pointing to current guidance instead of rewriting the historical record.
- Do not claim that local consolidation supersedes a separately governing specification or externally maintained source. For external or read-only sources, provide a self-contained account where permitted, identify relevant authority and version or date, and disclose material conflicts or synchronization limits that cannot be corrected.
- Intentional audience-specific and publication-specific repetition remains valid and must be maintained where affected. Reconcile accidental competing guidance, not every repeated sentence or every historical reference.

### 6.5 Complete or Identify the Specific Blocker

Mandatory writing can normally wait until the primary outcome is verified. Earlier writing is required when it is needed to perform the task correctly; already confirmed knowledge may also be documented during the work. Do not record predicted outcomes as delivered facts.

Before declaring completion, check the three triggers against the outcome and knowledge obtained. Finish every triggered correction, creation, and consolidation within scope. Verify that the explanation matches its evidence, is findable within the selected audience documentation structure, is independently understandable for its audience, and is consistent with affected independent publications and other located current representations. For consolidation, also check transferred content, old passages, relevant links, and preserved rationale.

If a triggered explanation or explicit documentation assignment lacks evidence needed to finish it, write independently useful supported portions without misleading readers about unresolved prerequisites. If no safe useful content can be supported, create no placeholder; identify the exact required question and missing evidence. Do not use unrelated uncertainty to suppress established content.

Leaving documentation unchanged is valid when no trigger holds: the selected audience documentation structure and affected independent publications already answer the relevant questions accurately and coherently, or the task yields no reader-relevant knowledge requiring correction, creation, or absorption. An adequate standalone file alone does not establish fulfilled structured coverage. A read-only restriction, explicit scope limit, insufficient evidence, or unresolved product ownership can instead block a triggered action. Name that concrete limitation without presenting the obligation as fulfilled.

Absence of evidence for an unstated product intent or management strategy does not by itself trigger writing or create a blocker to report. When another trigger applies, document supported product knowledge and reasoned assessments for those readers without inventing the missing intent. This does not excuse an unresolved material conflict encountered in the selected topic or an unfulfilled explicit documentation request.

A known, supported action must not be replaced by a TODO, a work-history entry, an audience check, or a proposal to document it later. Missing folders, unchanged behavior, and incomplete overall coverage are not blockers.

Keep the no-change reasoning internal unless it helps the user. Report meaningful documentation changes and actual blockers or unresolved consequences; do not append a routine documentation compliance report to every small task.

## Evidence, Priority, and Safety

- Follow explicit user and repository instructions, writable boundaries, and read-only restrictions. The primary task takes priority; documentation work accompanies it within the authorized scope.
- Do not invent product boundaries, audiences, workflows, commands, requirements, business intent, support guarantees, or release facts to fill gaps.
- Do not alter application behavior or tests for documentation convenience, or record secrets, sensitive details, or raw conversations.
- Do not independently commit, push, publish, or start a separate workflow without authorization.
- Do not claim complete product coverage or repository-wide consistency from a bounded task. Untouched areas may remain undocumented and require later work or an explicit documentation assignment.

**Success means that completed writable work leaves every triggered product explanation accurate, useful, findable, and independently understandable in the selected audience documentation structure, with affected independent publications maintained, located competing current guidance reconciled, and any remaining obligation specifically identified as blocked. Local work tracing is maintained where applicable.**
