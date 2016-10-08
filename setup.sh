#!/bin/sh
set -e

#base
sudo apt-get install aptitude
sudo aptitude install git screen vim
#./ros_setup.sh

#link dotfiles
ln -sf $PWD/dotfiles/.vimrc ~/.vimrc
ln -sf $PWD/dotfiles/.screenrc ~/.screenrc
