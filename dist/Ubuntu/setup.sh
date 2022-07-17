#!/usr/bin/env bash

set -eu

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/.zshenv ${HOME}/.dotfiles/.zshenv

sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
