#!/bin/sh
set -e

image_viewer="mirage"

sudo apt-get update
sudo apt-get install aptitude
sudo aptitude install git screen vim rubygems1.9.1 ruby1.9.1-dev ${image_viewer}
#./ros_setup.sh

#link dotfiles
ln -sf $PWD/dotfiles/.vimrc ~/.vimrc
ln -sf $PWD/dotfiles/.screenrc ~/.screenrc

#git setup
git config --global user.name "DaikiMaekawa"
git config --global user.email "method_aspect_card@yahoo.co.jp"

#Installing Jekyll with gem
sudo gem install rdoc
sudo gem install jekyll

bit=$(uname -m)

#Install Dropbox
wget -O - "https://www.dropbox.com/download?plat=lnx.${bit}" | tar xzf -
.dropbox-dist/dropboxd

