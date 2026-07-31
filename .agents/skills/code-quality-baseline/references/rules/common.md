# Common Rule Processing

## Apply And Resolve Rules

Name: Apply And Resolve Applicable Rules
Rule: Evaluate every selected rule; when an applicable rule is not satisfied, make the smallest authorized change that satisfies it, then evaluate the rule again.

## Handle Unresolved Conflicts

Name: Unresolved Rule Conflicts Prevent Changes
Rule: Evaluate all applicable rules before changing a shared target and resolve conflicts by instruction precedence; if two or more rules remain mutually exclusive, do not make the affected change and report every conflicting rule with Change Made set to No, Status set to Conflict, and Evidence naming the other conflicting rules and the incompatible requirements.

## Report Applicable Rules

Name: Report Applicable Rule Results
Rule: Report only applicable non-common rules; do not report common workflow rules or rules that are not applicable.

Use exactly one result line per applicable rule:

`"Rule Name" "Yes" "Change Made" "Status" ReferenceFile: relative/path`

For `Conflict`, `Blocked`, and `NotVerified`, include evidence before the reference:

`"Rule Name" "Yes" "No" "Status" Evidence: "reason" ReferenceFile: relative/path`

Use `Yes` or `No` for `Change Made` and use only these status values:

- `Compliant`: The rule was already satisfied and no change was required.
- `NowCompliant`: A repository change was made for the rule and the resulting state satisfies it.
- `Conflict`: The rule is applicable but is mutually exclusive with another applicable rule of equal precedence, so no affected change was made.
- `Blocked`: The rule is applicable and does not have an unresolved rule conflict, but another constraint prevents the required change.
- `NotVerified`: The rule is applicable, but the resulting compliance cannot be established with the available verification.

`Change Made` must be `Yes` only when a repository file was actually changed to satisfy that rule. `Evidence` must identify the concrete reason and, for `Conflict`, every conflicting rule name. `ReferenceFile` must be the repository-relative path of the source file that provides the evidence or received the change.

Conflict example:

`"Program Main Should Be Private" "Yes" "No" "Conflict" Evidence: "Conflicts with rule Program Main Should Be Public: Main cannot be both private and public." ReferenceFile: path/to/Program.cs`

`"Program Main Should Be Public" "Yes" "No" "Conflict" Evidence: "Conflicts with rule Program Main Should Be Private: Main cannot be both public and private." ReferenceFile: path/to/Program.cs`
