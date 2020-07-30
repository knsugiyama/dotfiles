#!/bin/bash

# python
pyenv virtualenv 3.8.5 neovim3
pyenv virtualenv 2.7.18 neovim2
pyenv shell neovim3
pip install pynvim
pyenv shell neovim2
pip install pynvim

# ruby
gem install neovim

# node
npm install -g neovim

echo "export XDG_CONFIG_HOME=$HOME/.config" >> ~/.bash_profile
echo "export XDG_CACHE_HOME=$HOME/.cache" >> ~/.bash_profile
echo "set -x XDG_CONFIG_HOME $HOME/.config" >> ~/.config/fish/env.fish
echo "set -x XDG_CACHE_HOME $HOME/.cache" >> ~/.config/fish/env.fish
