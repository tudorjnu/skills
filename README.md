# Skills

My agent skills for pi. Forked from [Matt Pocock's skills](https://github.com/mattpocock/skills).

These are small runbooks for engineering, productivity, and tooling. I edit them as I go.

## Install

Link the skills into `~/.agents/skills`:

```bash
./scripts/link-skills.sh
```

Each skill lives in its own folder under `skills/` with a `SKILL.md` and an `agents/openai.yaml`.

## Buckets

- [`skills/engineering/`](./skills/engineering/) - core project workflow.
- [`skills/productivity/`](./skills/productivity/) - personal workflow.
- [`skills/tools/`](./skills/tools/) - technical tooling like git.
- [`skills/helpers/`](./skills/helpers/) - reusable agent capabilities.
- [`skills/other/`](./skills/other/) - skills I have not found a home for yet.

## Conventions

- User-invoked skills set `disable-model-invocation: true` and `policy.allow_implicit_invocation: false`. Everything else is model-invoked.
- No em-dashes in prose.
