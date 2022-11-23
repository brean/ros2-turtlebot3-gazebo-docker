# ROS 2 foxy Gazebo Simulation in docker
**Note that you don't need to run the build script, the image is pushed to dockerhub, just run `docker-compose pull`!**

Run gazebo classic simulation with turtlebot in a local docker container so you can run it if you don't have Ubuntu 20.04 installed.

Take a look at  [ros-turtlebot3-navigation-docker](../../../ros-turtlebot3-navigation-docker) to interact with the robot.

Don't forget to configure ROS_DOMAIN_ID (default 30) and TURTLEBOT3_MODEL (default burger)

to run the docker-container for the simulation just run the `./run.bash`-script

Note that the start of gazebo can take a few seconds. Make sure you have your graphic-card specifics installed (e.g. docker-nvidia2 for NVIDIA graphics cards)!

after gazebo started that you can connect to the "turtlebot"-network inside docker and execute any ros2 command.

Don't forget to run `docker-compose down` when you are done.
