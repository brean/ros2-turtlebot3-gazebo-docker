#!/bin/bash
set -e

# setup gazebo and ros environment
source "/usr/share/gazebo/setup.sh" --
source "/opt/ros/$ROS_DISTRO/setup.bash" --
exec "$@"