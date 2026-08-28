# Agent Skills

This repo uses skills from [tudorjnu/skills](https://github.com/tudorjnu/skills).

## Agent skills

### Starting work

- [`/init`](./skills/engineering/init/SKILL.md) when you start in a new repo.
- [`/brainstorm`](./skills/engineering/brainstorm/SKILL.md) when the user wants to build or change something and the path is unclear.
- [`/setup-engineering-skills`](./skills/engineering/setup-engineering-skills/SKILL.md) if the repo has no `AGENTS.md` or `docs/agents/` config.

### Writing style

For any prose, use [`/unslop`](./skills/helpers/unslop/SKILL.md) to strip AI patterns and add a human voice.

### Testing

Do not write tests by default. Tests are deliberate investments, not ceremony. Write them when the user asks, when the seam is clear and stable, or when using [`/tdd`](./skills/engineering/tdd/SKILL.md). Do not add tests just to satisfy a checklist.

### Manual operations

For steps only a human can do, like provisioning infrastructure, setting up secrets, or running a one-off migration, use [`/wizard`](./skills/helpers/wizard/SKILL.md).
