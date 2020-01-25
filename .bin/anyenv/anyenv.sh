#!/bin/bash

set -ue

brew install anyenv

# anyenvの初期化
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile

# fish shell が導入されていればそちらにも
if (type "fish" > /dev/null 2>&1); then
    echo 'set -Ux fish_user_paths $HOME/.anyenv/bin $fish_user_paths' >> ~/.config/fish/config.fish
fi

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

anyenv install --init
