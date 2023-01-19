#!/bin/bash
terminator -l turtlebot -g terminator.conf
xhost -local:root
cd remote_pc/ && docker-compose down
cd simulated_turtlebot && docker-compose down