#!/usr/bin/env bash

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/.zshenv ${HOME}/.dotfiles/.zshenv

# shell変更
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
