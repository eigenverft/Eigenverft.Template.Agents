# 2.1 Request Resolution

**Responsibility:** Interpret the actual instruction, conversation context, constraints, user-specified review mode, and relevant ambiguity.

During migration:
- Instruct the review agent to follow explicit scope, target, language, depth, and presentation requests within its authority.
- When a user specifies no narrower review target, set a **positive default**: examine the entire available project or other established review subject relevant to the skill's purpose. Do not invite arbitrary selection of an interesting small scope.
- Investigate necessary related code and dependencies even when those evidence sources lie outside a narrow target, without expanding the review's *judgment target*.
- Make a practical, disclosed assumption when safe. Ask for clarification only where the ambiguity materially prevents a responsible review.
- Keep the distinction: Request Resolution understands the request; Objective, Target, Scope, Authority, and Output Contract define its respective consequences.

**Result:** The review does not accidentally reduce coverage merely because the user omitted an explicit target.