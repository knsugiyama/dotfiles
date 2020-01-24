#!/bin/bash

set -ue

DOTFILESPATH=~/.dotfiles
CURRENTPATH=$DOTFILESPATH/.bin

sudo apt -y update
sudo apt -y upgrade

# 基本の設定
## 最低限必要なものをinstall
sudo apt -y install build-essential unzip

## japanease lang setting
sudo apt -y install language-pack-ja-base language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
sudo apt -y install manpages-ja manpages-ja-dev
sudo locale-gen ja_JP.UTF-8

# linuxbrewの導入
bash $CURRENTPATH/install/linuxbrew.sh

# fish plugins
bash $CURRENTPATH/setup/fish-plugins.sh
