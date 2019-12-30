#!/bin/bash

DOTFILESPATH=~/.dotfiles
CICAVER=v5.0.1

# to build ren and tree command and make vimproc
sudo apt -y update
sudo apt -y upgrade

# 基本の設定
## japanease lang setting
sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
timedatectl set-timezone Asia/Tokyo
sudo apt -y install manpages-ja manpages-ja-dev
sudo locale-gen ja_JP.UTF-8

## wsl.conf
ln -snfv "$DOTFILESPATH/.wsl/wsl.conf" "/etc/wsl.conf"

# linuxbrew の導入
sudo apt install build-essential -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# font(cica) の導入
wget -P /tmp/Cica https://github.com/miiton/Cica/releases/download/"$CICAVER"/Cica_"$CICAVER"_with_emoji.zip
unzip -d /tmp/Cica /tmp/Cica/Cica_"$CICAVER"_with_emoji.zip
rm -f /tmp/Cica/Cica_"$CICAVER"_with_emoji.zip
sudo cp -r /tmp/Cica /usr/share/fonts/truetype/

# ライブラリの導入
brew install gcc
brew install fish
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
brew install asciidoc
brew install graphviz
brew install plantuml
brew install git-credential-manager
brew install ruby

# fish shell の導入と設定
## fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -C 'fisher add oh-my-fish/theme-bobthefish;'
fish -C 'fisher add jethrokuan/z;'
fish -C 'fisher add jethrokuan/fzf;'
fish -C 'fisher add decors/fish-ghq;'
