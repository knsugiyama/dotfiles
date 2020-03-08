#!/bin/sh
echo ".Brewfile"
brew bundle --global --verbose

echo "config git credential"
git config --global credential.helper osxkeychain
