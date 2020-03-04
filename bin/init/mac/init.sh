#!/bin/sh

echo "install homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "update homebrew"
brew update --verbose

echo ".Brewfile"
brew bundle --global --verbose

## git credential
git config --global credential.helper osxkeychain
