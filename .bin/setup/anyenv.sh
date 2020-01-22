#!/bin/bash

set -ue

brew install anyenv

# anyenvの初期化
{
    echo export PATH="$HOME/.anyenv/bin:$PATH"
    echo eval "$(anyenv init -)"
} >> ~/.bashrc

# fish shell が導入されていればそちらにも
if (type "fish" > /dev/null 2>&1); then
    {
        echo set -gx PATH $HOME/.anyenv/bin $PATH
        echo source (anyenv init - fish|psub)
    } >> ~/.config/fish/config.fish
fi

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
