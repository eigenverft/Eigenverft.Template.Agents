# 2.7 Evaluation Lens — Betrachtungsperspektive bestimmen

**Responsibility:** State the particular perspective from which the Target is reviewed.

During migration:
- Define the relevant review dimensions, such as responsibility ownership, security, change resilience, duplication, or behavior correctness, according to the original skill's purpose.
- Name concrete relationships, signals, and questions that help the model inspect that lens.
- Avoid turning every code shape, architecture preference, or aesthetic judgment into an issue by default.
- Distinguish the *perspective* from the Review Basis: a security lens does not itself supply the system's particular security policy.

**Result:** The review agent can investigate the intended kind of concern without drifting into unrelated audits.