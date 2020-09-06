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
    echo 'umask 022'
    echo 'set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '\''{print $2}'\''):0'
    echo 'set -x TZ "Asia/Tokyo"'
    echo 'set -x LANG "ja_JP.UTF-8"'
    echo 'set -x LC_ALL "ja_JP.UTF-8"'
    echo 'set -x GTK_IM_MODULE fcitx'
    echo 'set -x QT_IM_MODULE fcitx'
    echo 'set -x XMODIFIERS "@im=fcitx"'
    echo 'set -x DefaultIMModule fcitx'
    echo 'fcitx-autostart'
} >>~/.config/fish/env.fish
