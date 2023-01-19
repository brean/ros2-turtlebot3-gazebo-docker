#!/bin/bash
xhost +local:root
docker-compose run turtlebot-gazebo ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
xhost -local:root