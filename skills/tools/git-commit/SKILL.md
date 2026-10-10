---
name: git-commit
description: 'Execute git operations with conventional commit message analysis, intelligent staging, and message generation. Use whenever the user mentions git, commit, staging, diff, log, rebase, or any other source-control task: analyze the diff, suggest or generate a conventional commit message, stage files safely, and create commits.'
license: MIT
allowed-tools: Bash
---

# Git operations with Conventional Commits

Handle git operations safely, with a focus on producing clean Conventional Commits from the actual diff.

Create a Conventional Commit from the actual diff. Choose the type, scope, and message from what changed.

## Conventional Commit format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit types

| Type       | Purpose                        |
| ---------- | ------------------------------ |
| `feat`     | New feature                    |
| `fix`      | Bug fix                        |
| `docs`     | Documentation only             |
| `style`    | Formatting/style (no logic)    |
| `refactor` | Code refactor (no feature/fix) |
| `perf`     | Performance improvement        |
| `test`     | Add/update tests               |
| `build`    | Build system/dependencies      |
| `ci`       | CI/config changes              |
| `chore`    | Maintenance/misc               |
| `revert`   | Revert commit                  |

## Breaking changes

```
# Exclamation mark after type/scope
feat!: remove deprecated endpoint

# BREAKING CHANGE footer
feat: allow config to extend other configs

BREAKING CHANGE: `extends` key behavior changed
```

## Workflow

### 1. Verify commit identity

Before committing, check the repository author identity:

```bash
git config user.name
git config user.email
```

If both values are set and look reasonable, proceed. If either is missing, stop and ask the user:

- "Copy global name and email into this repo's local config?" (only if `git config --global user.name` and `git config --global user.email` exist).
- "Enter a custom name and email for this repo only."
- "Use a one-off name and email for this commit only."

For a one-off author, commit with:

```bash
GIT_AUTHOR_NAME="Name" GIT_AUTHOR_EMAIL="email@example.com" git commit -m "..."
```

For local repo config, use:

```bash
git config user.name "Name"
git config user.email "email@example.com"
```

### 2. Analyze the diff

```bash
# If files are staged, use staged diff
git diff --staged

# If nothing staged, use working tree diff
git diff

# Also check status
git status --porcelain
```

### 3. Stage files if needed

If nothing is staged or you want to group changes differently:

```bash
# Stage specific files
git add path/to/file1 path/to/file2

# Stage by pattern
git add *.test.*
git add src/components/*

# Interactive staging
git add -p
```

**Never commit secrets** (.env, credentials.json, private keys).

### 4. Write the commit message

Use the diff to determine:

- **Type**: What kind of change is this?
- **Scope**: What area/module is affected?
- **Description**: One-line summary of what changed (present tense, imperative mood, <72 chars)

### 5. Commit

```bash
# Single line
git commit -m "<type>[scope]: <description>"

# Multi-line with body/footer
git commit -m "$(cat <<'EOF'
<type>[scope]: <description>

<optional body>

<optional footer>
EOF
)"
```

## Rules

- One logical change per commit
- Present tense: "add" not "added"
- Imperative mood: "fix bug" not "fixes bug"
- Reference issues: `Closes #123`, `Refs #456`
- Keep description under 72 characters

## Git safety

- NEVER update global git config without explicit request
- Only update local repo git config after the user explicitly chooses that option
- NEVER run destructive commands (--force, hard reset) without explicit request
- NEVER skip hooks (--no-verify) unless user asks
- NEVER force push to main/master
- If commit fails due to hooks, fix and create NEW commit (don't amend)
