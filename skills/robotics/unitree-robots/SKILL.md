---
name: unitree-robots
description: 'Unitree robot software stack: which SDK, repo, or package applies to a given Unitree robot, CycloneDDS and network setup, install paths, and legacy-SDK traps. Use whenever writing or reviewing code that talks to Unitree robots (G1, G1D, Go2, B2, H1, H2), or when choosing ROS/ROS2 packages, simulators, or model assets for them.'
---

# Unitree robot software stack

Shared facts for the Unitree fleet. Robot-specific facts live in the unitree-g1 and unitree-g1d skills: load the one matching the robot in front of you.

## Two SDK generations

| SDK | Middleware | Robots | Status |
| --- | --- | --- | --- |
| `unitree_sdk2` (C++) and `unitree_sdk2_python` | CycloneDDS | G1, G1D, Go2, B2, H1 and newer | current |
| `unitree_legged_sdk` | LCM/UDP | Go1 only per its README | legacy; NOT for G1 or G1D |

The most common Unitree coding mistake is reaching for the wrong generation. G1 and G1D code goes through `unitree_sdk2` / `unitree_sdk2_python`, never `unitree_legged_sdk`.

## Repo map

| Repo | What it is | Notes |
| --- | --- | --- |
| github.com/unitreerobotics/unitree_sdk2 | C++ SDK: low-level, high-level, video, lidar clients | Current. Prebuilt static libs for x86_64 and aarch64. |
| github.com/unitreerobotics/unitree_sdk2_python | Official Python bindings | Install from source; PyPI names are ambiguous. |
| github.com/unitreerobotics/unitree_ros2 | ROS2 message packages and examples | README robot list is stale: G1 and H1-2 examples exist in the repo. |
| github.com/unitreerobotics/unitree_ros | ROS1/Gazebo simulation and URDF descriptions | `robots/g1_description` (URDF/MJCF) lives here. |
| huggingface.co/datasets/unitreerobotics/unitree_model | URDF/MJCF/USD model assets | The GitHub unitree_model repo is deprecated; this is the current home. |
| github.com/unitreerobotics/unitree_mujoco | MuJoCo simulator speaking the same DDS topics | Sim-to-real path. Sim runs DDS domain 1 to avoid colliding with a live robot on domain 0. |
| github.com/unitreerobotics/unitree_rl_gym | Isaac-Gym RL training (G1, H1, Go2) | Older stack. |
| github.com/unitreerobotics/unitree_rl_lab | Isaac-Lab RL training (G1 29-DOF) | Newer stack. |

## IDL namespaces

| Robot family | Namespace |
| --- | --- |
| G1, G1D, H1, H2 (humanoid generation) | `unitree_hg::msg::dds_` |
| Go2, B2 (quadruped generation) | `unitree_go::msg::dds_` |

Applying `unitree_go` message types to G1/G1D code is a hard error: the layouts differ.

## Network and DDS setup

- Robots live on `192.168.123.x/24`. Set the dev PC to a static IP in that subnet (official examples use `192.168.123.99`), connected by Ethernet.
- CycloneDDS version is 0.10.2 across the stack. The C++ SDK bundles it; the Python SDK needs `cyclonedds == 0.10.2` (set `CYCLONEDDS_HOME` if pip cannot find it).
- DDS domain: 0 for a real robot; unitree_mujoco uses 1.
- ChannelFactory init: `ChannelFactory::Instance()->Init(0, "eth0")` with the domain and the wired interface name.
- Raw SDK topics carry the `rt/` prefix (`rt/lowcmd`); ROS2 remapping drops it (`/lowcmd`). Never invent topic names.
- ROS2: `export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp` and point `CYCLONEDDS_URI` at XML naming the wired interface. Use `lo` for simulation.

## Install

```bash
# C++
git clone https://github.com/unitreerobotics/unitree_sdk2.git
cd unitree_sdk2 && mkdir build && cd build && cmake .. && make

# Python: install from source, do not guess the PyPI name
git clone https://github.com/unitreerobotics/unitree_sdk2_python.git
cd unitree_sdk2_python && pip3 install -e .
```

PyPI has packages named unitree-sdk2 and unitree-sdk2py, but naming is ambiguous; source install is the reproducible path.

## Platform support

Ubuntu 20.04 LTS, x86_64 and aarch64. Windows and macOS are not supported by the official SDK.

## Common mistakes

| Wrong | Right |
| --- | --- |
| `unitree_legged_sdk` for G1/G1D | `unitree_sdk2` / `unitree_sdk2_python` |
| Guessed pip name (`pip install unitree_sdk2`) | Clone the repo and `pip3 install -e .` |
| Invented topics like `/joint_commands` | The robot skill's topic table (`rt/lowcmd`, `rt/lowstate`, ...) |
| `unitree_go` types for a humanoid | `unitree_hg` types |
| unitree_model on GitHub | Hugging Face dataset |
| Trusting the unitree_ros2 README robot list | README is stale; G1 examples are in the repo |
| Windows or macOS deploy target | Ubuntu 20.04 LTS only |
| Skipping CycloneDDS setup | 0.10.2, domain 0, correct interface in CYCLONEDDS_URI |

## What to defer to the web

Release tags, changelogs, firmware downloads, PyPI naming, and README claims drift over time. Check the repos above instead of hard-coding versions from memory. Deep reference material (full manuals, torque tables, RL training configs) also lives behind the links above, not in this skill.
