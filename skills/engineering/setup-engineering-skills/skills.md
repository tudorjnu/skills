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

MCP servers are discovered dynamically. Do not list them statically here. At use time, check which servers are connected (`/mcp`, `pi mcp list`, or `searchTools`) and call the relevant tool. Only record persistent notes below, such as required scopes, sandbox workarounds, or unavailable servers.

- **Tracker MCP**: [name / none]. If a tracker MCP is available, prefer it over CLI commands; tracker-specific notes live in `docs/agents/issue-tracker.md`.

### Persistent notes

- [name / reason / workaround]

## Fallback

If a needed capability is not available, use the issue tracker or shell tools recorded in the other `docs/agents/` files.
