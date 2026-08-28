---
name: wizard
description: Generate an interactive bash wizard that walks a human through steps only they can perform. Use when provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover. Don't invoke this for steps the agent can perform itself.
---

# Wizard

A **wizard** is a bash script that guides a human through a manual procedure step by step. Use it for tasks that are painful to do by hand and annoying to re-explain to an agent each time, like opening URLs, copying values, writing them to `.env` or GitHub secrets, and confirming each stage.

The boilerplate is already handled by [template.sh](template.sh): stage progress, confirmation gates, cross-platform URL opening (including WSL), hidden secret entry, idempotent `.env` upserts, `gh secret`/`gh variable` writes, and a closing summary. **You only scope the procedure and write the stages.** Do not edit the library above the `STAGES` marker.

A wizard is usually throwaway: build it for one run, save it to a scratch or `scripts/` path, and delete it when done. Commit it only if the user wants a repeatable setup path in the repo.

## Process

### 1. Scope the procedure

Map out every manual step and every value captured along the way. Read the repo first; do not ask cold.

- For setup: read `.env`, `.env.example`, `.env.*`, `README`, `docker-compose*`, framework config, and `.github/workflows/*`. Every `secrets.*` / `vars.*` reference is a value the wizard must produce.
- For a migration or transition: map the current state, the target state, and the irreversible actions between them.

Then show the user the ordered stages and the values each produces. They can add, drop, or reorder.

**Done when:** every stage is named in order, and for each captured value you know:

- (a) where the human gets it
- (b) where it is written (`.env`, a GitHub secret, both, or nowhere; some stages are pure actions)
- (c) whether it is secret (hidden entry) or public

### 2. Map each stage's journey

For each stage, write the exact path a human follows: which URL to open, what to click, where a value appears, and which variable it fills. Example: "Dashboard → Developers → API keys → Reveal test key → copy".

If you do not know the current UI or exact command, say so and ask the user or check the docs. Never invent steps.

**Done when:** every stage gives instructions a stranger could follow.

### 3. Author the wizard

Copy `template.sh` to the target path. Replace the example stage with one `stage` per step, in dependency order. Use the helpers: `stage`, `say`/`step`, `open_url`, `ask`/`ask_secret`, `write_env`, `set_secret`/`set_var`, `pause`/`confirm`. Set `TOTAL_STAGES` to the number of stages you wrote.

Follow the template's bar: open the URL before asking for the value, use `ask_secret` for secrets, `write_env` for every persisted value, `set_secret` only for values CI needs, and `confirm` before any irreversible action. Each `stage` clears the screen, so keep a stage to one focused task.

Do not touch the library above the `STAGES` marker.

### 4. Verify and hand off

- `bash -n <script>`; run `shellcheck` if available.
- `chmod +x <script>`.
- Do not run it end-to-end: it opens browsers and blocks on human input. Trace it statically instead.
- Check that every value from step 1 is captured and lands where step 1 said.
- Check that every `set_secret` name matches a `secrets.*` reference in CI.
- Tell the user how to run it. If it is a repeatable setup path, commit it and link it from the README.
