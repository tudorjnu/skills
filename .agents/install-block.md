# The canonical install block

One install story, one wording. `README.md`, `.changeset/*`, and every page under `docs/` must say **this** and nothing else. Change it here first, then propagate.

This is a fork of [Matt Pocock's skills](https://github.com/mattpocock/skills). The canonical route is **skills.sh**, which copies editable skill files into your project. There is no Claude Code marketplace listing for this fork.

## skills.sh

Use the whole-set form on `README.md`:

<canonical-block name="skills-sh-whole-set">

```bash
npx skills@latest add tudorjnu/skills
```

Pick the skills you want, and which coding agents to install them on. **The installer lets you choose which skills to take: make sure `setup-engineering-skills` is one of them.**

</canonical-block>

…and the single-skill form wherever one skill is named on its own. Note that **`docs/` pages are not a consumer of this block**: ai-hero renders the install widget above the body, so a page that writes the commands out duplicates it. See [writing-docs.md](./writing-docs.md).

<canonical-block name="skills-sh-one-skill">

```bash
npx skills@latest add tudorjnu/skills --skill=<name>
```

```bash
npx skills@latest update <name>
```

</canonical-block>

`skills@latest` is the pinned spelling in all three. The pages under `docs/` used to carry their own copy of these commands; those blocks are now deleted rather than corrected, because the site renders the install commands itself.

## Not the install story

`.claude-plugin/marketplace.json` makes the repo its own single-plugin marketplace (`/plugin marketplace add tudorjnu/skills`, then `/plugin install tudorjnu-skills@tudorjnu`). It is kept as a fallback for installing the repo directly (an unreleased commit, or a fork), and is **not** documented to users.
