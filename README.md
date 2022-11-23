# ROS 2 Humble Turtlebot 3 Gazebo Garden Docker
Minimalistic [ROS 2 humble](https://docs.ros.org/en/humble/index.html) simulation of the [Turtlebot 3](https://www.turtlebot.com/turtlebot3/) robot using the latest [Gazebo 7 Garden](https://gazebosim.org/) simulator inside a docker container (not Gazebo classic, see the officially provided ROS2-simulation packages for that).

based on [ahcorde/ignition_support](https://github.com/ahcorde/turtlebot3_simulations/tree/ahcorde/ignition_support) and others


## Gazebo (classic) -> Ignition -> Gazebo Sim
Note that Gazebo is named **Gazebo** again after changing the name of the newer releases to **Iginition** for some years (see [A new era for Gazebo](https://community.gazebosim.org/t/a-new-era-for-gazebo/1356) and [Migration from Ignition](https://gazebosim.org/docs/garden/migration_from_ignition))

The current version of Gazebo is called **Garden**, so when in doubt we use "garden" to make clear what version we use, otherwise "gz-sim" or "Gazebo Sim" should be used as name to make clear that this is neither "Ignition" nor "Gazebo Classic".

## Installation and running
Build using `docker-compose build` and then start calling `./run.bash` (to run the docker container inside an xhost environment).