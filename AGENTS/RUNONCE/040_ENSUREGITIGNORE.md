# Ensure root .gitignore coverage

Ensure the repository root has a `.gitignore`. Create an empty one only when none exists. Never replace or wipe an existing `.gitignore`.

## Required ignore patterns

Ensure every pattern from this block is present in the root `.gitignore`. If the block is missing, append it once at the end, with a blank line before it when the file already has content. Do not duplicate patterns that are already present, even when surrounding comments differ. As a migration step, remove the legacy broad pattern `*[Ss][Ee][Cc][Rr][Ee][Tt]*` when it is present; it must not remain because it can hide legitimate source files whose names contain `secret`.

```gitignore
# Sensitive PowerShell and JSON file name patterns
*[Ss][Ee][Cc][Rr][Ee][Tt]*.[Pp][Ss]1
*[Ss][Ee][Cc][Rr][Ee][Tt]*.[Jj][Ss][Oo][Nn]

# Local agent instruction files
AGENTS.md
AGENTS/
.agents/**/*
```

## Project build and publish artifacts

Ensure ordinary local build and publish artifact directories are ignored. At minimum cover:

- `bin` (for example `[Bb]in/` or `**/[Bb]in/*`)
- `obj` (for example `[Oo]bj/`)
- `.vs/`
- `[Dd]ebug/` and `[Rr]elease/` in .NET / Visual Studio repositories
- root `artifacts/` when the repository produces publish or packaging output

Add only missing patterns. Keep any existing broader gitignore template intact except for the legacy broad `*[Ss][Ee][Cc][Rr][Ee][Tt]*` pattern, which must be removed during migration.

## Completion
Complete only after verifying the required patterns are present and the legacy broad `*[Ss][Ee][Cc][Rr][Ee][Tt]*` pattern is absent. Do not commit `.gitignore` changes unless the user asks to commit.
