---
name: testing
description: Decide what to test and what a test should promise. Use when writing, changing, or deleting tests, when a test breaks for a reason unrelated to behaviour, when a suite feels noisy or slow, or when someone mentions coverage, unit, integration or end-to-end tests, contract tests, property-based tests, characterization or golden-master tests, snapshot tests, or test-driven development and red-green-refactor.
---

# Testing

A test is a commitment: this behaviour will stay true. This skill decides which commitments are worth making, where they are checked, and only then how to write them.

Read `docs/agents/testing.md` first if it exists. It records this repo's invariants, its agreed seams, and what is deliberately untested. Everything below defers to it.

## 1. Triage the promise

Two questions decide whether a test should exist at all:

1. **Will this promise change?** Stable, sometimes, constantly.
2. **How expensive is being silently wrong?** Loud failures (crash, type error, validation) mostly look after themselves.

|  | Costly and silent | Loud or cheap |
| --- | --- | --- |
| **Stable promise** | Test hard. Invariants, contracts, properties, recorded output. | One smoke test, or nothing. |
| **Volatile promise** | Do not test the implementation. Push the decision behind a stable interface, then test that boundary. Volatile and silent is a design smell. | Write nothing. Delete what exists. |

Most of the value is top-left: rules that must keep holding and would break quietly. Bottom-right is where weak suites spend most of their tests, because the code has a function there, not because anyone needs a promise.

"When nothing should be tested" is a real answer. Say so, and add one line under **Deliberately untested** in `docs/agents/testing.md`. Add nothing else to that file: it is `setup-engineering-skills`'s to structure.

## 2. Fix the seam

A **seam** is the public interface where a test observes behaviour without reaching inside. Test at seams, never against internals.

**Confirm the seams before writing anything.** List the seams you intend to test and get agreement with the user. You cannot test everything, and agreeing the seams first spends effort on critical paths instead of every edge case. Ask: "What's the public interface, and which seams should we test?"

If the shape is still moving, it is not a seam yet. Do not write the test. Either spike to learn the shape and throw the spike away, or write the behaviour on a test list and come back when the interface settles.

When the interface itself is in question, call the Skill tool with "codebase-design" for its vocabulary (module, interface, depth, seam, adapter). Consult it as a reference; do not run it as a session.

## 3. Choose the anchor

An anchor is what the test holds the code to. [anchors.md](anchors.md) covers the options. The default is an **example**: one concrete case with an expected value from an independent source.

Pick the anchor by the kind of promise, not by taste:

- One worked case that must always hold: example.
- A rule over many inputs: property.
- What another team or service depends on: contract.
- Behaviour nobody specified and you are about to change: recorded reality.

## 4. Then run the loop

Test-driven development's red → green applies once the promise is settled and the seam is agreed. Run it before that and you write tests for guesses, then pay for them twice.

- **Write the test list first.** One line per behaviour, before any test exists. Cross items off as you go.
- **Red before green.** Pick one item, watch it fail, then write only enough code to make it pass.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle. Do not anticipate future tests.
- **Refactoring is not part of the loop.** It belongs to the review stage (see the `code-review` skill).

## What makes a test worth keeping

- **Structure-insensitive**: refactoring the implementation leaves it green.
- **Behavioural**: the name states a capability, not a mechanism.
- **One reason to fail.**
- **Independent expected values**: a literal, a worked example, or the spec. Never recompute the expected value the way the code computes it.
- **Deterministic**: no wall clock, network, ordering, or randomness the test does not control.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for where mocks belong.

## Anti-patterns

- **Change-detector**: asserts internals, call counts, or call order, so any refactor breaks it.
- **Tautological**: the expectation restates the implementation, so it passes by construction.
- **Horizontal slicing**: all tests first, then all implementation. Bulk tests verify imagined behaviour. Work in vertical slices instead.
- **Coverage chasing**: a test exists because a function has none, not because a promise needs checking.

## Deleting tests

A red test means one of two things: the code broke a promise, or the promise was wrong. When it is the second, delete the test and say so out loud. Do not repair a test that lives on volatile internals; churn there is the signal to stop promising that behaviour.
