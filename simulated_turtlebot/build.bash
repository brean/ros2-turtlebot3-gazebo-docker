#!/bin/bash
time docker build --build-arg ROS_DISTRO=foxy -t brean/ros2-turtlebot3-gazebo:foxy .
time docker push brean/ros2-turtlebot3-gazebo:foxy
# building takes around 5 minutes on an i7-8550U with fast internet