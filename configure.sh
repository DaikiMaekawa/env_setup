#!/bin/sh
set -e

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv --version
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install -l
rbenv install 2.1.3
rbenv global 2.1.3
rbenv rehash
ruby --version
gem install itamae
