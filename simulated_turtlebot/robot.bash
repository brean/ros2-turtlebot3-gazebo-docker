#!/bin/bash
# run commands on the container for the robot
xhost +local:root
docker-compose run turtlebot-gazebo $@
xhost -local:root