#!/bin/bash

set -ue

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 1 ]; then
        echo "Usage: <msg>"
        return 1
    fi

    local text="$1"
    printf "[$(date +%H:%M:%S)] $text"
}

is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

DOTFILESPATH=~/.dotfiles
GITHUB_URL=https://github.com/knsugiyama/dotfiles.git

sudo apt update
sudo apt upgrade

# git が使えるかチェック
if !(type "git" > /dev/null 2>&1); then
    # 使えない場合は git をインストールする
    sudo apt install git
fi

git clone --recursive "$GITHUB_URL" "$DOTFILESPATH"

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    logging "not found: $DOTFILESPATH"
    exit 1
fi

# 以降のインストールおよびセットアップ作業にはmakeコマンドが必要なので、install
sudo apt install -y make
