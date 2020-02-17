#!/bin/bash

set -ue

DOTFILESPATH=~/.dotfiles
CURRENTPATH=$DOTFILESPATH/.bin

sudo apt -y update
sudo apt -y upgrade

# 基本の設定
sudo apt -y install build-essential unzip zlib1g-dev libsecret-1-0 libsecret-1-dev

## japanease lang setting
sudo apt -y install language-pack-ja-base language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
sudo apt -y install manpages-ja manpages-ja-dev
sudo locale-gen ja_JP.UTF-8

## git credential
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret/

# linuxbrewの導入
bash $CURRENTPATH/install/linuxbrew.sh
