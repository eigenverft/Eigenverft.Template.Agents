Name: Program Main Exists
Rule: Every executable C# project must declare an explicit Main method in source code; if it is missing, create it immediately; top-level statements do not satisfy this rule.

Name: Program Main Is Async When Possible
Rule: The explicit Main method must always be declared async when possible.

Name: Program Main Has Args Array
Rule: The explicit Main method must always declare a string[] args parameter.

Name: DI Class Has Logger
Rule: If a C# class uses DI and has no logger, add a Microsoft ILogger<T>.
