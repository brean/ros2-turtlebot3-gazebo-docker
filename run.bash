#!/bin/bash
docker network create turtlebot
terminator -l turtlebot -g terminator.conf
xhost -local:root
cd remote_pc/ && docker-compose down && cd ..
cd simulated_turtlebot && docker-compose down && cd ..
docker network rm turtlebot