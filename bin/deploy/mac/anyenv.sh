#!/bin/bash

set -ue

# anyenvの初期化
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc

# fish shell が導入されていればそちらにも
if (type "fish" > /dev/null 2>&1); then
    echo 'set -Ux fish_user_paths $HOME/.anyenv/bin $fish_user_paths' >> ~/.config/fish/config.fish
fi

echo 'eval "$(anyenv init -)"' >> ~/.bashrc

## plugin
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# init
fish -c "echo y | anyenv install --init"

# install jenv
fish -c "anyenv install -s jenv"
# /usr/libexec/java_home -V でわかる
fish -c "jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
fish -c "jenv global 1.8.0.242"
fish -c "jenv enable-plugin export"

# install node
fish -c "anyenv install nodenv"
fish -c "nodenv install 12.6.0"
fish -c "nodenv global 12.6.0"

# install ruby
fish -c "anyenv install rbenv"
fish -c "rbenv install 2.7.0"
fish -c "rbenv global 2.7.0"
