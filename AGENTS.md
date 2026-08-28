# Agent Skills

This repo uses agent skills from [tudorjnu/skills](https://github.com/tudorjnu/skills).

## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Domain docs

[one-line summary of layout: "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### Writing style

When producing or editing prose, use the [`/unslop`](./skills/helpers/unslop/SKILL.md) skill to remove AI patterns and add human voice.

### Manual operations

For steps only a human can perform (provisioning infrastructure, setting up secrets, running one-off migrations), use the [`/wizard`](./skills/helpers/wizard/SKILL.md) skill.
