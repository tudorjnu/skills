---
name: init
description: "Start work in a repo: check it is set up, load its config and structure, and report anything stale. Read-only."
disable-model-invocation: true
---

# Init

Run this at the start of a session. It reads; it never writes. Reconciling the config belongs to `/setup-engineering-skills`.

## 1. Markers

Check for:

- `AGENTS.md` at the repo root
- `docs/agents/issue-tracker.md`
- `docs/agents/domain.md`
- `docs/agents/testing.md`
- `docs/agents/skills.md`

If any are missing, stop and tell the user to run `/setup-engineering-skills`. Do not continue: orienting against a half-configured repo produces advice built on guesses.

`CONTEXT.md` is not a marker. `/domain-modeling` creates it lazily, so a correctly configured repo may not have one. Read it in step 2 when it is there.

## 2. Orient

**Brief, the default.** Read only what someone wrote down on purpose:

- `AGENTS.md`
- `CONTEXT.md` when it exists, and `docs/agents/*.md`
- `README.md`
- the manifest or build file (`package.json`, `pyproject.toml`, `Makefile`, `go.mod`)
- a two-level directory listing

**Deep, when the user asks or the task needs it.** Spawn a subagent to explore and return:

- Entry points and main modules
- Build and test commands
- Domain terms missing from `CONTEXT.md`, and contradictions between them
- Open work in the tracker, and any in-progress branches
- Risks: unclear seams, missing tests, large files, heavy dependencies

The subagent reads only what it needs. Do not dump files.

## 3. Report drift

Compare what the config claims against the repo:

- Every path the config says setup created exists.
- Paths the config marks as created later are not drift: ADR directories, `CONTEXT.md`, and `.scratch/` before the first ticket.
- Every command it names exists: a manifest script, or a binary on `PATH`.
- The recorded tracker answers: `gh` or `glab` authenticated for GitHub or GitLab. For a tracker recorded as other, skip the probe and say so.

Report each mismatch as the claim, the evidence, and the status. Say "no drift" when there is none. Do not fix anything: a mismatch is a fact to report, and guessing the correction is how the config drifts further.

## 4. Present

```
Repo: {name}
Stack: {from the manifest}
Entry points: {from the manifest or README, or "not mapped"}
Domain terms: {list or "none yet"}
Tracker: {github | gitlab | local | other}
Testing: {one line from docs/agents/testing.md, or "not recorded"}
Drift: {list, or "none"}
Next: {suggested next step}
```

End with the suggested next step. If there is drift, tell the user to run `/setup-engineering-skills` to reconcile it. If open work turned up, ask whether to pick one up. Otherwise ask what they want to build.

The deep pass fills in entry points, domain terms, and open work. On the brief pass those stay thin; say which fields are thin rather than inventing them.
