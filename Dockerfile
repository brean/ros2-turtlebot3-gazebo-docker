ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}

ARG USER=ros
ARG GROUP=ros
ARG USER_ID=1000
ARG GROUP_ID=1000

# local colcon workspace folder for ros-user
ARG COLCON_WS=/home/${USER}/ws

RUN groupadd -g ${GROUP_ID} ${GROUP}
RUN useradd -ms /bin/bash -u ${USER_ID} -g ${GROUP_ID} ${USER}

RUN apt-get update &&\
  apt-get install -y \
    wget gpg &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/*

# install latest gazebo garden release
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg &&\
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null &&\
  apt-get update &&\
  apt-get install -y gz-garden &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/*


# install turtlebot description and navigation packages
# libignition should become libgazebo in the future?!
RUN apt-get update &&\
  apt-get install \
    ros-${ROS_DISTRO}-ros2launch \
    ros-${ROS_DISTRO}-turtlebot3-navigation2 \
    ros-${ROS_DISTRO}-turtlebot3-cartographer \
    ros-${ROS_DISTRO}-turtlebot3-msgs \
    ros-${ROS_DISTRO}-turtlebot3-description \
    ros-${ROS_DISTRO}-imu-sensor-broadcaster \
    ros-${ROS_DISTRO}-diff-drive-controller \
    ros-${ROS_DISTRO}-effort-controllers \
    ros-${ROS_DISTRO}-joint-state-broadcaster \
    ros-${ROS_DISTRO}-ros2controlcli \
    ros-${ROS_DISTRO}-controller-manager \
    ros-${ROS_DISTRO}-velocity-controllers \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-trajectory-controller \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-tricycle-controller \
    libignition-msgs8-dev \
    libignition-transport11-dev \
    -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# We don't need sound
RUN echo "pcm.!default = null;" > /etc/asound.conf

COPY ./entrypoint.sh /ros2_ws_entrypoint.sh
RUN chmod a+x /ros2_ws_entrypoint.sh
ENTRYPOINT [ "/ros2_ws_entrypoint.sh" ]

RUN mkdir -p ${COLCON_WS}/log \
    && chown -R ${USER_ID}:${GROUP_ID} ${COLCON_WS}/

USER ros
WORKDIR /home/${USER}/

RUN cd ${COLCON_WS}/ \
    && git clone https://github.com/ros-controls/gz_ros2_control.git -b ${ROS_DISTRO} \
    && git clone https://github.com/gazebosim/ros_gz.git -b ${ROS_DISTRO}
    # && git clone https://github.com/gazebosim/gz-transport.git -b gz-transport12
    # && rosdep update \
    # && rosdep install --from-paths ./ -i -y --rosdistro ${ROS_DISTRO}

# COPY ./turtlebot3_simulations ${COLCON_WS}/turtlebot3_simulations

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd ${COLCON_WS}/ && \
  colcon build

CMD gz sim
#ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
