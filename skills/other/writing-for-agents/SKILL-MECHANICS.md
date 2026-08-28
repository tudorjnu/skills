# Skill mechanics

Skill-specific branch of [`writing-for-agents`](SKILL.md): frontmatter, the invocation choice, and router skills. Everything else about writing a skill lives in `SKILL.md`.

## Invocation

Two choices, trading the two loads:

- **Model-invoked**: the skill keeps a `description`, so the agent can fire it on its own and other skills can reach it. You can still type its name; model-invocation does not remove human access. The description is a context pointer loaded every turn: permanent context load in exchange for discoverability. A model-invoked skill that is all reference is also a shared reference home: another skill can invoke it. Mechanics: omit `disable-model-invocation`, and write a description carrying the trigger branches (the pointer-writing rules in `SKILL.md` apply).
- **User-invoked**: the agent cannot reach the skill on its own; only a human typing its name can invoke it, and no skill can invoke it. Zero context load, but you must remember it exists. Mechanics: set `disable-model-invocation: true`; the `description` becomes human-facing: a one-line summary, trigger lists stripped.

Pick model-invocation only when the agent must reach the skill on its own, or another skill must. If it only ever fires by hand, make it user-invoked and pay no context load.

Shared reference that two user-invoked skills both need can live in neither, since neither has a description and neither can fire the other. Push it to a plain file outside the skill system that any skill can point at.

## Splitting by invocation

Split off a model-invoked skill when you have a distinct leading word that should trigger it on its own, or when another skill must reach it. You pay context load for the new always-loaded description, so that independent reach has to be worth it. (The sequence cut lives in `SKILL.md`.)

## Router skills

When user-invoked skills multiply past what you can remember, a **router skill** fixes that: one user-invoked skill that names the others and when to reach for each, so you only have to remember one skill. It can only hint; it cannot fire them, because user-invoked skills have no description and nothing but a human can reach them.
