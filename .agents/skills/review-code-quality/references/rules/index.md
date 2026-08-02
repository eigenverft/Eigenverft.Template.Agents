# Rule Index

This file is the authoritative mapping from normalized, lowercase source-code file extensions to rule files in this directory.

## Always Applicable

- `common.md`

## Extension Mapping

| Extensions | Rule files |
| --- | --- |
| `.cs`, `.csx` | `csharp.md` |
| `.ps1`, `.psm1` | `powershell.md` |

Each selected language-specific rule file may contain one or more reportable stable-ID rules using the rule package contract in `SKILL.md`. Review every selected language rule. Use `common.md` for shared processing and report only concrete violations.
