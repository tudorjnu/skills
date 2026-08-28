# Skills

Personal agent skills for pi. Forked from [Matt Pocock's skills](https://github.com/mattpocock/skills).

Small, composable runbooks for engineering, productivity, and tooling. Make them your own.

## Install

Run once to symlink skills into `~/.agents/skills`:

```bash
./scripts/link-skills.sh
```

Each skill is a folder under `skills/` with a `SKILL.md` and `agents/openai.yaml`.

## Buckets

- [`skills/engineering/`](./skills/engineering/) — core project workflow.
- [`skills/productivity/`](./skills/productivity/) — personal workflow.
- [`skills/tools/`](./skills/tools/) — auxiliary helpers.

## Conventions

- User-invoked skills have `disable-model-invocation: true` and `policy.allow_implicit_invocation: false`; everything else is model-invoked.
- No em-dashes in prose.
