#!/bin/bash

# # anyenvの初期化
# echo 'set -x PATH $HOME/.anyenv/bin $PATH' >> ~/.config/fish/env.fish

# ## plugin
# mkdir -p $(anyenv root)/plugins
# git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
# git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git

# init
# echo y | anyenv install --init

# install jenv
anyenv install jenv
# install node
anyenv install nodenv
. ~/.bash_profile
touch $(nodenv root)/default-packages
mkdir -p $(nodenv root)/plugins
git clone https://github.com/pine/nodenv-yarn-install.git $(nodenv root)/plugins/nodenv-yarn-install
# install ruby
anyenv install rbenv
# install go
anyenv install goenv
