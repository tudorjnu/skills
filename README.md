# Skills

My agent skills for pi. Forked from [Matt Pocock's skills](https://github.com/mattpocock/skills).

These are small runbooks for engineering, productivity, and tooling. I edit them as I go.

## Install

Link the skills into `~/.agents/skills`, grouped by bucket:

```bash
./scripts/link-skills.sh
```

Each skill lives in its own folder under `skills/` with a `SKILL.md` and an `agents/openai.yaml`. The install preserves the buckets, so skills land at `~/.agents/skills/<bucket>/<name>`; older flat installs are migrated automatically.

The `npx skills` CLI groups this repo's skills by the plugin names in `.claude-plugin/marketplace.json` (one per bucket: Architecture, Engineering, and so on) in its install and list views, but writes flat to disk. Run `./scripts/link-skills.sh` after any `skills add` or `skills update` to restore the bucketed layout. When you add a skill to the repo, also add its path to `.claude-plugin/marketplace.json` under the right bucket plugin.

## Buckets

- [`skills/engineering/`](./skills/engineering/) - core project workflow.
- [`skills/productivity/`](./skills/productivity/) - personal workflow.
- [`skills/tools/`](./skills/tools/) - technical tooling like git.
- [`skills/helpers/`](./skills/helpers/) - reusable agent capabilities.
- [`skills/other/`](./skills/other/) - skills I have not found a home for yet.
- [`skills/robotics/`](./skills/robotics/) - Unitree robot facts (G1, G1D, shared SDK stack) plus /setup-robotics-skills for wiring robot repos.

## Conventions

- User-invoked skills set `disable-model-invocation: true` and `policy.allow_implicit_invocation: false`. Everything else is model-invoked.
- No em-dashes in prose.
