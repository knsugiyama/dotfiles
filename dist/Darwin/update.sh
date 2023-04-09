#!/usr/bin/env bash

if [ ! -d ".git" ]; then
  git init
  git remote add origin https://github.com/knsugiyama/dotfiles.git
  git fetch origin
  git checkout -b master
else
  git checkout master
  git pull
fi

brew upgrade
brew upgrade --cask
