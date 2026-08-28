---
name: writing-for-agents
description: Writing documents for agents. Use when creating or editing skills, or modifying AGENTS.md or CLAUDE.md.
---

Reference for writing any document an agent consumes: a skill, an `AGENTS.md` / `CLAUDE.md`, or any doc reached by a pointer. Different packaging, same rules.

When writing a skill, read [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md) for frontmatter, invocation choice, and router skills.

## Context pointers

A **context pointer** is a short reference that tells the agent when to load some out-of-context material. A skill description and a line in `AGENTS.md` are both pointers. The wording of the pointer matters more than the target. A must-have target behind a weak pointer is a reliability problem: sharpen the wording first; inline the material only if sharpening fails.

A pointer should say:

- what the material is
- which cases trigger loading it

Keep pointers short. Every word loaded every turn costs attention.

- Put the triggering word first.
- One trigger per real case. Do not list synonyms as separate cases.
- Drop words the body already implies.

## Two budgets

Every document or pointer costs one of two things:

- **Context load**: always-loaded material (`AGENTS.md` lines, skill descriptions). It spends tokens and attention every turn, whether it fires or not.
- **Cognitive load**: the human's cost of remembering which documents exist and when to use them. Accept this where human judgment matters; remove it where it does not.

A pointer trades a little context load for a lot of hidden detail. A document with no pointer rides entirely on cognitive load.

## Information hierarchy

A document mixes two things:

- **Steps**: ordered actions the agent takes.
- **Reference**: definitions, rules, facts consulted on demand.

Both are fine. The decision is where each piece sits on the ladder of immediacy:

1. **In-file step**: what the agent does, in order.
2. **In-file reference**: consulted on demand, usually a flat set of rules.
3. **Disclosed reference**: in a separate file, loaded only when a pointer fires.

Push too little out and the top bloats. Push too much out and the agent misses what it needs. The right balance matters.

**Progressive disclosure** means moving reference down the ladder so the top stays readable. Branching is the cleanest test: inline what every branch needs; push behind a pointer what only some branches reach.

**Co-location** means keeping a concept's definition, rules, and caveats together. Grouped material reads like documentation; scattered material does not.

**Sprawl** is the failure mode: a document too long even when every line matters. Attention thins. The fix is disclosure and splitting by branch or sequence so each path carries only what it needs.

## Steps and completion criteria

Every step needs a clear **completion criterion**: how the agent knows it is done.

- **Clarity**: can the agent tell done from not-done? A vague bound like "understanding reached" invites premature completion. Sharpen the bound first. If it is unavoidably fuzzy and you see the agent rushing, split the sequence at a real context boundary (hand-off or subagent). Inline splits do not help.
- **Demand**: how much work it requires. "Every modified model accounted for" forces more legwork than "produce a change list." Demand also binds flat reference: "every rule applied" carries the same exhaustiveness as "every step done."

The best criteria are checkable and exhaustive.

## When to split

Splitting spends one of the two budgets, so only do it when the cut earns its keep:

- **By sequence**: split when later steps tempt the agent to rush the current one. Hiding later steps focuses legwork here. Merging them back does the opposite.
- **By invocation**, skill-specific: see [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md).

## Leading words

A **leading word** is a compact concept the model already understands. Repeat it as a token, not a sentence. It anchors behavior with fewer tokens because it recruits existing priors. Examples: _lesson_, _fog of war_, _tracer bullets_.

Coined words work if you define them clearly, but they cost definition tokens. Reach for an existing word first.

Leading words anchor in two places:

- In the body, they trigger consistent behavior.
- In a pointer, they make the agent reach the material more reliably when the same word appears in prompts or code.

Look for restatements that collapse into one word. For example, "fast, deterministic, low-overhead" becomes _tight_. "A loop you believe in" becomes _red_ (the loop goes red on the bug, or it does not).

**Negation is the failure mode beside this.** Saying "don't do X" activates X. State the positive target behavior instead. Only use negation as a hard guardrail when you cannot phrase it positively; even then, pair it with the positive target.

## Pruning

- Keep each meaning in one place. **Duplication** costs maintenance and tokens, and inflates a meaning's importance beyond its real rank.
- The **environment** is also a source of truth: `package.json` scripts, config files, directory layout, `--help` output. A document that restates these is a **cache**. Cache only what is expensive to look up: unwritten conventions, reasons behind choices, gotchas no config confesses. Leave one-command lookups to the environment.
- Check every line for **relevance**: does it still affect what the document does? Irrelevant lines become **sediment**: stale layers that pile up because adding feels safe and removing feels risky.
- Hunt **no-ops** sentence by sentence. If a sentence does not change behavior compared to the default, delete it. A weak leading word like _be thorough_ is also a no-op; replace it with a stronger word like _relentless_.
