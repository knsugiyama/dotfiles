#!/bin/bash
git clone https://github.com/anyenv/anyenv ~/.anyenv

# for bash
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >>~/.bash_profile
# for fish
echo 'set -x PATH $HOME/.anyenv/bin $PATH' >>~/.config/fish/env.fish

. ~/.bash_profile
