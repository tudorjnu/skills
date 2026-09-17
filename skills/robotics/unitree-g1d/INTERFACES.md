# G1D interface details

Exact names for every control surface the G1D_Developer docs cover. Service and topic names are verified against unitree_sdk2, unitree_slam, and teleimager source code; the support-site pages are a JavaScript app that returns only a shell to fetchers, so treat the pages as the index and the SDK as the source of truth.

## Joint control

Topics and types:

- `rt/lowcmd` (`unitree_hg::msg::dds_::LowCmd_`): fields `mode_pr`, `mode_machine`, `motor_cmd[35]`, `reserve[4]`, `crc`.
- `rt/lowstate` (`unitree_hg::msg::dds_::LowState_`): `version[2]`, `mode_pr`, `mode_machine`, `tick`, `imu_state`, `motor_state[35]`, `wireless_remote[40]`, `reserve[4]`, `crc`.
- `rt/secondary_imu` (`IMUState_`): torso IMU.
- Direct waist pitch: `rt/waistpitchcmd` (publish, `MotorCmd_`) and `rt/waistpitchstate` (subscribe, `MotorState_`).

MotorCmd fields: `mode` (1 enable, 0 disable), `q`, `dq`, `tau`, `kp`, `kd`. CRC32 (polynomial 0x04c11db7) over the message minus the crc field; the examples verify it on receive.

Rules and patterns from the official examples:

- Set `mode_pr = 0` and copy `mode_machine` from the latest `LowState_`.
- Example gains are tunings, not API limits: arms Kp 40 / Kd 1 and waist Kp 60 / Kd 1 in [`g1d_arm_example.cpp`](https://github.com/unitreerobotics/unitree_sdk2/blob/main/example/g1/g1d/g1d_arm_example.cpp); Kp 500 / Kd 12 in the direct waist example [`g1d_waist_example.cpp`](https://github.com/unitreerobotics/unitree_sdk2/blob/main/example/g1/g1d/g1d_waist_example.cpp).
- [`g1d_arm_example.cpp`](https://github.com/unitreerobotics/unitree_sdk2/blob/main/example/g1/g1d/g1d_arm_example.cpp) blocks until the remote A button is pressed: an interlock pattern to copy, not a protocol requirement.

## Move (base and column)

`unitree::robot::g1::AgvClient`, service `agv`, API version 1.0.0.1. Call `Init()` and `SetTimeout(...)` first; calls are non-blocking.

- `Move(vx, vy, vyaw)`: vx in [-1.5, 1.5] m/s, vyaw in [-0.6, 0.6] rad/s (positive = counter-clockwise); vy is ignored on the wheeled base; `Move(0, 0, 0)` stops.
- `HeightAdjust(vz)`: velocity command, vz in [-1.0, 1.0] maps to ±76.5 mm/s. To reach and hold a height, close the loop on the telemetry topic: `rt/hispeed_state` (`geometry_msgs::msg::dds_::Point32_`, height in the `y` field). [`g1d_height_control.cpp`](https://github.com/unitreerobotics/unitree_sdk2/blob/main/example/g1/g1d/g1d_height_control.cpp) does it with a 50 ms period, kP 20, kD 0.3, max normalized vz 0.8, and sends `HeightAdjust(0)` on arrival or timeout.

## Audio (TTS, ASR, streaming, LED)

`unitree::robot::g1::AudioClient` (C++, `include/unitree/robot/g1/audio/`), `unitree_sdk2py.g1.audio.AudioClient` (Python). Service `voice`, API version 1.0.0.0. Shared with the bipedal G1.

| API id | Constant |
| --- | --- |
| 1001 | TTS |
| 1002 | ASR |
| 1003 | start play / stream |
| 1004 | stop play |
| 1005 | get volume |
| 1006 | set volume |
| 1010 | set RGB LED |

- `TtsMaker(text, speaker_id)`: the example uses speaker_id 0 for Chinese with auto-play, 1 for English.
- `PlayStream(app_name, stream_id, pcm_data)`: raw PCM only, 16000 Hz, mono, 16-bit; the example sends 96000-byte chunks (about 3 s) with 1 s between chunks. `PlayStop(app_name)` stops.
- `LedControl(R, G, B)` drives the audio-subsystem RGB LED.
- ASR results arrive on `rt/audio_msg` (`std_msgs::msg::dds_::String_`).
- Microphone stream: UDP multicast group 239.168.123.161, port 5555, 16000 Hz mono 16-bit PCM.

Example: [`g1_audio_client_example.cpp`](https://github.com/unitreerobotics/unitree_sdk2/blob/main/example/g1/audio/g1_audio_client_example.cpp) (plus `test.wav`); Python bindings in [`unitree_sdk2py/g1/audio/`](https://github.com/unitreerobotics/unitree_sdk2_python/tree/master/unitree_sdk2py/g1/audio).

## SLAM and navigation

Runs as a pre-installed robot service. There is no typed SDK client: drive it over raw DDS topics with the example clients from the unitree_slam repo.

| Topic | Type | Direction |
| --- | --- | --- |
| `rt/qt_command` | `unitree_interfaces::msg::dds_::QtCommand_` | publish |
| `rt/qt_notice` | `std_msgs::msg::dds_::String_` | subscribe (feedback) |
| `rt/lio_sam_ros2/mapping/re_location_odometry` | `nav_msgs::msg::dds_::Odometry_` | subscribe |
| `rt/qt_add_node` | `unitree_interfaces::msg::dds_::QtNode_` | publish |
| `rt/qt_add_edge` | `unitree_interfaces::msg::dds_::QtEdge_` | publish |

Command values (from `demo_mid360.cpp`): 3 start mapping, 4 end mapping, 6 start relocation, 7 init pose, 8 start navigation, 10 multi-node default navigation, 13 pause, 14 recover, 99 close all nodes; command 1 deletes node(s) or edge(s) via `attribute_`. `attribute_` also selects the lidar: 1 = XT16, 2 = MID360.

Gotchas:

- Every command needs a unique `index:<n>;` string in `seq_` so feedback on `rt/qt_notice` can be matched.
- Fields the docs call "not open" must be set to 0, not left empty.
- G1D-specific SLAM wiring (sensor mount, launch, firmware) is not in the public examples; verify on the actual unit before relying on it.

Examples: [`demo_mid360.cpp`](https://github.com/unitreerobotics/unitree_slam/blob/main/unitree_slam_example/demo_mid360.cpp) and [`demo_xt16.cpp`](https://github.com/unitreerobotics/unitree_slam/blob/main/unitree_slam_example/demo_xt16.cpp), plus single-purpose binaries (start_mapping, end_mapping, start_relocation, pose_init, start_nav, pause_nav, recover_nav, add_node, add_edge, delete_node, delete_edge, close_all_node).

## Image server (TeleImager)

Official component: [teleimager](https://github.com/unitreerobotics/teleimager), which replaces the older image_server.py. The server runs on the robot's dev PC (192.168.123.164); the client runs on the workstation.

- CLIs: `teleimager-server` on the robot; `teleimager-client --host <robot_ip>` on the PC.
- Config: `~/.config/teleimager/teleimager_server.yaml`, seeded from the bundled template. Discover cameras with `teleimager-server --cf --uvc --v4l2 [--rs]` before writing it.
- Transports: ZMQ PUB-SUB per camera (template defaults: head 55555, left wrist 55556, right wrist 55557), ZMQ REQ-REP camera config on 60000, WebRTC signaling on 60001-60003 (requires TLS cert.pem / key.pem).
- Camera identifier priority: physical_path > serial_number > bcd_device > vid_pid > video_id; string ids must be quoted in the YAML.
- Native dependency: libjpeg-turbo 3.0+ with the PyTurboJPEG binding; do not install the PyPI package named turbojpeg.

## Chassis interfaces (remote control data)

There is no dedicated "chassis" SDK service. The base is the `agv` service (see Move), and the handheld remote state rides inside `LowState_.wireless_remote[40]`, decoded with `unitree::common::Gamepad` (`example/g1/g1d/gamepad.hpp`):

- Axes: `lx`, `ly`, `rx`, `ry`, `l2` (floats; helper applies smoothing 0.03 and dead zone 0.01).
- Buttons: `R1`, `L1`, `start`, `select`, `R2`, `L2`, `F1`, `F2`, `A`, `B`, `X`, `Y`, `up`, `right`, `down`, `left`; each exposes `pressed`, `on_press`, `on_release`.

`rt/wireless_controller` is a Go2 topic and is not used on G1D. `g1d_arm_example.cpp` gates all motion behind the remote A button; copy that interlock pattern for custom control code.

Sources: [unitree_sdk2](https://github.com/unitreerobotics/unitree_sdk2) (`example/g1/g1d`, `example/g1/audio`, `include/unitree/robot/g1/{agv,audio}`, `include/unitree/idl/hg`), [unitree_slam](https://github.com/unitreerobotics/unitree_slam) (`unitree_slam_example`), [teleimager](https://github.com/unitreerobotics/teleimager). The [G1D_Developer pages](https://support.unitree.com/home/en/G1D_Developer/) index these same interfaces; fetch them for current values.
