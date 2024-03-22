#!/usr/bin/env bash

set -eu

echo y | sudo apt update
echo y | sudo apt upgrade
sudo apt install -y build-essential procps curl file git

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/.zshenv ${HOME}/.zshenv
# Brewfile ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Brewfile ${HOME}/Brewfile

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ${HOME}/.profile
source ~/.profile
