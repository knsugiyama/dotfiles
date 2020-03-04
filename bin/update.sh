#!/bin/bash

. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=`os_detect`

git pull origin master
if [ ${OS} == 'osx' ]; then
    brew update
elif [ ${OS} == 'linux' ]; then
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt autoremove
    brew update
fi
