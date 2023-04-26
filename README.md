# ROS 2 Humble Turtlebot 3 Gazebo Garden Docker
Minimalistic [ROS 2 humble](https://docs.ros.org/en/humble/index.html) simulation of the [Turtlebot 3](https://www.turtlebot.com/turtlebot3/) robot using the latest [Gazebo 7 Garden](https://gazebosim.org/) simulator inside a docker container (not Gazebo classic, see the officially provided ROS2-simulation packages for that).

On the current **bleeding edge** versions of gz_ros2_control, ros_gz (ros2) and gz-transport (gz-transport12) after the renaming from ignition back to gazebo
based on the [feature-ign_gazebo](https://github.com/ROBOTIS-GIT/turtlebot3_simulations/tree/feature-ign_gazebo)-branch, thanks to @ahcorde, @ROBOTIS-Will and others!

![](doc/gz_sim_and_rviz2.gif)

## Installation and running
1. Check out all submodules with this repository (`git submodule init && git submodule update -r`)
1. Install docker. Make sure you have the right version for your graphic-card installed (e.g. [docker-nvidia2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) for NVIDIA graphics cards)!
1. Run `./build_base_image.bash` to build the base image.
1. After that build execute `docker-compose build` and then call `./run.bash` (to run the docker container inside an xhost environment).

If you want to rebuild the original base-image (e.g. because you have changes in the turtlebot3_simulation folder) run the `build_base_image.bash`-script again.

Because we are using some special branches after the renaming of gazebo from ignition back to gazebo some stuff might break in the future!

## General Usage
After you installed docker and terminator you can directly call the `./run.bash`-script, it starts the robot in the basic Turtlebot environment as well as everything that is needed for autonomous navigation and rviz2.

### Custom ros2-commands from the host system
If you like to run custom ROS commands you can do so by going into the `remote-pc`-folder and execute `./turtlebot.bash YOUR_ROS_COMMAND` like so:

```bash
cd remote-pc
./turtlebot.bash ros2 topic list
```

## Cleanup
When you close the terminator-window `docker-compose down` will be executed in the `remote_pc` and `simulated_turtlebot` subfolders to stop all remaining docker instances. Note that this might also stop other docker container you are running!

## Contributing

Please use the [issue tracker](https://github.com/brean/ros2-turtlebot3-gazebo-docker/issues) to submit bug reports and feature requests. Please use merge requests as described [here](/CONTRIBUTING.md) to add/adapt functionality. 

## License

This code is distributed under the [3-clause BSD license](https://opensource.org/licenses/BSD-3-Clause).

## Maintainer / Authors / Contributers

Andreas Bresser, andreas.bresser@dfki.de

---

## Background: Gazebo (classic) → Ignition → Gazebo Sim
Note that Gazebo is named **Gazebo** again after changing the name of the newer releases to **Iginition** for some years (see [A new era for Gazebo](https://community.gazebosim.org/t/a-new-era-for-gazebo/1356) and [Migration from Ignition](https://gazebosim.org/docs/garden/migration_from_ignition))

The current version of Gazebo (7) is called **Garden**, so when in doubt we use "garden" to make clear what version we use, otherwise "gz-sim", "gz-sim7" or "Gazebo Sim" should be used as name to make clear that this is neither "Ignition" nor "Gazebo Classic".
