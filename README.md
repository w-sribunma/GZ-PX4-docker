# px4-gz-docker
Docker files needed to build images for px4_sitl simulation in ROS2 and Gazebo

The `./work` directory setup 

run `./get_src.sh` to clone each repo and add AbuDhabi model to px4 gz world (probably will set up submodules soon)
```
work/
┣ px4/
┣ ros2_ws/
┃ ┗ src/
┃   ┣ px4_msgs/
┃   ┣ px4-offboard/
┃   ┗ ros_gz/
┗ .gitignore
```
Please build ros_gz from source. [see ros-gz](https://github.com/gazebosim/ros_gz)


### Build and run
To build the image
```bash
docker compose build
```
To run multiple drones

```bash
./run_dev.sh
```

To access the shell of each service, in two different terminals run

Terminal 1: `docker exec -u user -it px4_gz-px4_gz-1 terminator`\

To start px4_sitl and ros2 offboard control, split each terminator into 3 panels and run

1. `cd px4 && make px4_sitl` to build px4_sitl first. (This only need to be built once in one of the container shells)\
`PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL=x500_lidar ./build/px4_sitl_default/bin/px4 -i 1` to start px4_sitl instance 1 with x500 with added lidar plugin in gz-garden. (PX4_GZ_MODEL=x500 to run base x500 model)\

2. `MicroXRCEAgent udp4 -p 8888` to start DDS agent for communication with ROS2\


### Environment Variables
- `PX4_GZ_MODEL` Name of the px4 vehicle model to spawn in gz
- `PX4_GZ_MODEL_POSE` Spawn pose of the vehicle model, must used with `PX4_GZ_MODEL`
- `PX4_MICRODDS_NS` Namespace assigned to the sitl vehicle, normally associated with px4 instances, but can be set mannually
- `ROS_DOMAIN_ID` Separate each container into its own domain (Is it still necessary since each SITL instance has a unique namespace?)
  
### Drivers and Supporting Software
Tested versions:
- Ros: `Rolling`
- Gazebo: `Garden`
- Docker: `24.0.7`

#### Install Docker CLI
- Install Docker CLI using the instructions on the [Docker Installation Page](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).
- Note: Docker Desktop may interfere with Nvidia Drivers.

#### Nvidia Drivers
- Automatically install recommended drivers:
  ```bash
  sudo ubuntu-drivers autoinstall
  ```
- Manually install recommended drivers:
  `ubuntu-drivers devices` To list recommended drivers
  ```bash
    sudo apt install nvidia-driver-<version>
    ```
- Nvidia Container Toolkit
    if encountering a ‘nvidia-container-cli’ initialization error, refer to the [Nvidia Container Toolkit Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

#### Debugging
- If encountering an error related to “actuator_msgs” during docker build:
    - Include [actuator_msg](https://github.com/rudislabs/actuator_msgs) package from source


### Resources
- PX4 with ROS-Gazebo simulation overview: [PX4 Dev Guide](https://dev.px4.io/master/en/simulation/ros_interface.html)
- Previous Spring 2022 IEEE Autonomous UAV "Drone" Chase Challenge - [Video](https://www.youtube.com/watch?v=uISFK83FSmQ&ab_channel=JamesGoppert)
- Issues Tracking: [Github Issues]