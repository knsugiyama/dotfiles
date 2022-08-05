#!/usr/bin/env bash

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/.zshenv ${HOME}/.dotfiles/.zshenv

# multipass 用に、SSHキーを作成
if [ ! -f ${HOME}/.ssh/multipass ]; then
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ${HOME}/.ssh/multipass
fi

# shell変更
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
