#!/bin/bash
time docker build --build-arg ROS_DISTRO=humble -t brean/ros2-turtlebot3-gazebo:humble .
time docker push brean/ros2-turtlebot3-gazebo:humble
# building takes around 8 minutes on an i7-8550U with fast internet