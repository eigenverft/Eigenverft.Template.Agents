---
name: code-quality-baseline
description: Discover main-product source-code languages by file extension and load every applicable rule file before creating, modifying, or reviewing product code.
---

# Code Quality Baseline

## Overview

Use this skill as a generic dispatcher for main-product source-code rules. The skill does not define language-specific coding rules itself. It discovers relevant source-code file types and loads the rule files registered for them.

## When To Use

- Creating, modifying, refactoring, or reviewing main-product code.
- Working across one or more programming or scripting languages.
- Determining which repository-provided coding rules apply to a task.

## When Not To Use

- Tasks that do not create, modify, or review code.
- Files outside a repository when no rule package is available.
- Auxiliary code used only for distribution, activation, bootstrapping, packaging, deployment, repository maintenance, or similar supporting workflows, unless the user explicitly asks to apply this baseline to it.

## Rule Package Contract

- `references/rules/index.md` is the authoritative rule catalog.
- The catalog maps normalized source-code file extensions to one or more rule files.
- The catalog may mark rule files as always applicable.
- Rule-file paths are relative to `references/rules/` unless the catalog states otherwise.
- Every reportable rule in a language-specific rule file has a stable ID and a human-readable name declared as a level-three Markdown heading in the form ``### `<rule-id>`: <Rule Name>``.
- The content after a reportable rule heading and before the next rule heading is that rule's normative definition and may use paragraphs, lists, examples, or code fences.
- Reportable rule IDs must be unique across the complete catalog. Keep an existing ID when its rule is reordered or clarified; never renumber or reuse it. Assign a new ID when adding a new rule.
- `common.md` defines shared processing, verification, and reporting behavior. It does not declare reportable rules and is exempt from the stable-ID heading format.
- Languages and rule filenames must not be hardcoded in this `SKILL.md`.
- New languages are supported by extending the catalog and adding their rule files, without changing the discovery workflow.

Repository instructions, configuration, analyzers, formatters, and established local conventions take precedence over generic rule files.

## Language And Rule Discovery

Before creating, modifying, or reviewing code:

1. Determine the repository root and the files relevant to the current task.
2. Identify the main-product source files from their actual purpose and repository references, not from directory names alone. Exclude auxiliary distribution, activation, bootstrap, packaging, deployment, and maintenance helpers unless the user explicitly includes them.
3. Read `references/rules/index.md` completely.
4. Inspect in-scope source-code filenames and collect their normalized, lowercase file extensions.
5. Identify supported languages exclusively from extensions registered in the catalog. Do not infer a language from the repository name, documentation, directory names, file contents, compiler output, or runtime metadata.
6. Ignore unregistered documentation, configuration, solution, metadata, and data-file extensions. Do not report them as missing language mappings merely because they exist in the repository.
7. Ignore `.git`, dependency directories, generated output, build output, vendored code, and binary files unless the current task explicitly targets them.
8. Select every rule file marked as always applicable.
9. Select every rule file mapped to a source-code extension affected by the current task.
10. Select additional rule files explicitly required by the catalog for mixed-language or cross-cutting changes.
11. Read every selected rule file completely before writing or reviewing code.
12. Do not load rule files for unrelated languages.

If the task does not yet identify target files, use all catalog-registered source-code extensions present in the repository until the scope becomes narrower. If the task later includes another extension, repeat the selection and read every newly applicable rule file completely.

## Missing Or Ambiguous Mappings

- Report a missing mapping only when the current task explicitly identifies an affected file as source code and its extension has no catalog entry.
- Do not report unmapped documentation, configuration, solution, metadata, data, or other non-source extensions.
- Do not invent language-specific rules or silently map an extension based on file contents.
- If a catalog entry references a missing file, report the exact missing path before writing code governed by that entry.
- If multiple catalog entries apply, use the union of their rule files and read each selected file once.

## Application

After rule discovery:

1. Evaluate and apply the selected rule files against main-product source code within the current task scope together with higher-priority repository guidance.
2. Re-evaluate the selection whenever the set of affected extensions changes.
3. Follow the processing, final-verification, and output contract in `common.md`.
