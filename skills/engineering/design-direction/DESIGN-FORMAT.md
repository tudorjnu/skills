# DESIGN.md format

A single durable design direction lives at the project root as `DESIGN.md`. The agent reads it before any frontend change.

## Structure

```md
# Design direction

{One or two sentences describing the project and the visual stance.}

## Subject

- **Product or subject:** {concrete name}
- **Audience:** {who will use this}
- **Page job:** {the single thing the page must do}

## Principles

- {The hero is a thesis.}
- {Typography carries the personality.}
- {Structure is information, not decoration.}
- {Motion is deliberate.}
- {One justified aesthetic risk, everything else quiet.}

## Token system

### Colour

- **{name}:** {hex} - {where it is used}

### Type

- **Display:** {typeface and usage}
- **Body:** {typeface and usage}
- **Utility:** {typeface and usage, if needed}

### Layout

{One-sentence concept.}

```

ASCII wireframe or structural notes

```

## Signature element

{The single thing this page will be remembered by, and why it fits the brief.}

## Motion

{Where animation serves the subject and where it is intentionally absent.}

## Copy voice

{Conversational, technical, playful, severe, or another single word, plus one sentence of guidance.}

## User stories

Reference `docs/STORIES.md` for the stories this design serves.

## Risks and self-critique

{One or two defaults the design deliberately avoids, and why.}
```

## Rules

- **Keep it compact.** The file is a decision record, not a design course.
- **Derive every token from the subject.** If a colour or typeface could belong to any project, replace it.
- **No implementation details.** File paths, component names, and CSS variables belong in code, not here.
- **Revisit on major shifts.** A new audience, brand, or product phase should rewrite this file, not patch around it.
