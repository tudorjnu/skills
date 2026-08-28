---
name: api-design
description: Apply the project's API direction before designing or changing any API surface. Reads API.md and CONTEXT.md and routes to the right specific skill for REST, gRPC, or other styles.
---

# API design

Apply the project's API direction before any API change.

This skill fires whenever the agent is about to design, add, modify, or review an API surface. It reads the existing direction, uses the domain model, and routes to the right style-specific skill.

## Read existing direction

Read `API.md` at the project root if it exists. Read `CONTEXT.md` if it exists, so the API uses the project's domain language.

## Choose the style

If `API.md` defines a style, follow it. Otherwise, infer from the task:

| Style | When to use | Skill |
| --- | --- | --- |
| REST | HTTP resources, JSON, CRUD or query endpoints | `/rest-api-design` |
| gRPC | Internal service-to-service RPC | `/grpc-design` (when available) |

If the style is unclear, ask the user before proceeding.

## Apply the style-specific skill

Route to the matching skill and apply its rules. Do not mix styles in the same API surface without explicit justification.

## If API.md is missing

Proceed with the style-specific defaults. If the API is large or the team needs a written direction, suggest creating `API.md` to capture the direction.

## Rules

- Use the project's domain terms from `CONTEXT.md` in resource and message names.
- Keep the API surface small and purposeful.
- Do not leak implementation details into the public contract.
- Version intentionally, not as an afterthought.
- Document errors consistently.
