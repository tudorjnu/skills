---
name: teach
description: Teach the user a new skill or concept, within this workspace.
disable-model-invocation: true
argument-hint: "What would you like to learn about?"
---

The user wants to learn something. Treat it as a stateful request: they will return for multiple sessions.

## Teaching Workspace

Track their learning in files inside the current directory:

- `MISSION.md`: why they want to learn this. Ground every lesson in it. Use [MISSION-FORMAT.md](./MISSION-FORMAT.md).
- `./reference/*.html`: cheat sheets, syntax, glossaries, and other compressed reference. These should print well.
- `RESOURCES.md`: external resources for grounding the teaching. Use [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md).
- `./learning-records/*.md`: non-obvious lessons and key insights, numbered `0001-<name>.md`. Use [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md).
- `./lessons/*.html`: single, self-contained lessons, numbered `0001-<name>.html`. Each teaches one small thing tied to the mission.
- `./assets/*`: reusable components shared across lessons (stylesheets, quiz widgets, simulators).
- `NOTES.md`: user preferences and working notes.

## Philosophy

Deep learning needs three things:

- **Knowledge** from high-quality, high-trust resources
- **Skills** through interactive lessons you design from that knowledge
- **Wisdom** from interacting with other learners and practitioners

Until `RESOURCES.md` is solid, focus on finding good resources. Never rely on your parametric knowledge.

Some topics lean more toward knowledge (theoretical physics); others lean more toward skills (yoga).

### Fluency vs Storage Strength

Split these two types of learning:

- **Fluency strength**: recalling knowledge in the moment
- **Storage strength**: long-term retention

Fluency can feel like mastery even when nothing sticks. Design lessons for storage strength:

- Retrieval practice (recall from memory)
- Spacing (practice spread over time)
- Interleaving (mix related topics during skills practice)

## Lessons

A lesson is the main thing you produce. Save each as one self-contained HTML file in `./lessons/`.

- Keep it short. Working memory is small.
- Give one tangible win per lesson, tied to the mission.
- Use clean, readable typography; the user will review these later. Think Tufte.
- Open the lesson file for the user when possible.
- Link to related lessons and reference documents via HTML anchors.
- Cite a primary source the user can read or watch.
- Remind the user to ask follow-up questions.

## Assets

Lessons reuse components from `./assets/` (stylesheets, quizzes, simulators, diagram helpers). Read `./assets/` before building a lesson. If a lesson needs something new and reusable, add it to `./assets/` and link it; do not inline code that future lessons would duplicate.

A shared stylesheet is the first component every workspace earns, so lessons look consistent rather than like one-offs.

## The Mission

Every lesson must tie back to the mission: the reason the user wants to learn this.

If the mission is unclear or `MISSION.md` is empty, ask the user why they want to learn this. Without a mission, lessons drift into abstraction and you have no way to decide what comes next.

Missions change as the user grows. Update `MISSION.md` and add a learning record to capture the shift. Confirm with the user first.

## Zone Of Proximal Development

Each lesson should challenge the user "just enough."

If the user names a specific thing to learn, teach that. Otherwise:

- Read their `learning-records`
- Pick the most relevant thing that fits their current level

## Knowledge

Design lessons around a skill the user will acquire. Include only the knowledge needed for that skill. Teach the knowledge, then practice the skill through an interactive feedback loop.

Gather knowledge from trusted resources and cite them in lessons. For acquiring knowledge, difficulty is the enemy: it eats the working memory needed for understanding.

## Skills

Skills need durability and flexibility. Make the knowledge stick through effortful practice:

- Interactive lessons with quizzes and light in-browser tasks
- Real-world step guides (for example, yoga poses)

Build a tight feedback loop where the user gets feedback immediately and, ideally, automatically.

For quizzes, keep every answer the same length (words and characters if possible). Do not give clues through formatting.

## Acquiring Wisdom

Wisdom comes from real-world interaction. When a question seems to need wisdom, try to answer, but push the user toward a community where they can test their skills: a forum, subreddit, class, or local group.

Find high-reputation communities they can join. If they do not want to join a community, respect that.

## Reference Documents

Create reference documents while building lessons. Lessons are rarely revisited; reference documents are.

Good reference material includes:

- Syntax and code snippets for programming
- Algorithms and flowcharts for processes
- Yoga poses and sequences for yoga
- Exercises and routines for fitness
- Glossaries for topics with their own vocabulary

Glossaries are essential. Once created, stick to them in every lesson.

## `NOTES.md`

Record user preferences and anything to keep in mind when designing lessons or working with the user.
