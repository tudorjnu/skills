---
name: user-story
description: Turn a user need into development-ready stories with Mike Cohn format and Gherkin acceptance criteria. Writes them to docs/STORIES.md for other skills to reference.
disable-model-invocation: true
---

# User story

Turn a user need into one or more stories the team can build from.

A good story captures who benefits, what they want, why it matters, and how you will know it works. Use this skill when you have a need or idea and want to shape it into something `/to-spec` or `/to-tickets` can pick up.

## File

Stories live at `docs/STORIES.md`. If it exists, read it first. If it does not, create it when the first story is settled.

Use the format in [STORIES-FORMAT.md](./STORIES-FORMAT.md).

## Process

### 1. Read the existing stories

If `docs/STORIES.md` exists, read it. Use its existing language and grouping. Note what is already covered so you do not duplicate or contradict it.

### 2. Gather the need

Use what the user already supplied. If the invocation includes the feature, role, outcome, or edge cases, skip re-asking.

If anything important is missing, ask one question at a time:

- Who is the user?
- What are they trying to do?
- Why does it matter to them?
- What could go wrong?

### 3. Write the stories

Draft one or more stories. Each story must be:

- User-centric: it names a real role and a real outcome.
- Small enough to be implementable and testable.
- Testable: every story has Gherkin acceptance criteria.

If a draft is too vague, too broad, or a technical task in disguise, fix it before showing the user.

### 4. Show and confirm

Present the stories in plain text. Ask whether to:

- append them to `docs/STORIES.md`,
- revise them first, or
- discard and start over.

Only write the file after the user confirms.

### 5. Update the file

If `docs/STORIES.md` does not exist, create it with the full structure.

If it exists, append the new stories under the right section, or create a new section if the feature does not fit an existing one. Preserve what is already there.

## Rules

- Split stories until each has one "when" and one "then". If a draft needs multiple clauses, it is too big.
- Write the "so that" as a real outcome, not a restatement of the action.
- Keep acceptance criteria concrete. "Then the page loads in under 2 seconds" is better than "then it is faster".
- Do not include file paths, code snippets, or implementation details. Those belong in specs and tickets.
