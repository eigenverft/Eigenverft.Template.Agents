# 2.6 Authority — Zulässige Handlungen abgrenzen

**Responsibility:** Define what actions the **reviewing agent** may perform, not how it formats its report.

During migration:
- Give review skills a clear read-only baseline: inspect authorized sources and report conclusions; do not change the reviewed project's files, test results, repository/Git state, or application behavior.
- Spell out whether running tests, builds, scripts, commands, or external services is allowed; do not infer permission from a methodological suggestion.
- Separate proposing a fix from permission to apply it. Even a well-supported finding is not execution authorization.
- If a specific review skill legitimately needs a different capability, make that intentional authority explicit and subject to the user's actual permissions.
- Keep output channel, table format, and requested language in the Output Contract, not Authority.

**Result:** The target skill's investigation can be executed without accidental side effects.