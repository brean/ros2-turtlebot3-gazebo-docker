#!/bin/bash
set -e

# setup gazebo environment
source /usr/share/gazebo/setup.sh

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
exec "$@"