#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh

OS=$(os_detect)

echo "export XDG_CONFIG_HOME=$HOME/.config" >> ~/.bash_profile
echo "export XDG_CACHE_HOME=$HOME/.cache" >> ~/.bash_profile
echo "set -x XDG_CONFIG_HOME $HOME/.config" >> ~/.config/fish/env.fish
echo "set -x XDG_CACHE_HOME $HOME/.cache" >> ~/.config/fish/env.fish

if [ ${OS} == 'osx' ]; then
    # brew install neovim --HEAD
    brew install neovim
elif [ ${OS} == 'linux' ]; then
    # sudo add-apt-repository ppa:neovim-ppa/unstable
    # sudo apt update
    sudo apt install -y neovim
fi

# python
pyenv global 3.8.5
pip install virtualenv
virtualenv -p python3 ~/nvim-python3

pyenv global 2.7.15
virtualenv -p python ~/nvim-python2
pyenv global system

source ~/nvim-python3/bin/activate
pip install pynvim
deactivate

source ~/nvim-python2/bin/activate
pip install pynvim
deactivate

# ruby
gem install neovim

# node
npm install -g neovim
