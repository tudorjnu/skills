---
name: setup-robotics-skills
description: "Wire a robotics repo's AGENTS.md to the Unitree skills: record the fleet this repo controls and make agents read the unitree-robots, unitree-g1, and unitree-g1d skills before writing robot code. Run once per robotics repo."
disable-model-invocation: true
---

# Setup Robotics Skills

Create the per-repo robotics context the Unitree skills expect:

- **Fleet**: which Unitree robots this repo controls, with variants and units
- **Skill wiring**: an `## Robotics` block in `AGENTS.md` that makes every agent read the Unitree skills before touching robot code
- **Robot notes**: `docs/agents/robots.md` with per-unit details and network setup

This is prompt-driven, not scripted. Explore, summarize, confirm, then write.

## Process

### 1. Explore

Read whatever exists; do not assume:

- `AGENTS.md` at the repo root: does it exist? Is there already a `## Robotics` section?
- `docs/agents/robots.md`: does prior output already exist?
- The Unitree skills: are `unitree-robots`, `unitree-g1`, and `unitree-g1d` installed under `~/.agents/skills/`? If not, say so and stop: run `scripts/link-skills.sh` in the skills repo first, then re-run. Record the install path you find; the AGENTS.md block points agents at it.
- Robot signals: search the repo for `unitree`, `g1`, `lowcmd`, `cyclonedds`, `unitree_hg`, and `192.168.123` to see what it already touches.

### 2. Present findings and ask

Lead with the recommended answer so the user can accept it in one word.

**Robots in scope.** Which Unitree robots does this repo work with? Default to what the repo signals plus the user's answer. For each robot, confirm the variant that matters for code: G1 base 23-DOF, EDU 29-DOF, or 14-DOF upper body; G1D Standard fixed-base or Flagship wheeled. Ask for unit count, names, and IPs; blank cells are fine.

**Network.** Which IP does the dev machine use on the robot subnet (default `192.168.123.99`), and which network interface?

### 3. Confirm and edit

Show the user a draft of:

- The `## Robotics` block to add to `AGENTS.md` at the repo root
- The contents of `docs/agents/robots.md`

Let them edit before writing.

### 4. Write

Edit `AGENTS.md` at the repo root. If a `## Robotics` section already exists, update it in place. Never create `CLAUDE.md`. If `AGENTS.md` does not exist, create it with just this section and tell the user `/setup-engineering-skills` can add the engineering workflow sections later.

The block:

```markdown
## Robotics

This repo controls Unitree robots. Before writing or reviewing robot code, load the Unitree skills; if your harness does not auto-load them, read their SKILL.md files:

- `unitree-robots`: SDK stack, network and DDS setup, legacy-SDK traps
- `unitree-g1`: the bipedal G1 humanoid (variants, joint map, topics, APIs)
- `unitree-g1d`: the G1D dual-arm platform (not a biped; AGV base and column)

They are installed under `~/.agents/skills/`. Update them from the skills repo with `scripts/link-skills.sh`.

Hard rules until the skills are loaded:

- G1 and G1D are different robots. G1 walks; G1D has a fixed or wheeled base and no leg actuators.
- Never assume DOF counts or joint indices; read them from the robot (`mode_machine`) or the skill's joint tables.
- On G1, low-level `rt/lowcmd` control requires `MotionSwitcherClient::ReleaseMode()` first.
- G1 has no physical e-stop. Damp first, then power off.

Fleet details: see `docs/agents/robots.md`.
```

Then write `docs/agents/robots.md` from the [robots.md](./robots.md) seed in this skill folder, filling in the fleet and network answers.

### 5. Done

Tell the user setup is complete and that pi agents load these skills automatically when robot work is detected. Re-run this skill only when the fleet changes.

## How the robotics skills work

- `unitree-robots` covers the shared stack; `unitree-g1` and `unitree-g1d` cover robot specifics. Load the one matching the robot in front of you, not from memory.
- The skills hold stable facts only. Firmware, downloads, and prices drift; the skills point to the official sources instead of caching them.
- `docs/agents/robots.md` is the fleet inventory; keep it current as units are added or reconfigured.
