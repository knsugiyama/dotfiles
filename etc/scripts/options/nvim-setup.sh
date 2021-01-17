#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh

OS=$(os_detect)

echo "export XDG_CONFIG_HOME=$HOME/.config" >> ~/.bash_profile
echo "export XDG_CACHE_HOME=$HOME/.cache" >> ~/.bash_profile
echo "set -x XDG_CONFIG_HOME $HOME/.config" >> ~/.config/fish/env.fish
echo "set -x XDG_CACHE_HOME $HOME/.cache" >> ~/.config/fish/env.fish

if [ ${OS} == 'osx' ]; then
    brew install neovim
elif [ ${OS} == 'linux' ]; then
    sudo apt install -y neovim
fi
