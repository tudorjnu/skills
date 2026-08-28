---
name: which
description: Find the right skill for your current situation. The user invokes this when they are unsure what to do next.
disable-model-invocation: true
---

# Which

Help the user find the right skill for their situation.

## 1. Understand the situation

Ask one or two clarifying questions if needed. Consider:

- Are they starting in a new repo, or already working in one?
- Do they want to understand, plan, build, refactor, review, debug, or document?
- Is the path clear, or are they still figuring out what to do?
- Is the work small and bounded, or large and uncertain?

## 2. Map to a skill

Pick the most relevant skill from the current setup and explain why:

| Situation | Skill |
| --- | --- |
| New repo, onboarding | `/init` |
| "I want to build/change something" but unclear how | `/brainstorm` |
| Want to design or change an API surface | `/api-design` |
| Need to create a visual direction before building UI | `/design-direction` |
| Want to design or change REST API endpoints | `/rest-api-design` |
| Have a user need and want to turn it into stories | `/user-story` |
| Need to understand how a subsystem works | `/how` |
| Want to know why code was built this way | `/why` |
| Need to sharpen requirements and domain language | `/grill-with-domain` |
| Have a clear, bounded task to implement | `/implement` |
| Want to improve code structure | `/refactor` |
| Stuck on a bug or performance issue | `/diagnosing-bugs` |
| Need to write a spec or break work into tickets | `/to-spec` / `/to-tickets` |
| Need a throwaway prototype to answer a design question | `/prototype` |
| Manual setup, secrets, migration only a human can do | `/wizard` |
| Writing docs, skills, or AGENTS.md | `/writing-for-agents` |
| Prose feels like AI slop | `/unslop` |
| Need information from primary sources | `/research` |

If no skill fits well, say so.

## 3. Suggest and stop

Tell the user which skill to invoke and why. Do not invoke it for them. Wait for the user to run it.
