#!/bin/bash

set -ue

sudo apt -y update
sudo apt -y upgrade

# 基本の設定
## japanease lang setting
sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
timedatectl set-timezone Asia/Tokyo
sudo apt -y install manpages-ja manpages-ja-dev
sudo locale-gen ja_JP.UTF-8

# フォントの導入
sudo bash ./install/font.sh

# linuxbrewの導入
sudo bash ./install/linuxbrew.sh
