# ROS 2 Humble Turtlebot 3 Gazebo Garden Docker
Minimalistic [ROS 2 humble](https://docs.ros.org/en/humble/index.html) simulation of the [Turtlebot 3](https://www.turtlebot.com/turtlebot3/) robot using the latest [Gazebo 7 Garden](https://gazebosim.org/) simulator inside a docker container (not Gazebo classic, see the officially provided ROS2-simulation packages for that).

On the current **bleeding edge** versions of gz_ros2_control, ros_gz (ros2) and gz-transport (gz-transport12) after the renaming from ignition back to gazebo
based on the [feature-ign_gazebo](https://github.com/ROBOTIS-GIT/turtlebot3_simulations/tree/feature-ign_gazebo)-branch, thanks to @ahcorde, @ROBOTIS-Will and others!


## Installation and running
Build using `docker-compose build` and then start calling `./run.bash` (to run the docker container inside an xhost environment).

If you want to rebuild the original base-image (e.g. because you have changes in the turtlebot3_simulation folder) run the `build_base_image.bash`-script.

Because we are using some special branches after the renaming of gazebo from iginition back to gazebo some stuff might break in the future!

---

## Background: Gazebo (classic) -> Ignition -> Gazebo Sim
Note that Gazebo is named **Gazebo** again after changing the name of the newer releases to **Iginition** for some years (see [A new era for Gazebo](https://community.gazebosim.org/t/a-new-era-for-gazebo/1356) and [Migration from Ignition](https://gazebosim.org/docs/garden/migration_from_ignition))

The current version of Gazebo (7) is called **Garden**, so when in doubt we use "garden" to make clear what version we use, otherwise "gz-sim", "gz-sim7" or "Gazebo Sim" should be used as name to make clear that this is neither "Ignition" nor "Gazebo Classic".
