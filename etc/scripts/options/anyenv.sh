#!/bin/bash

anyenv init
echo y | anyenv install --init

# bash
echo 'eval "$(anyenv init -)"' >>~/.bash_profile
# fish
echo 'status --is-interactive; and source (anyenv init -|psub)' >>~/.config/fish/env.fish

anyenv install rbenv
anyenv install pyenv
anyenv install nodenv
anyenv install goenv
anyenv install jenv

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git

exec $SHELL -l
