Name: PowerShell Supports Required Versions And Platforms
Rule: PowerShell code must run on Windows PowerShell 5/5.1 and on PowerShell 7 or later on Windows, macOS, and Linux.

Name: Automatic And Reserved Variables Are Not Shadowed
Rule: Parameters and local variables must not assign to or shadow PowerShell automatic or reserved variables in any casing, including PSItem, args, IsWindows, IsMacOS, IsLinux, Error, PID, LASTEXITCODE, Matches, HOME, PSBoundParameters, PSScriptRoot, and MyInvocation.

Name: Required External Commands Are Validated
Rule: If PowerShell code requires an external command, it must fail fast with a clear and actionable error when that command is unavailable.

Name: Function Verbs Are Windows PowerShell Approved
Rule: PowerShell function names must use verbs approved by Windows PowerShell 5/5.1.

Name: Primary Function Nouns Are Singular
Rule: The primary name of a PowerShell function should use a singular noun; a plural noun may be provided as an alias.

Name: Functions Do Not Support ShouldProcess
Rule: PowerShell functions must not declare SupportsShouldProcess or implement WhatIf or Confirm behavior.

Name: Parameters Do Not Bind From The Pipeline
Rule: PowerShell parameters must not use ValueFromPipeline or ValueFromPipelineByPropertyName.

Name: Policy Parameters Are Not Default True Switches
Rule: Policy and behavior parameters must not use default-true switches; represent those choices with string parameters constrained by ValidateSet instead.

Name: Functions Are Safe With Stop Error Preference
Rule: PowerShell functions must behave correctly when the caller sets ErrorActionPreference to Stop.

Name: Try Catch Adds Actionable Context
Rule: Use try/catch only when it adds value, and rethrow caught failures with concise and actionable messages.

Name: Functions Are Idempotent
Rule: PowerShell functions must be idempotent so repeated runs converge to the same state without errors or drift.

Name: Functions Have Complete Comment Based Help
Rule: Every PowerShell function except an inline helper must provide comment-based help with Synopsis, Description, Parameters, Examples, and Notes.

Name: Help Examples Are Relevant
Rule: Comment-based help examples must cover every relevant case without adding possible but nonsensical examples.

Name: PowerShell Code Is ASCII Only
Rule: PowerShell code must contain only ASCII characters.

Name: Implementations Are Lean And Reviewable
Rule: PowerShell implementations must be lean, readable, and reviewer-friendly, with only brief inline comments that help an external reviewer understand the code.

Name: C Style Ternary Operators Are Forbidden
Rule: PowerShell code must not contain the C-style ternary pattern with question mark and colon; use if and else instead.

Name: Null Is On The Left In Comparisons
Rule: Equality and inequality comparisons with null must place $null on the left side.

Name: Changes Stay Within The Requested Scope
Rule: Do not make unrequested changes to PowerShell code; report pre-existing errors at the end instead of changing them.

Name: Inline Helpers Use Local Scope And Distinct Names
Rule: Inline helper functions must use explicit local scope and a distinct collision-resistant prefix, for example function local:_Normalize-List.

Name: Inline Helpers Have Only A Brief Comment
Rule: An inline helper must have one brief descriptive comment and must not have a comment-based help block.

Name: Inline Helpers Suppress Unapproved Verb Warnings
Rule: An inline helper must place [Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs","")] between the function name and its param block.

Name: Inline Helpers Avoid Incidental Pipeline Output
Rule: Inline helpers must not emit incidental values to the pipeline and must explicitly return only their intended result.

Name: Inline Helpers Are Not Exported
Rule: Inline helpers must exist only for the duration of the outer function call and must not be exported.

Name: Inline Helpers Are Deterministic
Rule: Inline helpers must not rely on session-global state and must be deterministic for the same inputs.

Name: Functions Are StrictMode Version 3 Safe
Rule: PowerShell functions must fully comply with StrictMode version 3 when it is active before the function call.

Name: Variables Are Initialized Before Use
Rule: PowerShell code must not reference uninitialized variables, including inside interpolated strings.

Name: Object Properties Exist Before Access
Rule: PowerShell code must not reference object properties that do not exist.

Name: Core Logic Avoids Uncontrolled Dynamic Invocation
Rule: Core logic must not use dynamic invocation with uncontrolled values; normal method calls and static method calls are allowed.

Name: Array Indices Are Valid
Rule: PowerShell code must not use out-of-bounds or unresolved array indices.

Name: Collection Return Values Are Definitive
Rule: A function that returns multiple elements as one definitive collection value must return ,@(...) or return ,([type[]]@(...)) for a typed array.

Name: Backtick Line Continuation Is Forbidden
Rule: PowerShell code must not use the backtick for line continuation; keep a command on one line or use splatting or separate statements.
