#!/bin/sh

#Install hydro to Ubuntu 12.04
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-hydro-desktop-full
apt-cache search ros-hydro
sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
source ~/.bashrc
source /opt/ros/hydro/setup.bash
sudo apt-get install python-rosinstall

sudo aptitude install ros-hydro-moveit-full python-wstool

#Install indigo to Ubuntu 14.04

#TODO
