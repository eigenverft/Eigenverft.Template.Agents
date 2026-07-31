---
name: code-quality-baseline
description: Discover repository source-code languages by file extension and load every applicable rule file before creating, modifying, or reviewing code.
---

# Code Quality Baseline

## Overview

Use this skill as a generic dispatcher for repository source-code rules. The skill does not define language-specific coding rules itself. It discovers relevant source-code file types and loads the rule files registered for them.

## When To Use

- Creating, modifying, refactoring, or reviewing repository code.
- Working across one or more programming or scripting languages.
- Determining which repository-provided coding rules apply to a task.

## When Not To Use

- Tasks that do not create, modify, or review code.
- Files outside a repository when no rule package is available.

## Rule Package Contract

- `references/rules/index.md` is the authoritative rule catalog.
- The catalog maps normalized source-code file extensions to one or more rule files.
- The catalog may mark rule files as always applicable.
- Rule-file paths are relative to `references/rules/` unless the catalog states otherwise.
- Languages and rule filenames must not be hardcoded in this `SKILL.md`.
- New languages are supported by extending the catalog and adding their rule files, without changing the discovery workflow.

Repository instructions, configuration, analyzers, formatters, and established local conventions take precedence over generic rule files.

## Language And Rule Discovery

Before creating, modifying, or reviewing code:

1. Determine the repository root and the files relevant to the current task.
2. Read `references/rules/index.md` completely.
3. Inspect repository-owned source-code filenames and collect their normalized, lowercase file extensions.
4. Identify supported languages exclusively from extensions registered in the catalog. Do not infer a language from the repository name, documentation, directory names, file contents, compiler output, or runtime metadata.
5. Ignore unregistered documentation, configuration, solution, metadata, and data-file extensions. Do not report them as missing language mappings merely because they exist in the repository.
6. Ignore `.git`, dependency directories, generated output, build output, vendored code, and binary files unless the current task explicitly targets them.
7. Select every rule file marked as always applicable.
8. Select every rule file mapped to a source-code extension affected by the current task.
9. Select additional rule files explicitly required by the catalog for mixed-language or cross-cutting changes.
10. Read every selected rule file completely before writing or reviewing code.
11. Do not load rule files for unrelated languages.

If the task does not yet identify target files, use all catalog-registered source-code extensions present in the repository until the scope becomes narrower. If the task later includes another extension, repeat the selection and read every newly applicable rule file completely.

## Missing Or Ambiguous Mappings

- Report a missing mapping only when the current task explicitly identifies an affected file as source code and its extension has no catalog entry.
- Do not report unmapped documentation, configuration, solution, metadata, data, or other non-source extensions.
- Do not invent language-specific rules or silently map an extension based on file contents.
- If a catalog entry references a missing file, report the exact missing path before writing code governed by that entry.
- If multiple catalog entries apply, use the union of their rule files and read each selected file once.

## Application

After rule discovery:

1. Evaluate and apply the selected rule files against repository source code together with higher-priority repository guidance.
2. Re-evaluate the selection whenever the set of affected extensions changes.
3. Follow the processing, final-verification, and output contract in `common.md`.
