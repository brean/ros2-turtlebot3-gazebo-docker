#!/bin/bash
time docker build --build-arg ROS_DISTRO=foxy -t brean/ros-turtlebot3-gazebo:foxy .
time docker push brean/ros-turtlebot3-gazebo:foxy