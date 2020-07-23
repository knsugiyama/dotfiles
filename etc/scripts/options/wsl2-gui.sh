#!/bin/bash

# xserver tools
sudo apt install -y xauth x11-apps
sudo apt install -y fcitx-mozc fonts-noto-cjk fonts-noto-color-emoji dbus-x11

sudo sh -c "dbus-uuidgen > /var/lib/dbus/machine-id"
sudo im-config -n fcitx

## Mozcの設定を開くコマンド
## fcitx-configtool # 入力メソッド設定
## /usr/lib/mozc/mozc_tool --mode=config_dialog # Mozc自体の設定

{
    echo 'export umask 022'
    echo 'export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '\''{print $2}'\''):0'
    echo 'export TZ="Asia/Tokyo"'
    echo 'export LANG="ja_JP.UTF-8"'
    echo 'export LC_ALL="ja_JP.UTF-8"'
    echo 'export GTK_IM_MODULE=fcitx'
    echo 'export QT_IM_MODULE=fcitx'
    echo 'export XMODIFIERS="@im=fcitx"'
    echo 'export DefaultIMModule=fcitx'
    echo 'fcitx-autostart'
} >>~/.bashrc
