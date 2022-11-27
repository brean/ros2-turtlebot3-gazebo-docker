#!/bin/bash
xhost +local:root
docker-compose run humble_garden $@
xhost -local:root