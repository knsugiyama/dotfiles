#!/bin/bash

set -ue

# anyenvの初期化
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

# fish shell にも
echo 'set -x PATH $HOME/.anyenv/bin $PATH' >> ~/.config/fish/env.fish
echo 'eval (anyenv init - | source)' >> ~/.config/fish/env.fish

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# init
fish -c "echo y | anyenv install --init"

# install jenv
fish -c "anyenv install jenv"
# install node
fish -c "anyenv install nodenv"
fish -c "touch (nodenv root)/default-packages"
fish -c "mkdir -p (nodenv root)"/plugins""
git clone https://github.com/pine/nodenv-yarn-install.git (nodenv root)"/plugins/nodenv-yarn-install"
# install ruby
fish -c "anyenv install rbenv"
# install go
fish -c "anyenv install goenv"
