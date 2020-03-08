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
  git fetch origin
  git checkout origin/master
fi

if [ ${OS} == 'osx' ]; then
    brew update
elif [ ${OS} == 'linux' ]; then
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt autoremove
    brew update
fi
