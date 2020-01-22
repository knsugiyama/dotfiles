#!/bin/bash

set -ue

# linuxbrew の導入
sudo apt install build-essential -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# 最低限必要なライブラリの導入
brew install gcc
brew install fzf
brew install tmux
brew install peco
brew install make
brew install jq
brew install shellcheck
brew install tree
brew install ren
brew install direnv
brew install wget
brew install tig
brew install hub
brew install rg
brew install ghq
