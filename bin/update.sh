#!/bin/bash

. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=`os_detect`

if [ ! -d ".git" ]; then
  git init
  git remote add origin https://github.com/knsugiyama/dotfiles.git
  git fetch origin
  git checkout --force origin/master
else
  git checkout master
  git pull
fi

if [ ${OS} == 'osx' ]; then
    brew update
    brew upgrade
    brew cask upgrade
elif [ ${OS} == 'linux' ]; then
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt autoremove
    brew update
fi
