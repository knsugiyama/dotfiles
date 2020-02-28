#!/bin/bash

set -ue

OS=`os_detect`

if [ ${OS} == 'osx' ]; then
    brew update
elif [ ${OS} == 'linux' ]; then
    git pull origin master
    sudo apt -y update
    sudo apt -y upgrade
    sudo apt autoremove
    brew update
fi
