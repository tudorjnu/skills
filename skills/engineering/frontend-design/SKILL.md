---
name: frontend-design
description: Apply a distinctive, intentional visual design direction before building or reshaping any frontend UI. Reads DESIGN.md and CONTEXT.md; if no DESIGN.md exists, stops and tells the user to run /design-direction.
---

# Frontend design

Apply the project's visual direction before any frontend change.

This skill fires whenever the agent is about to implement, modify, or review a frontend page, component, or layout. It makes sure the design is deliberate, not templated.

## Read the design direction

Read `DESIGN.md` at the project root. Also read `CONTEXT.md` if it exists, so the design respects the project's domain language.

## If DESIGN.md exists

Use it as the source of truth:

- Subject, audience, and page job.
- Principles (hero as thesis, typography as personality, structure as information, deliberate motion).
- Token system: palette, type, layout.
- Signature element.
- Copy voice.
- User stories from `docs/STORIES.md`.

Apply these constraints to every frontend change. If the change contradicts `DESIGN.md`, tell the user and ask how to resolve it.

## If DESIGN.md is missing

Stop and tell the user:

> I need a design direction before I can build or reshape UI here. Run `/design-direction` to create `DESIGN.md`, then I can apply it.

Do not proceed with the frontend change. Do not auto-grill.

## While building

- Derive every colour, type, spacing, and layout decision from `DESIGN.md`.
- Spend boldness on the signature element. Keep everything else disciplined.
- Use real content from the brief, not placeholder filler.
- Respect accessibility defaults: responsive down to mobile, visible keyboard focus, reduced motion.
- Avoid the three AI-default looks unless the brief asks for them: warm cream + serif + terracotta; near-black + acid accent; broadsheet hairline columns.
- Avoid selector specificity traps: do not let a `.section` rule fight a `.cta` rule over padding or margins.
- If you need screenshots to critique the work, take them when the environment supports it.

## Before finishing

Self-critique against `DESIGN.md`. If anything reads as a default or could belong to any other project, revise it and say what you changed.
