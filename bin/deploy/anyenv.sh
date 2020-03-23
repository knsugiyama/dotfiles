#!/bin/bash

set -ue

# anyenvの初期化
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

# fish shell にも
echo 'set -x PATH $HOME/.anyenv/bin $PATH' >> ~/.config/fish/config.fish
echo 'eval (anyenv init - | source)' >> ~/.config/fish/config.fish

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# init
fish -c "echo y | anyenv install --init"

# install node
fish -c "anyenv install nodenv"
fish -c "touch (nodenv root)/default-packages"
fish -c "mkdir -p (nodenv root)"/plugins""
git clone https://github.com/pine/nodenv-yarn-install.git (nodenv root)"/plugins/nodenv-yarn-install"
fish -c "nodenv install 12.6.0"
fish -c "nodenv global 12.6.0"

# install ruby
fish -c "anyenv install rbenv"
fish -c "rbenv install 2.7.0"
fish -c "rbenv global 2.7.0"
