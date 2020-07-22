#!/bin/bash

set -eu

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo $(log_echo "Ubuntu package install.")

SCRIPTPATH=${DOTPATH}/etc/init/linux

echo y | sudo apt update
echo y | sudo apt upgrade

## basic pakages install
cat ${SCRIPTPATH}/files/packages | while read package_name; do
    if [ line != '' ]; then
        echo $(log_info "package name: $package_name")
        sudo apt install -y ${package_name}
    fi
done

## japanease lang setting
sudo update-locale LANG=ja_JP.UTF-8
sudo locale-gen ja_JP.UTF-8
