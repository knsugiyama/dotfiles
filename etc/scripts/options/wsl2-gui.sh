#!/bin/bash

# xserver tools
sudo apt install -y xauth x11-apps

{
    echo 'umask 022'
    echo 'set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '\''{print $2}'\''):0'
    echo 'set -x TZ "Asia/Tokyo"'
    echo 'set -x LANG "ja_JP.UTF-8"'
    echo 'set -x LC_ALL "ja_JP.UTF-8"'
} >>~/.config/fish/env.fish

sudo ln -sfnv ${DOTPATH}/wsl.conf /etc/wsl.conf
