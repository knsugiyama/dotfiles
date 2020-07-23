#!/bin/bash

# python
pyenv virtualenv 3.8.4 neovim3
pyenv virtualenv 2.7.18 neovim2
pyenv shell neovim3
pip install pynvim
pyenv shell neovim2
pip install pynvim

# ruby
gem install neovim

# node
npm install -g neovim
