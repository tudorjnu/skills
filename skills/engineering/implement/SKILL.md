---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Check types and run relevant tests at sensible intervals: after a vertical slice, after a risky change, and before finishing. Do not run them after every small edit.

If you hit an architectural decision (a new module, a new seam, a public interface, a dependency direction, or a pattern that affects more than the current task), stop and ask the user. Do not decide it yourself.

Once done, use `/code-review` to review the work, then present a summary of the changes. Do not commit; let the user decide when to commit.
