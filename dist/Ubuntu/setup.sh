#!/usr/bin/env bash

set -eu

echo y | sudo apt update
echo y | sudo apt upgrade

sudo apt install -y build-essential unzip ripgrep curl libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev fzf libfuse-dev pkg-config libssl-dev

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/.zshenv ${HOME}/.zshenv

# Docker のリポジトリを追加
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Docker および Docker-Compose のインストール
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# for WSL
if [[ "$(uname -r)" == *microsoft* ]]; then
  echo -e "[boot]\nsystemd=true" | sudo tee /etc/wsl.conf
  sudo systemctl enable --now docker
fi

# cargo を使いたいので、rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source ~/.profile
