#!/bin/bash
if [ ! -d ./work/px4 ] ; then
    cd ./work
    git clone https://github.com/ksommerkohrt/PX4-Autopilot-Maze.git --branch maze --single-branch --recursive px4
    cd ..
fi

if [ ! -d ./work/ros2_ws/src ] ; then
    mkdir -p ./work/ros2_ws/src
    cd work/ros2_ws/src
    git clone git@github.com:PX4/px4_msgs.git
    git clone git@github.com:w-sribunma/px4-offboard.git
    git clone -b humble git@github.com:gazebosim/ros_gz.git
fi
