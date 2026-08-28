---
name: how
description: "Use for 'how does X work', code walkthroughs before changing something, and placement / ownership / layering questions like 'where should this live' or 'which module owns this'. Explains subsystem architecture and runtime flow. Use /brainstorm for what to build next; use /why for motivation."
disable-model-invocation: true
---

# How

Answer "how does X work?" questions about the codebase.

## 1. Clarify the question

State what you think the user is asking. Examples:

- "How does the rate limiter work?"
- "Walk me through what happens when a user submits a form."
- "Where should this new feature live?"

If the scope is ambiguous, say your best guess and let the user redirect.

## 2. Explore

For complex subsystems, use subagents. Split the exploration into 2-4 parallel angles so no agent duplicates work. Each angle should trace one slice end to end.

Each subagent returns:

- components found
- flow traced
- files read
- anything surprising

For simple questions, explore directly in this context.

## 3. Explain

Produce a short explanation:

- **Overview**: what it is and why it exists
- **Key concepts**: the abstractions needed to understand it
- **How it works**: the flow in prose, not pseudocode
- **Where things live**: the files and directories that matter
- **Gotchas**: non-obvious or surprising things

## 4. Critique (only when asked)

If the user asks for issues or improvements:

- Explain first.
- Spawn 2-3 critics in parallel, each reading the same files.
- As the lead, categorize findings: **act on**, **consider**, **noted**, **dismissed**.
- Present the verdict below the explanation.
