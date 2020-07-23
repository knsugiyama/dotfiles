#!/bin/bash

anyenv init
echo y | anyenv install --init

# bash
echo 'eval (anyenv init - | source)' >> ~/.config/fish/env.fish
# fish
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

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
