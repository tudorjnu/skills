---
name: unitree-g1d
description: 'Unitree G1D (G1-D) dual-arm platform: fixed or wheeled base, lifting column, arm joint layout, AgvClient base and column control, official examples, and G1 vs G1D differences. Use whenever working with a Unitree G1D or G1-D. It is not the bipedal G1; do not apply G1 locomotion facts to it.'
---

# Unitree G1D (G1-D, dual-arm platform)

## What it is

A dual-arm robot built from the G1 upper body on a fixed base (Standard) or a wheeled differential-drive base (Flagship/Ultimate), positioned as a data-acquisition, training, and inference platform. It has no leg actuators: it does not walk, climb stairs, or balance. Writing G1 bipedal control code for a G1D is the defining G1D mistake.

The "D" is not officially expanded in English materials; Chinese materials call it a data-acquisition and training full-stack solution.

## Variants and hardware

| Tier | Base | DOF excl. end-effector |
| --- | --- | --- |
| Standard | fixed | 17 (2x7 arms + 2 waist + 1 column) |
| Flagship/Ultimate | wheeled differential drive | 19 (+2 chassis) |

- Weights: official Unitree pages disagree (unitree-robot.com lists Standard about 50 kg and Flagship about 80 kg; <www.unitree.com> lists Standard and Ultimate at about 90 kg). Weigh the actual unit before payload or rigging plans.
- 7-DOF arms, about 3 kg payload per arm, about 0.45 m reach. 2-DOF waist: yaw ±155 deg, pitch -2.5 to +135 deg.
- 500 mm lifting column, about 60 mm/s; total height 1260-1680 mm.
- Wheeled base: up to 1.5 m/s, 360 deg in-place rotation.
- Compute: Jetson Orin NX 16 GB (100 TOPS); Wi-Fi 6, Bluetooth 5.2. Head binocular camera plus two wrist cameras; Flagship adds LiDAR, depth cameras, and collision sensors.
- End-effectors by SKU: Dex1-1 2-finger gripper, Dex3-1 3-finger hand (7 DOF, with or without tactile), 5-finger hand. Reseller SKUs (U1, U6-U10) differ in bundled hand and compute: check the specific unit, not just the model name.
- Battery: Standard about 2 h from 9 Ah; Flagship about 6 h with an added 30 Ah chassis battery.

## Control: same SDK as G1, no legs

Same stack as the G1: unitree_sdk2 / unitree_sdk2_python, CycloneDDS 0.10.2, `unitree_hg::msg::dds_` namespace. Topics: `rt/lowcmd` (`LowCmd_`), `rt/lowstate` (`LowState_`), `rt/secondary_imu` (`IMUState_`).

The motor array is still 29 slots (`G1D_NUM_MOTOR = 29`), but the leg slots are invalid:

| Index | Meaning |
| --- | --- |
| 0-11 | invalid: no leg joints; never command these |
| 12 | WaistYaw |
| 13 | unused |
| 14 | WaistPitch |
| 15-21 | Left arm: shoulder pitch, shoulder roll, shoulder yaw, elbow, wrist roll, wrist pitch, wrist yaw |
| 22-28 | Right arm: same order |

From `example/g1/g1d/g1d_arm_example.cpp`, whose example gains (tunings, not API limits) are waist Kp 60 / Kd 1, arms Kp 40 / Kd 1. Full per-interface details: [INTERFACES.md](INTERFACES.md).

### AGV base and column: AgvClient

`unitree::robot::g1::AgvClient`, service name `agv`, API version 1.0.0.1:

- `Move(vx, vy, vyaw)`, API ID 1001: vx in [-1.5, 1.5] m/s, vyaw in [-0.6, 0.6] rad/s (positive = counter-clockwise); vy is ignored on the wheeled base; `Move(0, 0, 0)` stops.
- `HeightAdjust(vz)`, API ID 1002: vz in [-1.0, 1.0] maps linearly to column speed ±76.5 mm/s. It is a velocity command, not a position command: reach and hold heights with a feedback loop on the telemetry below.
- Column height feedback: `rt/hispeed_state` (`geometry_msgs::msg::dds_::Point32_`), height in the `y` field. The official height-control example closes the loop at 50 ms with kP 20, kD 0.3, and sends `HeightAdjust(0)` on arrival.

### Official examples (example/g1/g1d in unitree_sdk2)

- `g1_agv_client_example.cpp`: periodic base and column motion.
- `g1d_arm_example.cpp`: low-level 29-slot arm control.
- `g1d_height_control.cpp`: PD column positioning using `rt/hispeed_state`.
- `g1d_waist_example.cpp`: direct waist-pitch control over `rt/waistpitchcmd` / `rt/waistpitchstate`.

## Interface map

The G1D_Developer docs cover six control surfaces. Exact names and gotchas for each: [INTERFACES.md](INTERFACES.md). This is the map:

| Interface | Entry point | Where |
| --- | --- | --- |
| Joint control (arms, waist) | `rt/lowcmd` / `rt/lowstate`; direct waist: `rt/waistpitchcmd` / `rt/waistpitchstate` | example/g1/g1d |
| Move (base + column) | `g1::AgvClient`, service `agv` | example/g1/g1d |
| Audio (TTS, ASR, volume, LED) | `g1::AudioClient`, service `voice` | example/g1/audio |
| SLAM / navigation | `rt/qt_command` protocol via the unitree_slam repo; no typed SDK client | unitree_slam |
| Image server (cameras) | TeleImager running on the dev PC (192.168.123.164) | teleimager repo |
| Chassis interfaces (remote data) | `LowState_.wireless_remote[40]` + `unitree::common::Gamepad` | example/g1/g1d/gamepad.hpp |

## Hands

Dex3-1 hands use the 7-motor topics `rt/dex3/{left,right}/{cmd,state}` (`HandCmd_` / `HandState_`, motor order thumb_0, thumb_1, thumb_2, middle_0, middle_1, index_0, index_1). The simpler 4-motor path uses `rt/hand_sdk` with a blend weight. Do not mix the two interfaces.

## G1 vs G1D

| | G1 | G1D |
| --- | --- | --- |
| Locomotion | bipedal, walks | fixed or wheeled base, no legs |
| Body DOF | 23-43 | 17-19 excl. end-effector |
| Motor indices 0-11 | leg joints | invalid |
| High-level base control | LocoClient, service `sport`, IDs 7001+ | AgvClient, service `agv`, IDs 1001-1002 |
| Lifting column | none | 500 mm, feedback on `rt/hispeed_state` |
| Wrist cameras | no | yes |
| Purpose | locomotion and full-body research | manipulation data collection |

## Common mistakes

| Wrong | Right |
| --- | --- |
| "G1D is a bipedal humanoid that walks" | No leg actuators; fixed or wheeled base |
| G1 DOF numbers (23-43) for G1D | 17-19 excl. end-effector |
| Commanding motor indices 0-11 | Invalid on G1D; arms start at 15 |
| Assuming a native G1D ROS2 package | No official G1D ROS2 node; the same DDS topics are reachable via unitree_ros2 packages with the CycloneDDS RMW |
| Mixing hand interfaces | Dex3-1: `rt/dex3/...`; 4-motor path: `rt/hand_sdk` |
| Treating all SKUs as identical | U1/U6-U10 differ in hand, compute, mobility |
| `rt/wireless_controller` for the G1D remote (that is a Go2 topic) | Decode `LowState_.wireless_remote[40]` with the `Gamepad` helper (example/g1/g1d/gamepad.hpp) |
| `HeightAdjust` as a position command | Velocity only; run a feedback loop on `rt/hispeed_state` |
| Inventing audio or SLAM clients inside unitree_sdk2 | Audio is `g1::AudioClient` (service `voice`); SLAM is a robot-side service driven over `rt/qt_command` (unitree_slam repo) |

## Maturity and pointers

G1D documentation is still filling in: there is a G1D_Developer section on the support site, G1D code in unitree_sdk2 (`example/g1/g1d`, `include/unitree/robot/g1/agv`), and product listings, but no public G1D-specific user manual and no dedicated ROS2 node. For anything version-sensitive (firmware, SKU details, prices, availability), fetch these links rather than relying on cached knowledge.

Official G1D_Developer pages, one per interface: [about](https://support.unitree.com/home/en/G1D_Developer/about), [joint control](https://support.unitree.com/home/en/G1D_Developer/joint%20control), [move](https://support.unitree.com/home/en/G1D_Developer/move), [audio](https://support.unitree.com/home/en/G1D_Developer/audio), [slam](https://support.unitree.com/home/en/G1D_Developer/slam), [image_server](https://support.unitree.com/home/en/G1D_Developer/image_server), [chasis_interfaces](https://support.unitree.com/home/en/G1D_Developer/chasis_interfaces) (Unitree's own URL spelling).

Code entry points: unitree_sdk2 [example/g1/g1d](https://github.com/unitreerobotics/unitree_sdk2/tree/main/example/g1/g1d) and [example/g1/audio](https://github.com/unitreerobotics/unitree_sdk2/tree/main/example/g1/audio), [unitree_slam](https://github.com/unitreerobotics/unitree_slam), [teleimager](https://github.com/unitreerobotics/teleimager).
