---
name: design-direction
description: Create a durable visual design direction for a frontend project. The user invokes this to produce DESIGN.md before building or reshaping UI.
disable-model-invocation: true
---

# Design direction

Create a durable design direction at `DESIGN.md`.

This skill interviews the user, one question at a time, until the visual direction is sharp enough to build from. The output is a single file the agent reads before every frontend change.

## When to use

- The repo has no `DESIGN.md` and the user wants a frontend built.
- An existing `DESIGN.md` needs a major shift: new brand, new audience, new product phase.
- The user wants to stress-test a visual idea before committing to it.

Do not use this for small tweaks. For small tweaks, read `DESIGN.md` and apply it.

## Process

### 1. Read existing context

If `DESIGN.md` exists, read it. If `CONTEXT.md` exists, read it. Use what is already there to avoid contradiction.

### 2. Define the subject

If the brief does not pin down the subject, audience, and the page's single job, ask one question at a time until it does. State the choice so the user can correct it.

### 3. Build the design tree

Map the remaining decisions as a tree. Work through the frontier in rounds:

- Enumerate the full frontier at the start of each round.
- Ask one question at a time, starting with the most important.
- Wait for the answer before moving on.
- Recompute the frontier after each answer.

Typical frontier questions, in rough order:

- What is the one thing this page must communicate?
- What is the primary medium of the hero: headline, image, animation, live demo, interactive moment?
- What is the palette, as 4-6 named hex values?
- What are the typefaces for display, body, and any utility role?
- What is the layout concept in one sentence and an ASCII wireframe?
- What is the signature element: the one thing this page will be remembered by?
- Where does animation serve the subject, and where is it unnecessary?
- How does copy sound: conversational, technical, playful, severe?

### 4. Capture user stories

Before finalizing the design, tell the user to run [`/user-story`](../user-story/SKILL.md) so the design serves real user needs. If `docs/STORIES.md` already exists, read it and confirm the stories this design must support.

### 5. Write DESIGN.md

Once the frontier is empty, write `DESIGN.md` at the project root using the format in [DESIGN-FORMAT.md](./DESIGN-FORMAT.md).

Show the file to the user before writing it. Only write after confirmation.

## Rules

- Push every choice back to the subject. Distinctive design comes from the brief's world, not from defaults.
- Reject the three AI-default looks unless the brief asks for one: warm cream + high-contrast serif + terracotta; near-black + acid accent; broadsheet hairline columns.
- Take one justified aesthetic risk. Let everything else stay quiet.
- Ground every decision in real content, real audience, real job.
