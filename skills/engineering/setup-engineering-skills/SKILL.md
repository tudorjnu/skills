---
name: setup-engineering-skills
description: "Configure this repo for the engineering skills: set up its issue tracker, domain doc layout, and testing posture, and record how to use the agent's skills, subagents, and MCPs. Run once before first use of the other engineering skills."
disable-model-invocation: true
---

# Setup Tudor's Skills

Create the per-repo config the engineering skills expect:

- **Issue tracker**: where issues live
- **Domain docs**: where `CONTEXT.md` and ADRs live, and how to read them
- **Testing posture**: what evidence a change carries before it counts as done
- **Skills and environment**: how to use the agent's skills, subagents, and MCPs, plus environment capabilities observed at setup

This is prompt-driven, not scripted. Explore, summarize, confirm, then write.

## Process

### 1. Explore

Read whatever exists; do not assume:

- `git remote -v` and `.git/config`: is this a GitHub repo? Which one?
- `AGENTS.md` at the repo root: does it exist? Is there already an `## Agent skills` section?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/`: does prior output already exist?
- `.scratch/`: a sign that a local-markdown issue tracker is already in use
- Monorepo signals: `pnpm-workspace.yaml`, `workspaces` in `package.json`, or populated `packages/*` with their own `src/`. These only appear in genuinely large multi-package repos; their absence means single-context, which is almost every repo.
- **Environment**: does your harness support subagents? Note any MCP that touches issue tracking (GitHub, GitLab, Linear, Jira). Only record **persistent** MCP notes in `docs/agents/skills.md`: required scopes, sandbox workarounds, or unavailable servers. Do not list connected servers statically; they are discovered at use time.
- **Tests**: the test runner and its command, where the suite lives, whether `docs/agents/testing.md` already exists, and whether a `CONTEXT.md` records invariants.
- **Do not list installed skills**: the agent's environment already provides that list. `docs/agents/skills.md` should encourage using those skills, not enumerate them.

### 2. Present findings and ask

Summarize what is present and what is missing. Take the sections in order. One section, one answer, then the next.

Lead with the recommended answer so the user can accept it in one word. Explain only when the choice genuinely branches. Skip a section when exploration already settled it (Section B when there is no monorepo).

**If `docs/agents/` already exists, reconcile instead of interviewing.** Read the existing files, then show each section's recorded value next to what the repo shows now. Ask one question per section: keep it as recorded, or change it. Skip sections with no drift. Run the first-time question for any section whose file is missing, so the config fills in rather than staying absent. Re-running must never cost the user a fresh interview.

**Section A: Issue tracker.**

> The issue tracker is where this repo keeps issues. Skills like `to-tickets` and `to-spec` read from and write to it. They need to know whether to call `gh issue create`, write a file under `.scratch/`, or follow some other workflow.

Default to GitHub if `git remote` points there. Default to GitLab if it points to `gitlab.com` or a self-hosted GitLab. Otherwise, or if the user prefers, offer:

- **GitHub**: uses the `gh` CLI
- **GitLab**: uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI
- **Local markdown**: files under `.scratch/<feature>/` in this repo (good for solo projects or repos without a remote)
- **Other** (Jira, Linear, etc.): the user describes the workflow in one paragraph; record it as freeform prose

If exploration found an MCP server for one of these trackers (GitHub, GitLab, Linear, Jira), say so when presenting this section, because it makes that option turnkey.

Record the choice in `docs/agents/issue-tracker.md`. If a tracker MCP is available, append a short **MCP** note to that doc: prefer MCP tools when available, fall back to the CLI commands.

**Section B: Domain docs.** Default to **single-context**: one `CONTEXT.md` and `docs/adr/` at the repo root. This fits almost every repo; write it without asking.

Offer **multi-context** (root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files) only if you found monorepo signals. Then confirm which layout they want.

**Section C: Testing posture.**

> The testing posture says what evidence a change needs before it counts as done. The `testing`, `implement`, and `code-review` skills read it.

Default to **examples at agreed seams, written when the seam is stable**. Do not ask which paradigm the repo prefers; ask one open question and record the answer:

> What must never break here?

The answer seeds the invariant list, and each invariant names the seam that checks it. If `CONTEXT.md` exists, propose invariants from it rather than asking from nothing. Offer property-based tests, contract tests, and recorded-reality tests only where the answer points at them (a rule over many inputs, a deployable another team depends on, untested legacy code).

Record the answer in `docs/agents/testing.md` from the seed template: done means, commands, invariants, anchors in use, seams, deliberately untested. Fill the commands from the runner exploration in step 1, without asking again. Anything the user says is not worth testing goes under **Deliberately untested** with the reason, so it reads as a decision rather than an omission.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to `AGENTS.md` at the repo root
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, `docs/agents/testing.md`, and `docs/agents/skills.md`

Let them edit before writing.

### 4. Write

Edit `AGENTS.md` at the repo root. If an `## Agent skills` block already exists, update it in-place. Never create `CLAUDE.md`.

The block:

```markdown
## Agent skills

### Issue tracker

[one-line summary]. See `docs/agents/issue-tracker.md`.

### Domain docs

[one-line summary: "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### Testing

[one-line summary: what a change carries as evidence, and where invariants are checked]. See `docs/agents/testing.md`.

### Skills and environment

How to use skills, subagents, and MCPs, plus environment capabilities (MCP servers, subagents) observed at setup. See `docs/agents/skills.md`.
```

Then write the docs files from the seed templates in this skill folder:

- [issue-tracker-github.md](./issue-tracker-github.md)
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)
- [issue-tracker-local.md](./issue-tracker-local.md)
- [domain.md](./domain.md)
- [testing.md](./testing.md): done means, commands, invariants, anchors in use, seams, and what is deliberately untested
- [skills.md](./skills.md): guidance on using skills, subagents, and MCPs; fill in subagent availability and persistent MCP notes only

For "other" trackers, write `docs/agents/issue-tracker.md` from scratch using the user's description.

### 5. Done

Tell the user setup is complete and which skills will read these files. They can edit `docs/agents/*.md` directly later.

Re-run this skill when the repo drifts from its config: a renamed command, a moved `CONTEXT.md`, a new tracker, changed testing policy. It shows what is recorded, asks only about what differs, and leaves everything else untouched. Tell the user to run `/init` first if they want the drift list without changing anything.

## How the engineering skills work

- Use skills, subagents, and MCPs actively. `docs/agents/skills.md` records environment capabilities observed at setup and reminds the agent to prefer a relevant skill over reinventing its logic.
- Use subagents for parallel work or whenever a separate context window would help.
- Read `CONTEXT.md` and ADRs before touching code in an area.
- Stop and ask on architectural decisions; do not decide them silently.
