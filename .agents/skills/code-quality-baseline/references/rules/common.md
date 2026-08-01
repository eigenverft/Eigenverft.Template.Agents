# Common Rule Processing

## Apply And Resolve Rules

Evaluate every selected rule against main-product source code within the current task scope and identify all applicable rules and conflicts before editing. Do not expand the scope solely to search for pre-existing violations. Then make the smallest authorized changes for non-conflicting violations and evaluate the affected rules again after all rule-driven changes are complete.

## Use Source Code As Evidence

Determine applicability and compliance from in-scope repository source code; do not use binaries, build output, reflection, decompiled code, compiler-generated metadata, or runtime metadata as rule evidence; project configuration may establish scope but does not replace source-code evidence.

## Handle Unresolved Conflicts

Evaluate all applicable rules before changing a shared target and resolve conflicts by instruction precedence; if two or more rules remain mutually exclusive, do not make the affected change and report every conflicting rule with Change Made set to No, Status set to Conflict, and Evidence naming the IDs and names of the other conflicting rules and the incompatible requirements.

## Verify Once After Rule Completion

After all applicable rules have been evaluated, all conflicts have been resolved or reported, and all authorized rule-driven changes are complete, run each required repository-declared build and test command once as the final verification when execution is authorized; do not build or test between individual rules, and do not use build or test results as a substitute for source-based rule evaluation.

## Report Applicable Rules

Report only applicable non-common rules; do not report common workflow rules or rules that are not applicable.

Report the results as one Markdown table. Use one row per applicable rule when its result is uniform. When a rule has different results across source files, use a separate row for each result and list the corresponding repository-relative paths in `ReferenceFiles`.

| Rule ID | Rule Name | Applicable | Change Made | Status | Evidence | ReferenceFiles |
| --- | --- | --- | --- | --- | --- | --- |
| `XX001` | `Rule Name` | `Yes` | `Yes` or `No` | Defined status | `—` or concrete reason | `relative/path` |

Use `Yes` or `No` for `Change Made` and use only these status values:

- `Compliant`: The rule was already satisfied and no change was required.
- `NowCompliant`: A repository change was made for the rule and the resulting state satisfies it.
- `Conflict`: The rule is applicable but is mutually exclusive with another applicable rule of equal precedence, so no affected change was made.
- `Blocked`: The rule is applicable and does not have an unresolved rule conflict, but another constraint prevents the required change.
- `NotVerified`: The rule is applicable, but the resulting compliance cannot be established with the available verification.

`Change Made` must be `Yes` only when a repository file was actually changed to satisfy that rule. Use `—` for `Evidence` when no additional explanation is required. For `Conflict`, `Blocked`, and `NotVerified`, `Evidence` must identify the concrete reason and, for `Conflict`, every conflicting rule ID and name. `ReferenceFiles` must list the repository-relative source-file path or paths that provide the evidence or received the change.

After the table, add a short `Pre-existing issues` list only when a selected rule requires reporting untouched pre-existing errors. Omit the list when there are none.

Conflict example:

| Rule ID | Rule Name | Applicable | Change Made | Status | Evidence | ReferenceFiles |
| --- | --- | --- | --- | --- | --- | --- |
| `EX001` | `Program Main Should Be Private` | `Yes` | `No` | `Conflict` | Conflicts with `EX002` (`Program Main Should Be Public`): Main cannot be both private and public. | `path/to/Program.cs` |
| `EX002` | `Program Main Should Be Public` | `Yes` | `No` | `Conflict` | Conflicts with `EX001` (`Program Main Should Be Private`): Main cannot be both public and private. | `path/to/Program.cs` |
