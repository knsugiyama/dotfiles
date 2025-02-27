#!/usr/bin/env bash

if [ ! -d ".git" ]; then
  git init
  git remote add origin https://github.com/knsugiyama/dotfiles.git
  git fetch origin
  git checkout -b main
else
  git pull
fi

if sheldon --help &>/dev/null; then
  sheldon lock --update
fi

sudo apt -y update
sudo apt -y upgrade
sudo apt autoremove
