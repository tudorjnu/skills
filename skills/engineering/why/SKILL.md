---
name: why
description: "Use for 'why does X work this way', 'why we picked Y', design rationale, or 'what motivated this code'. Investigates git history, PRs, the issue tracker, ADRs, and code comments. Use /how for runtime behavior."
disable-model-invocation: true
---

# Why

Investigate the motivation and intent behind code.

`how` answers what the code does and how it works. `why` answers what forces led to its shape.

## 1. Anchor the question

State what you think the user is asking about. Identify:

- the file(s) and symbol(s) in question
- the user's question type: design rationale, rejected alternatives, edge cases, business constraint, historical accident, or broad archaeology

If the target is vague, make your best guess from context and let the user redirect.

## 2. Gather evidence in parallel

Spawn subagents to search the sources that are configured for this repo:

- **Git history**: `git log`, `git blame`, commit messages, PR numbers in merge commits
- **Issue tracker**: tickets/specs linked from commits, PRs, or `docs/agents/issue-tracker.md`
- **Long-form docs**: ADRs in `docs/adr/`, `CONTEXT.md`, `MISSION.md`, `README.md`
- **Code comments**: non-obvious comments, TODOs, and defensive code near the target

Each subagent returns findings with citations (commit hash, PR number, ticket ID, doc path, file:line). A source that returns nothing is still evidence; record that it was searched and came up empty.

## 3. Synthesize

Combine the findings into a short, confidence-calibrated answer:

- **What we know**: claims with direct citations
- **What we can infer**: claims supported by indirect evidence, phrased with "appears to", "likely", "suggests"
- **Competing hypotheses**: if the evidence fits multiple stories, present them
- **What we don't know**: gaps, searched-but-empty sources, and questions the evidence did not answer

Do not retrofit intent. If the record is thin, say so.

## 4. Present

Report back with the sections above. Keep the confidence language intact. A wrong but confident story is worse than an honest "we could not find out."
