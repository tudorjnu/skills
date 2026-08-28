# STORIES.md format

Stories live at `docs/STORIES.md`.

## Structure

```md
# User Stories

{One or two sentences describing the product or feature area these stories cover.}

## {Feature or domain area}

### {Story title}

- **Summary:** {Short value-focused title}
- **As a** {specific role}
- **I want to** {action the user takes}
- **So that** {outcome they get}

#### Acceptance criteria

- **Scenario:** {human-readable scenario}
  - **Given** {precondition}
  - **When** {action the user takes}
  - **Then** {expected outcome}
```

## Rules

- **Group stories under feature headings.** A flat list is fine for a small area; use headings when distinct features emerge.
- **Keep the "so that" meaningful.** It should explain motivation, not repeat the action.
- **One "when" and one "then" per story.** Multiple clauses usually mean the story is too big.
- **Make acceptance criteria concrete.** Include real numbers, states, or visible outcomes where possible.
- **Avoid implementation details.** Stories describe behavior, not file paths, APIs, or UI components.
