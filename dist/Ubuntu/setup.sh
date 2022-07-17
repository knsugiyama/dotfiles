#!/usr/bin/env bash

set -eu

# make ファイルのシンボリックリンクをrootに移動
ln -sfnv ${HOME}/.dotfiles/dist/Ubuntu/Makefile ${HOME}/.dotfiles/Makefile
