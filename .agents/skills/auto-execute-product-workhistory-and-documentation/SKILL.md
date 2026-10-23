---
name: auto-execute-product-workhistory-and-documentation
description: "Apply automatically when doing any task involving a software product repository, including reading, exploring, planning, implementing, reviewing, debugging, testing, refactoring, and maintenance, even without a documentation request or explicit invocation. Consult this skill at task start; for completed writable work, maintain local-only dated product tracing in persistent checkouts when applicable, and useful self-contained documentation for applicable user, operations, developer, and product audiences. Prioritize the user's task, verify facts, and respect read-only restrictions."
---

# Auto Execute Product Work History and Documentation

Maintain concise local tracing of delivered work in persistent checkouts **and** useful, current product documentation as part of ordinary software work. These are separate duties: a local work-history entry shows what happened; audience documentation explains the product to its readers. Neither depends on an explicit documentation request.

**Ownership hierarchy: Product → Audience → Content.** Keep local-only work tracing at the product level (`docs/<product>/workhistory.md`); organize reader documentation under `docs/<product>/<audience>/`. Each audience's documentation is independently understandable and publishable. Prefer intentional, maintained duplication over shared-content systems or cross-audience reference resolution.

This is not a documentation-generation campaign, a full repository inventory, an activity diary, or a mandate to describe every internal implementation detail.

## Operating Contract

At task start, consult relevant existing product, audience, and applicable local work-history context without turning the request into a repository-wide audit. For each product affected by ordinary **writable** development work:

1. **Identify the product.** Reuse a fitting existing `docs/<product>/` identity. Discover a missing product boundary from delivery and consumption evidence.
2. **Evaluate all four audiences.** `user`, `operations`, `developer`, and `product` are explicit coverage checkpoints, not an open-ended menu of optional suggestions.
3. **Complete the user's task.** Determine and verify what was actually delivered before recording the outcome.
4. **Maintain audience documentation.** Establish missing applicable coverage using verified facts; update any content made inaccurate or incomplete by the work. A shared-component change may affect several products or audiences.
5. **Record the delivered work locally when applicable.** In a persistent checkout, append one short, date-and-sequence-numbered entry to each affected product's `docs/<product>/workhistory.md`, even when no audience documentation needed changing. Skip this trace for short-lived published-and-cleaned edit worktrees as specified in Section 4.
6. **Account for omissions.** If a normally required audience area or product assignment cannot be established, distinguish *not applicable*, *insufficient evidence*, and *prohibited by scope*. Never silently assume that missing documentation is unnecessary.

The user's main task always takes priority. Keep both follow-up duties proportional to the change. For read-only tasks or tasks explicitly forbidding documentation edits, do not write a history entry or change documentation; provide relevant findings only when useful. Do not create empty directories, placeholders, or invented content to manufacture compliance.

## 1. Identify the Product

A documentation product is primarily an **independently delivered and consumed software offering**. Buildable projects, solutions, executables, packages, deployments, and source directories are evidence, but none of them alone defines a product.

1. Check existing product areas under `docs/<product>/`. Reuse an established identity when it matches the actual offering, rather than creating a synonymous product.
2. If no matching product exists, discover its boundary from the current task, package or publication configuration, deployment and distribution arrangements, exposed interfaces, and observed consumption. Investigate only what is needed to make a justified decision.
3. Treat internal, statically embedded, or otherwise inseparable libraries and components as part of the offering they implement.
4. Treat separately published and independently consumed deliverables, such as a standalone NuGet package or distributable CLI, as distinct documentation products when warranted.
5. Group multiple technical outputs under one product when they together serve one independently consumed offering. A separately deployed backend is not automatically a separate product.
6. Consider all affected products when a shared component changes. If assignment is genuinely ambiguous, do not invent a product identity: use an established justified target, or report the specific unresolved boundary.

A monorepo can contain several products. A product can have several build outputs.

## 2. Establish the Target Audiences

**Use exactly these four broad audiences as the default software documentation vocabulary.** The classification depends on a reader's relationship to the *specific product*, not their profession. Combine related concerns within these areas instead of splitting into many narrow role-based trees.

| Audience | Readers and documentation responsibility | Coverage rule |
| --- | --- | --- |
| **`user`** | Consumers of the delivered product: application end users, or external developers consuming a library, SDK, CLI, or API. Explain purpose, getting started, use, interfaces, examples, constraints, and consumer troubleshooting as appropriate. | **Expected for every independently consumed product.** |
| **`operations`** | Installers, administrators, deployers, operators, and technical support. Explain setup, deployment, configuration, security administration, monitoring, recovery, and operational troubleshooting as applicable. | **Required when distinct operational or administrative responsibilities exist.** For products without them, do not invent an operations manual. |
| **`developer`** | People who develop, change, test, maintain, or architect the product itself. Explain development setup, repository entry points, tests, technical structure, architecture, and important design rationale. | **Expected for a product whose implementation is maintained in the repository.** |
| **`product`** | Product owners and product managers responsible for product intent and evolution. Explain purpose, scope, capabilities, important requirements, business rules, constraints, and supported product decisions. Not general executive reporting. | **Expected for every identifiable product.** |

### Required Coverage Decisions

- **Check all four for every affected product.** Do not use the lack of an existing directory as a reason to skip an audience.
- **Presume `user`, `developer`, and `product` apply** to software products built and maintained here. Omit one only when its purpose is genuinely inapplicable in the specific repository context, not merely because no document was written before.
- **Include `operations` whenever operational duties are meaningful.** Combine administrator, operator, deployment, and support concerns in this one audience. Do not split them by title.
- **Consolidate before splitting.** A developer integrating a published library belongs to that library's `user` audience; a developer maintaining the library belongs to its `developer` audience. Architects belong to `developer`; product owners and product managers belong to `product`.
- **Prefer the four standard names for new areas.** Preserve an established equivalent name if renaming would cause unnecessary disruption. Do not create parallel synonyms or narrower audiences merely because a specialist reader exists.
- **Treat exceptions as deliberate.** Only create an additional audience for a demonstrated need that cannot coherently fit an existing one. A new job title alone is insufficient.
- **Do not silently omit missing expected documentation.** In writable scope, provide a useful minimum document when verified material exists. When it does not, report the concrete gap briefly rather than filling it with assumptions.

## 3. Documentation Layout and Minimum Content

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
      <documentation for product owners>
```

This illustrates audience ownership, **not an instruction to create empty folders**. `workhistory.md` is a local-only product-wide work trace, not an audience publication dependency or a versioned publication file. Every created audience area must immediately contain actual, useful Markdown content. An overview or README is a reasonable entry point; neither a fixed filename nor an elaborate template is mandatory.

When first establishing an applicable audience, provide at least a clear explanation of its relationship to the product and the most important **verified** information needed to begin. Prefer these content priorities:

- **`user`:** what the product offers, how a consumer starts using it, and the most relevant usage or integration path.
- **`operations`:** what must be installed, configured, administered, or operated and the known prerequisites or safeguards.
- **`developer`:** how to locate, build, test, and safely change the product, insofar as that can be established from repository evidence.
- **`product`:** why the product exists, what it does and does not cover, and its verified capabilities or constraints.

Do not fabricate missing workflows, requirements, business intent, commands, support guarantees, or release status. If adequate source material is not available, do not publish a misleading skeleton. Identify the unresolved minimum instead.

Do not require ISO frameworks, audience registries, `product.yaml`, `audience.yaml`, metadata catalogs, diagrams, or predefined topic subdirectories. Let substantive content determine the structure *inside* each audience.

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

Treat each `docs/<product>/<audience>/` subtree as a **self-contained publication unit**:

- Readers must not need another product's or audience's documentation tree to understand essential content.
- Keep required explanations, instructions, examples, assets, and relative links within the audience subtree.
- Do not depend on shared Markdown includes, symlinks, cross-audience references, centralized fragment registries, or special build-time reference resolution for essential content.
- **Deliberate duplication is valid.** Repeat or adapt facts where this keeps independent publications clear. Preserve audience-appropriate wording.
- External links may supplement self-contained material but must not replace essential explanations.
- A duplicated fact creates a maintenance obligation: later changes to that fact must be reflected in every affected publication unit.

If authoritative documentation already exists outside this layout, do not silently relocate or replace it. Maintain it as appropriate and treat structural migration as a deliberate, separate change; do not create competing copies without a plan.

## 6. Documentation Changes Are Part of Product Changes

After completing a meaningful writable product change, **perform a documentation impact check** covering the identified product and its applicable audiences. Check actual behavioral, interface, setup, configuration, compatibility, operational, architectural, and product-scope consequences.

- **Update documentation that is made inaccurate, incomplete, or materially misleading by the change.** This applies even if the user requested only a code change, provided documentation edits are within scope.
- **Create missing baseline documentation for applicable audiences** when the repository lacks it and sufficient verified information is available. An empty documentation area is not completion.
- **Review all affected publication units**, including multiple products sharing the changed implementation. Preserve factual consistency without erasing audience differences.
- **Prefer extending a fitting existing document** over adding pages for every feature. Create a new page when the content needs an independent place to stay understandable.
- **Do not document every function, class, refactor, or trivial internal detail.** The obligation concerns useful product knowledge, not maximal file volume.
- **Do not make gratuitous changes.** When an established audience area is accurate and the task adds nothing meaningful to it, leave its files untouched.

A normal writable development task should not finish with a known, actionable documentation gap merely because documentation was not explicitly mentioned. Resolve supported gaps within the allowed scope, or explicitly identify the blocker. Do not turn this into an unlimited audit or unrelated documentation migration.

## Evidence, Priority, and Safety

- Follow explicit user and repository instructions; respect read-only work and restrictions on file changes.
- The user's primary task takes priority. Documentation duties should accompany product work, not replace it with an unrelated initiative.
- Ground statements in reliable repository, product, test, configuration, or task evidence. Distinguish observed behavior, intended requirements, and inference.
- Do not invent product boundaries, audiences, implementation behavior, business goals, or release facts.
- Do not independently commit, push, publish, or initiate a separate workflow unless authorized by the user's task.
- Do not alter application behavior or tests for documentation convenience, or persist secrets or sensitive information.
- Do not claim that evaluating an audience alone fulfills the requirement to provide documentation when it is applicable and can be written.

**Success means that completed writable product work has an accurate, concise product-scoped local trace where that trace applies; every applicable product-audience unit has a useful, evidence-grounded documentation baseline; and ordinary development keeps affected units accurate and independently publishable.**
