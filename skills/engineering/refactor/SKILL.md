---
name: refactor
description: "Use when the user says 'refactor this', 'clean up', 'simplify', 'reduce complexity', or 'extract'. Improve structure without changing behavior. Stop and ask if the change crosses a seam or public interface."
disable-model-invocation: true
---

# Refactor

Improve structure without changing behavior.

## Before touching code

1. Read the area and its tests.
2. Identify the smell: long function, duplicated code, nested conditionals, large class, unclear names, primitive obsession.
3. Tell the user what you intend to change and why. Wait for approval.

## Safe process

- Change one thing at a time.
- Run relevant tests after each change.
- Do not change public interfaces unless approved.
- Stop and ask if the refactor crosses a module seam, affects a public API, or could change behavior.

If the refactor touches a seam, module boundary, or depth question, call the Skill tool with "codebase-design" first.

## Common moves

- Extract function / class / interface
- Rename for clarity
- Replace nested conditionals with guard clauses
- Introduce constants or domain types
- Remove dead code

## Done when

- Tests pass.
- Behavior is unchanged.
- The code is easier to read than before.
