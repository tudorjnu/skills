# Skills and environment

How the agent should use the capabilities it already has. Recorded by `/setup-engineering-skills` on [date]. Edit this file directly as tooling changes.

## Use skills

The agent's environment already lists every installed skill. Reach for a skill before solving the same problem from scratch.

- Call the relevant skill explicitly instead of writing its logic inline.
- Prefer narrow skills over broad prompts.
- If a skill seems close but not exact, call it and let it ask clarifying questions.

## Use subagents

- **Subagents**: [supported / not available]. When supported, delegate parallel work, independent reviews, or anything that benefits from a fresh context window.

## Use MCP servers

MCP servers observed at setup time; availability can change between sessions. Verify before relying on one, and fall back to CLI equivalents.

- **MCP servers**: [one per line — name plus one-line purpose, or "none observed"]
- **Tracker MCP**: [name / none]. If a tracker MCP is available, prefer it over CLI commands; tracker-specific notes live in `docs/agents/issue-tracker.md`.

## Fallback

If a needed capability is not available, use the issue tracker or shell tools recorded in the other `docs/agents/` files.
