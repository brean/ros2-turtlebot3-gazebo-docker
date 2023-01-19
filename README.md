# ROS 2 foxy Gazebo Simulation in docker

## Motivation
Run gazebo classic simulation with Turtlebot 3 in a local docker container for testing.

## Installation
1. Install docker. Make sure you have the right version for your graphic-card installed (e.g. [docker-nvidia2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) for NVIDIA graphics cards)!
1. Install `terminator` using your systems package manager (e.g. `sudo apt install terminator`).

## General Usage
After you installed docker and terminator you can directly call the `./run.bash`-script, it starts the robot in the basic Turtlebot environment as well as everything that is needed for autonomous navigation and rviz2.


## Development
**Note that you don't need to run the build script, the image is pushed to docker hub, just run `docker-compose pull`!**

If you want to rebuild the docker-container and do not want to use the provided container from docker hub you can force a rebuild it by running `./build.bash` in the subfolder.

### Custom ros2-commands from the host system
If you like to access the robot from outside the docker network don't forget to configure ROS_DOMAIN_ID (default 30) and TURTLEBOT3_MODEL (default burger). You can also change this for the simulation in the docker-compose file.

When you close the terminator-window `docker-compose down` will be executed in the `remote-pc` and `simulated_turtlebot` subfolders to stop all remaining docker instances. Note that this might also stop other docker container you are running!
