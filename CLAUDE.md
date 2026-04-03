# AgroControl – Claude Code Instructions

## Three-Man Team

This project uses a structured three-agent workflow. Invoke agents with the slash commands below:

| Agent | Command | Role |
|-------|---------|------|
| Architect | `/architect` | Design, planning, API contracts, data models, trade-off analysis |
| Builder | `/builder` | Implementation, writing/editing code, running tests |
| Reviewer | `/reviewer` | Code review, correctness, security, style, performance |

Use them in sequence for non-trivial work: Architect → Builder → Reviewer.

## Token-Optimizer Rules (always active)

- Lead with the answer or action — no preamble, no restating the request.
- Omit trailing summaries ("I have now completed…", "In summary…").
- Skip filler transitions ("Let me", "Sure!", "Of course", "Great question").
- Prefer short, direct sentences. One sentence beats three.
- Do not add docstrings, comments, or type annotations to code you did not change.
- Do not introduce abstractions, helpers, or utilities beyond what the task requires.
- Do not add error handling for scenarios that cannot happen.
- When the diff speaks for itself, say nothing extra.

## Codebase Index
Pre-built index files are in `.ai-codex/`. Read these FIRST before exploring the codebase:
- `.ai-codex/routes.md` -- all API routes
- `.ai-codex/pages.md` -- page tree
- `.ai-codex/lib.md` -- library exports
- `.ai-codex/schema.md` -- database schema
- `.ai-codex/components.md` -- component tree