---
name: resolving-merge-conflicts
description: "Use when you need to resolve an in-progress git merge/rebase conflict."
---

1. **Inspect the merge or rebase.** Check the git history and conflicting files.

2. **Find the primary sources for each conflict.** Read commit messages, PRs, and original issues or tickets to learn why each side changed and what it intended.

3. **Resolve each hunk.** Preserve both intents where possible. Where incompatible, pick the one matching the merge's stated goal and note the trade-off. Do **not** invent new behaviour. Always resolve; never `--abort`.

4. Find and run the project's **automated checks**, usually typecheck, tests, then format. Fix anything the merge broke.

5. **Finish the merge or rebase.** Stage everything and commit. If rebasing, continue until every commit has been rebased.
