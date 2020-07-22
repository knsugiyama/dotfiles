#!/bin/bash
git clone https://github.com/anyenv/anyenv ~/.anyenv

# for bash
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >>~/.bash_profile
# for fish
echo 'set -x PATH $HOME/.anyenv/bin $PATH' >>~/.config/fish/env.fish

~/.anyenv/bin/anyenv init

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git

# init
echo y | anyenv install --init
