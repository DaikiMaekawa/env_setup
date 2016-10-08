#!/bin/sh
set -e

#base
sudo apt-get install aptitude
sudo aptitude install git screen vim rubygems
./ros_setup.sh

#link dotfiles
ln -sf $PWD/dotfiles/.vimrc ~/.vimrc
ln -sf $PWD/dotfiles/.screenrc ~/.screenrc

#git setup
git config --global user.name "DaikiMaekawa"
git config --global user.email "method_aspect_card@yahoo.co.jp"

#Installing Jekyll with gem
sudo gem install rdoc
sudo gem install jekyll
