#!/usr/bin/env bash

set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/Makefile ${HOME}/.dotfiles/Makefile
# .zshenv ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/.zshenv ${HOME}/.zshenv
# Brewfile ファイル のシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Darwin/Brewfile ${HOME}/Brewfile
