ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}

ENV IGNITION_VERSION ${IGNITION_VERSION}

ARG USER=ros
ARG GROUP=ros
ARG USER_ID=1000
ARG GROUP_ID=1000

# local colcon workspace folder for ros-user
ARG COLCON_WS=/home/${USER}/ws

RUN groupadd -g ${GROUP_ID} ${GROUP}
RUN useradd -ms /bin/bash -u ${USER_ID} -g ${GROUP_ID} ${USER}

# install turtlebot navigation
RUN apt-get update &&\
  apt-get install \
    ros-${ROS_DISTRO}-ros2launch \
    ros-${ROS_DISTRO}-turtlebot3-navigation2 \
    ros-${ROS_DISTRO}-turtlebot3-cartographer \
    ros-${ROS_DISTRO}-turtlebot3-msgs \
    ros-${ROS_DISTRO}-imu-sensor-broadcaster \
    ros-${ROS_DISTRO}-diff-drive-controller \
    ros-${ROS_DISTRO}-effort-controllers \
    ros-${ROS_DISTRO}-joint-state-broadcaster \
    ros-${ROS_DISTRO}-ros2controlcli \
    ros-${ROS_DISTRO}-controller-manager \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    ros-${ROS_DISTRO}-ros-ign-gazebo \
    ros-${ROS_DISTRO}-ros-ign-bridge \
    ros-${ROS_DISTRO}-velocity-controllers \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-trajectory-controller \
    ros-${ROS_DISTRO}-turtlebot3-description \
    ros-${ROS_DISTRO}-rviz2 \
    libignition-gazebo6-dev \
    -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# We don't need sound
RUN echo "pcm.!default = null;" > /etc/asound.conf

COPY ./${SIM}/entrypoint.sh /ros2_ws_entrypoint.sh
RUN chmod a+x /ros2_ws_entrypoint.sh
ENTRYPOINT [ "/ros2_ws_entrypoint.sh" ]

RUN mkdir -p ${COLCON_WS}/log \
    && chown -R ${USER_ID}:${GROUP_ID} ${COLCON_WS}/

USER ros
WORKDIR /home/${USER}/

RUN cd ${COLCON_WS}/ \
    && git clone https://github.com/ahcorde/turtlebot3_simulations/ -b ahcorde/ignition_support \
    && git clone https://github.com/ignitionrobotics/ign_ros2_control -b ${ROS_DISTRO} \
    && rosdep update \
    && rosdep install --from-paths ./ -i -y --rosdistro ${ROS_DISTRO}

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd ${COLCON_WS}/ && \
  colcon build

CMD TURTLEBOT3_MODEL=burger ros2 launch turtlebot3_ignition ignition.launch.py
