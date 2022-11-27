cmake_minimum_required(VERSION 3.5)
project(turtlebot3_nav2_gz_sim)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

find_package(ament_cmake REQUIRED)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)
install(TARGETS
  DESTINATION lib/${PROJECT_NAME})

ament_package()
