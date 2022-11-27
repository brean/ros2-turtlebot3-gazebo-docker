import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration


def generate_launch_description():
    use_sim_time = LaunchConfiguration('use_sim_time', default='true')

    nav2_file_dir = get_package_share_directory('turtlebot3_navigation2')

    nav2_launch_file_dir = os.path.join(
        get_package_share_directory('nav2_bringup'), 'launch')

    turtlebot3_gz_launch_file_dir = os.path.join(
        get_package_share_directory('turtlebot3_gz'), 'launch')

    return LaunchDescription([
        DeclareLaunchArgument(
            'use_sim_time',
            default_value='true',
            description='Use simulation (Gazebo) clock if true'),

        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(
                [nav2_launch_file_dir, '/bringup_launch.py']),
            launch_arguments={
                'use_sim_time': use_sim_time,
                'map': os.path.join(nav2_file_dir, 'map', 'map.yaml')
            }.items()),

        # turtlebot3_gz gz_sim.launch.py
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(
                [turtlebot3_gz_launch_file_dir, '/gz_sim.launch.py']))
    ])
