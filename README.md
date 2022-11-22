# ROS 2 Humble Turtlebot 3 Ignition Docker
Minimalistic [ROS 2 humble](https://docs.ros.org/en/humble/index.html) simulation of the [Turtlebot 3](https://www.turtlebot.com/turtlebot3/) robot using the [Ignition](https://ignitionrobotics.org/) simulator inside a docker container (not Gazebo classic, see the officially provided ROS2-simulation packages for that).

based on https://github.com/ahcorde/turtlebot3_simulations/tree/ahcorde/ignition_support

Build using `docker-compose build` and then start calling `./run.bash` (to run the docker container inside an xhost environment).
