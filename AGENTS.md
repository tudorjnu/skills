# Agent Skills

This repo uses skills from [tudorjnu/skills](https://github.com/tudorjnu/skills).

## Agent skills

### Starting work

- [`/init`](./skills/engineering/init/SKILL.md) when you start in a new repo.
- [`/brainstorm`](./skills/engineering/brainstorm/SKILL.md) when the user wants to build or change something and the path is unclear.
- [`/setup-engineering-skills`](./skills/engineering/setup-engineering-skills/SKILL.md) if the repo has no `AGENTS.md` or `docs/agents/` config.

### Planning work

- [`/user-story`](./skills/engineering/user-story/SKILL.md) when turning a user need into development-ready stories with acceptance criteria.
- [`/design-direction`](./skills/engineering/design-direction/SKILL.md) when creating a visual direction before building or reshaping UI.
- [`/to-spec`](./skills/engineering/to-spec/SKILL.md) when the conversation is ready to become a spec.
- [`/to-tickets`](./skills/engineering/to-tickets/SKILL.md) when breaking a spec or plan into tracer-bullet tickets.

### Architecture and design

- [`/api-design`](./skills/engineering/architecture/api-design/SKILL.md) before designing or changing any API surface.
- [`/frontend-design`](./skills/engineering/architecture/frontend-design/SKILL.md) before building or reshaping frontend UI.
- [`/rest-api-design`](./skills/engineering/architecture/rest-api-design/SKILL.md) before designing or changing REST API endpoints.

### Understanding the code

- [`/how`](./skills/engineering/how/SKILL.md) for "how does X work" or "where should this live".
- [`/why`](./skills/engineering/why/SKILL.md) for "why was this built this way" or design rationale.

### Writing style

- For any prose, use [`/unslop`](./skills/helpers/unslop/SKILL.md) to strip AI patterns and add a human voice.
- If you are unsure which skill fits, use [`/which`](./skills/helpers/which/SKILL.md).

### Testing

Do not write tests by default. Tests are deliberate investments, not ceremony. Write them when the user asks, when the seam is clear and stable, or when using [`/tdd`](./skills/engineering/tdd/SKILL.md). Do not add tests just to satisfy a checklist.

### Manual operations

For steps only a human can do, like provisioning infrastructure, setting up secrets, or running a one-off migration, use [`/wizard`](./skills/helpers/wizard/SKILL.md).
