# Robots

The Unitree fleet this repo controls, recorded by `/setup-robotics-skills` on [date]. Edit this file directly as robots are added or reconfigured; nothing else keeps it current.

## Fleet

| Name | Model and variant | IP / subnet | Notes |
| ---- | ----------------- | ----------- | ----- |
| … | e.g. G1 EDU 29-DOF | 192.168.123.x | … |
| … | e.g. G1D Flagship (wheeled) | 192.168.123.x | … |

## Network

- Dev PC IP on the robot subnet: [192.168.123.99]
- Network interface: [eth0]
- DDS domain: 0 (CycloneDDS 0.10.2)

## Skills

Read the Unitree skills before writing robot code: `unitree-robots` (shared stack), `unitree-g1` (bipedal humanoid), `unitree-g1d` (dual-arm platform). Update them from the skills repo with `scripts/link-skills.sh`.
