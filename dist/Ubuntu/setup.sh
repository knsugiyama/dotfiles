#!/usr/bin/env bash

set -eu

echo y | sudo apt update
echo y | sudo apt upgrade

sudo apt install -y build-essential procps curl file git apt-transport-https ca-certificates software-properties-common

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/.zshenv ${HOME}/.zshenv
# Brewfile ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Brewfile ${HOME}/Brewfile

# docker
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# secho y | udo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# 
# secho y | udo apt update
# secho y | udo apt install docker-ce docker-ce-cli containerd.io

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ${HOME}/.profile
source ~/.profile
