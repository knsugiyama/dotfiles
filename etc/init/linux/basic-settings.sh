#!/bin/bash

set -eu

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo $(log_echo "Ubuntu package install.")

SCRIPTPATH=${DOTPATH}/etc/init/linux

echo y | sudo apt update
echo y | sudo apt upgrade

# git latest
sudo add-apt-repository -y ppa:git-core/ppa
echo y | sudo apt update

## pakages install
cat ${SCRIPTPATH}/files/packages | while read package_name; do
    if [ line != '' ]; then
        echo $(log_info "package name: $package_name")
        sudo apt install -y ${package_name}
    fi
done

## japanease lang setting
sudo update-locale LANG=ja_JP.UTF-8
sudo locale-gen ja_JP.UTF-8

# for bash
echo 'export EDITOR=vim' >>~/.bash_profile
# for fish
echo 'set -U EDITOR vim' >>~/.config/fish/env.fish
