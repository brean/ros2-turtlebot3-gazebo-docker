ARG ROS_DISTRO
FROM ros:${ROS_DISTRO}

ARG USER=ros
ARG GROUP=ros
ARG USER_ID=1000
ARG GROUP_ID=1000

ENV DEBIAN_FRONTEND noninteractive

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
RUN apt-get update \
  && apt-get -y install \
    ros-${ROS_DISTRO}-ros2launch \
    # the DEB-package uses Gazebo classic, we want garden.
    # ros-${ROS_DISTRO}-turtlebot3-simulations \
    ros-${ROS_DISTRO}-slam-toolbox \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-turtlebot3-cartographer \
    ros-${ROS_DISTRO}-controller-manager \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


# We don't need sound
RUN echo "pcm.!default = null;" > /etc/asound.conf

COPY ./entrypoint.sh /ros2_ws_entrypoint.sh
RUN chmod a+x /ros2_ws_entrypoint.sh
ENTRYPOINT [ "/ros2_ws_entrypoint.sh" ]

RUN mkdir -p ${COLCON_WS}/log \
    && chown -R ${USER_ID}:${GROUP_ID} ${COLCON_WS}/

# install latest ros2-gazebo bridge
RUN mkdir -p ${COLCON_WS}/src/ && cd ${COLCON_WS}/src/ \
    && git clone https://github.com/ros-controls/gz_ros2_control.git -b ahcorde/rename/ign_to_gz \
    && git clone https://github.com/gazebosim/ros_gz.git -b foxy \
    && git clone https://github.com/gazebosim/gz-transport.git -b gz-transport12

COPY ./turtlebot3_nav2_gz_sim ${COLCON_WS}/src/turtlebot3_nav2_gz_sim

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
  cd ${COLCON_WS}/ && \
  rosdep install . && \
  colcon build

ARG TURTLEBOT3_MODEL=burger

# burger, waffle, waffle_pi
ENV TURTLEBOT3_MODEL ${TURTLEBOT3_MODEL}

# CMD gz sim
CMD ros2 launch turtlebot3_nav2_gz_sim all_in_one.launch.py