ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-turtlebot3-simulations \
  && rm -rf /var/lib/apt/lists/*

ARG ROS_DOMAIN_ID=30
ARG TURTLEBOT3_MODEL=burger

# burger, waffle, waffle_pi
ENV TURTLEBOT3_MODEL ${TURTLEBOT3_MODEL}

#TURTLEBOT3 defaults to 30
ENV ROS_DOMAIN_ID ${ROS_DOMAIN_ID}
