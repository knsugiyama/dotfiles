#!/bin/bash

set -ue

# anyenvの初期化
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile

# fish shell が導入されていればそちらにも
if (type "fish" > /dev/null 2>&1); then
    echo 'set -Ux fish_user_paths $HOME/.anyenv/bin $fish_user_paths' >> ~/.config/fish/config.fish
    echo 'eval (anyenv init - | source)' >> ~/.config/fish/config.fish
fi

echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# init
fish -c "echo y | anyenv install --init"

# install node
fish -c "anyenv install nodenv"
touch $(nodenv root)/default-packages
mkdir -p (nodenv root)"/plugins"
git clone https://github.com/pine/nodenv-yarn-install.git (nodenv root)"/plugins/nodenv-yarn-install"
fish -c "nodenv install 12.6.0"
fish -c "nodenv global 12.6.0"

# install ruby
fish -c "anyenv install rbenv"
fish -c "rbenv install 2.7.0"
fish -c "rbenv global 2.7.0"
