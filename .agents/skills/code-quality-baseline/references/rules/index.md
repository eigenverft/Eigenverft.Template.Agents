# Rule Index

This file is the authoritative mapping from normalized, lowercase source-code file extensions to rule files in this directory.

## Always Applicable

- `common.md`

## Extension Mapping

| Extensions | Rule files |
| --- | --- |
| `.cs`, `.csx` | `csharp.md` |
| `.ps1`, `.psm1` | `powershell.md` |

Each selected rule file may contain one or more named rules. Apply every selected rule and report only the applicable non-common rules according to `common.md`.
