#!/bin/bash
docker network create turtlebot
xhost +local:root
docker-compose run humble_garden $@
xhost -local:root