FROM brean/turtlebot3_gz_sim:garden

ARG USER=ros

# local colcon workspace folder for ros-user
ARG COLCON_WS=/home/${USER}/ws

# cartographer and navigation2 are already installed in the base-image.
# this might change in the future and we maybe want to install them here?!

COPY ./turtlebot3_nav2_gz_sim ${COLCON_WS}/src/
# ros2 launch nav2_bringup bringup_launch.py use_sim_time:=False autostart:=False map:=/path/to/your-map.yaml

RUN . ${COLCON_WS}/install/setup.sh && \
  cd ${COLCON_WS}/ && \
  colcon build

CMD ros2 launch turtlebot3_nav2_gz_sim all_in_one.launch.py