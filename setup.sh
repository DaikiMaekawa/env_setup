#!/bin/sh
set -e

#base
sudo apt-get install aptitude
sudo aptitude install git screen vim
./ros_setup.sh
