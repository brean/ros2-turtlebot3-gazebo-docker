#!/bin/bash
xhost +local:root
docker-compose run gz
xhost -local:root