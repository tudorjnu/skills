# Testing

Testing posture for this repo. Recorded by `/setup-engineering-skills` on [date]. Edit this file directly as the policy changes.

## Done means

[One line: what evidence a change carries before it counts as done. Example: "Changed behaviour ships with a test at an agreed seam, or the PR states why not."]

## Commands

Where the checks actually run, so nobody has to guess a command.

- Test: `[command]`
- Typecheck or lint: `[command]`
- Build: `[command, or "n/a"]`

## Invariants that must keep holding

Rules that should never break, and the seam that checks each one. These are the promises worth a test.

- [invariant] checked at [public interface / file]

## Anchors in use

- **Examples**: [where, or "default everywhere"]
- **Properties**: [where, or "none"]
- **Contracts**: [where, or "none"]
- **Recorded reality**: [where, or "none"]

## Seams

- [public interface] at [path]

## Deliberately untested

Areas with no tests, each with the reason. Recording these keeps them decisions rather than omissions.

- [area] because [volatile, failure is loud, covered by types, cost outweighs risk]
