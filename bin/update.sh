#!/bin/bash

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=$(os_detect)

echo $(log_echo "start update.")
echo $(log_info "###### update git. ######")
if [ ! -d ".git" ]; then
  git init
  git remote add origin https://github.com/knsugiyama/dotfiles.git
  git fetch origin
  git checkout --force origin/master
else
  git checkout master
  git pull
fi

echo $(log_info "###### packages update. ######")
if [ ${OS} == 'osx' ]; then
    brew update
    brew upgrade
    brew cask upgrade
    brew cleanup
elif [ ${OS} == 'linux' ]; then
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt autoremove
    brew update
fi

echo $(log_info "###### anyenv update. ######")
anyenv update
