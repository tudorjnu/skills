---
name: wayfinder
description: Plan a huge chunk of work (more than one agent session can hold) as a shared map of decision tickets on your issue tracker, and resolve them one at a time until the way to the destination is clear.
disable-model-invocation: true
---

Use Wayfinder for an idea that is too large or uncertain for one agent session. Define a **destination**, chart a **shared map** on the repo's issue tracker, then resolve **decision tickets** one at a time until the route is clear. Decision tickets answer questions; they are not slices of implementation work.

Name the destination first because it shapes every ticket. It may be a spec, a decision needed before planning, or an in-place change such as a data-structure migration. The map works for any domain.

## Plan, don't do

Wayfinder is **planning** by default. Each ticket resolves a decision. The map is done when nothing remains to decide before implementation starts. If a ticket turns into implementation work, the planning boundary has probably been reached and it is time to hand off. An effort may override this in its **Notes**; otherwise produce decisions, not deliverables.

## Refer by name

Every map and ticket is an issue with a **name**: its title. In narration and the map's Decisions-so-far, use that name instead of a bare id, number, or slug. A wall of `#42, #43, #44` is hard to read. Keep the id and URL inside the linked name.

## The map

The map is a single issue on this repo's issue tracker, labelled `wayfinder:map`, the canonical artifact. Its tickets are child issues of the map.

The map is an **index**, not a store. Each decision lives in its ticket. The map gives a one-line summary and link without repeating the detail.

The tracker decides where maps, child tickets, blocking links, and frontier queries live. If the issue tracker has not been configured, tell the user to run `/setup-engineering-skills`. Read its "Wayfinding operations" section. If no tracker is available, use local markdown.

### The map body

Load this low-detail map once per session. Do not list open tickets in it; query the open child issues instead.

```markdown
## Destination

<what reaching the end of this map looks like: the spec, decision, or change this effort is finding its way to. One or two lines; every session orients to it before choosing a ticket.>

## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

<!-- the index: one line per closed ticket, enough to judge relevance, then zoom the link for the detail the ticket holds -->

- [<closed ticket title>](link): <one-line gist of the answer>

## Not yet specified

<!-- see "Fog of war": in-scope fog you can't ticket yet; graduates as the frontier advances -->

## Out of scope

<!-- see "Out of scope": work ruled beyond the destination; closed, never graduates -->
```

### Tickets

Each ticket is a **child issue** of the map; the tracker's issue id is its identity. Its body is the question, sized to one 100K token agent session:

```markdown
## Question

<the decision or investigation this ticket resolves>
```

Each ticket carries a `wayfinder:<type>` label, one of `research`, `prototype`, `grilling`, `task` (see [Ticket Types](#ticket-types)).

A session **claims** a ticket by assigning it to the developer before any work. Concurrent sessions then skip it. An open, unassigned ticket is unclaimed.

Use the tracker's **native** dependency links so the UI shows which tickets are ready without opening the map. Fall back to a body convention only when the tracker lacks native blocking. A ticket is **unblocked** when every blocker is closed. The **frontier** is the set of open, unblocked, unclaimed child tickets.

The answer isn't part of the body; it's recorded on resolution (see [Work through the map](#work-through-the-map)). Assets created while resolving a ticket are linked from the issue, not pasted in.

## Ticket types

Every ticket is either **HITL** (worked live with a human) or **AFK** (driven by the agent alone). A HITL ticket requires that live exchange. The agent must not answer the human's questions for them.

- **Research** (AFK): Reading documentation, third-party APIs, or local resources like knowledge bases to surface a fact a decision waits on. Resolved by a subagent that calls the Skill tool with "research". Use when knowledge outside the current working directory is required.
- **Prototype** (HITL): Make a cheap, rough artifact to react to, such as an outline, stub, or UI/logic prototype. Call the Skill tool with "prototype" and link the result as an asset. Use when the key question is "how should it look" or "how should it behave".
- **Grilling** (HITL): Conversation. The default case. Always call the Skill tool twice, for "grilling" and "domain-modeling".
- **Task** (HITL or AFK): Manual work needed before a decision can be made, such as signing up for a service, provisioning access, or moving data so its shape can be inspected. A task unblocks a decision; it does not deliver the destination. The agent handles it alone where possible. Otherwise it gives the human a precise checklist. Resolve it when the work is done and record any facts later tickets need, such as credential locations, URLs, or row counts.

## Fog of war

The map is deliberately incomplete. Do not create tickets for questions you cannot state yet. The **fog of war** holds decisions and investigations that are likely to matter but still depend on open questions. As tickets resolve, turn newly precise questions into tickets until the route to the destination is clear.

Record that uncertainty under **Not yet specified**: the suspected question or area to revisit. Everything there is in scope but not precise enough for a ticket. Write only what is currently known.

**Fog or ticket?** The test is whether you can state the question precisely now, _not_ whether you can answer it now.

- **Ticket when** the question is already sharp, even if it's blocked and you can't act on it yet.
- **Not yet specified when** you cannot yet phrase it that sharply. Do not pre-slice uncertainty into tickets. One uncertain area may later produce several tickets, or none.

**Not yet specified** excludes what's already decided (Decisions so far), what's already a live ticket, and what's out of scope (the next section).

## Out of scope

The destination fixes the scope. Work beyond it is **out of scope**, not fog, and belongs under **Out of scope** rather than **Not yet specified**.

Out-of-scope work does not return unless the destination changes. If an existing ticket turns out to be beyond the destination, close it and add one linked line under **Out of scope** explaining why. Do not add it to **Decisions so far**; a scope boundary is not a decision on the route.

## Invocation

Two modes. Either way, **never resolve more than one ticket per session**, with the exception of research tickets.

### Chart the map

User invokes with a loose idea.

1. **Name the destination.** Call the Skill tool twice, for "grilling" and "domain-modeling", to pin down what this map is finding its way to: the spec, decision, or change. The destination fixes the scope, so it's settled first.
2. **Map the frontier.** Grill breadth-first across the effort instead of going deep on one thread. Find the open decisions and the first steps available now. If the route is already clear and fits in one session, stop and ask the user how to proceed; no map is needed.
3. **Create the map** (label `wayfinder:map`): Destination and Notes filled in, Decisions-so-far empty, the fog sketched into **Not yet specified**.
4. **Create the tickets you can specify now** as child issues. Then wire blocking edges in a second pass, after the issues have ids. Put everything still too vague under **Not yet specified**.
5. **Fire the research subagents.** For each `research` ticket you just created, spin up a subagent that calls the Skill tool with "research" to resolve it in parallel, capturing its findings on a throwaway `research/<name>` branch with a context pointer from the ticket.
6. Stop: charting is one session's work; it hand-resolves nothing.

### Work through the map

User invokes with a map (URL or number). A ticket is **optional**: without one, you pick the next decision, not the user.

1. Load the **map**: the low-res view, not every ticket body.
2. Choose the ticket. If the user named one, use it. Otherwise take the first frontier ticket in order. **Claim it**: assign it to yourself before any work.
3. Resolve it. **Zoom as needed**: fetch the full body of any related or closed ticket on demand; call the Skill tool for whichever skills the `## Notes` block names. If in doubt, call the Skill tool twice, for "grilling" and "domain-modeling".
4. Record the resolution: post the answer as a **resolution comment**, **close** the issue, and **append a context pointer** to the map's Decisions-so-far.
5. Add newly discovered tickets, then wire their blockers. Move any question that has become precise out of **Not yet specified** and into its ticket. If a ticket is beyond the destination, mark it **out of scope** instead of resolving it on the route. Update or delete tickets invalidated by the decision.

The user may run unblocked tickets in parallel, so expect other sessions to be editing the tracker concurrently.
