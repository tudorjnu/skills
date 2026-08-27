## What it does

`git-commit` turns the changes in front of you into a [conventional commit](https://www.conventionalcommits.org/). It reads the diff, picks a type and scope, keeps the description under 72 characters, and runs `git commit`. It only needs the Bash tool, so it works in any repo without extra setup.

The defining constraint: it always writes the message from the actual diff, never from a generic guess. If nothing is staged, it either stages intelligently or asks you which files belong together, so the commit stays one logical change.

## When to reach for it

You invoke this by typing `/git-commit`. The agent will not fire it on its own.

Reach for it when you have finished a unit of work and want to commit without typing the message yourself. It is especially useful when the change touches several files and the right type or scope is not obvious from a quick glance.

## The commit loop

The skill follows a short, fixed loop:

1. **Read the diff.** Staged changes come first; if nothing is staged, it reads the working tree.
2. **Stage if needed.** It can stage specific files, patterns, or hunks, but never secrets.
3. **Draft the message.** Type, scope, and description are derived from the diff.
4. **Run the commit.** A single-line message is the default; a body and footer are added only when they carry real information.

## Common questions

**Will it commit everything if I don't stage anything first?**

It stages only what the diff says belongs to one logical change. If the working tree contains unrelated edits, it asks which files to include rather than committing the lot.

**Can I override the message it generates?**

Yes. Tell it the type, scope, or description you want and it will use your values instead of the ones it inferred.

**Does it run with `--no-verify` to skip hooks?**

No. It never skips hooks unless you explicitly ask. If a hook fails, fix the problem and create a new commit. Do not amend.

## It's working if

- The diff is inspected before any commit is run.
- The message follows the Conventional Commits format and the description is under 72 characters.
- Secrets and unrelated changes are left out of the commit.
- Hooks run as normal and any failure is reported without amending.

## Where it fits

`git-commit` is a **reach-for-it-anytime standalone** for the small but repeated task of closing out a change. It sits beside the engineering flow rather than inside it: you might run it after `/implement` or `/tdd`, or on its own after any manual edits. When you are unsure which skill fits the situation, [ask-matt](https://aihero.dev/skills-ask-matt) routes you.
