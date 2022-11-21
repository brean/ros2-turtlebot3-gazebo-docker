#!/bin/bash
xhost +local:root
docker-compose run humble_sim $@
xhost -local:root