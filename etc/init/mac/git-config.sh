#!/bin/bash

## git credential
git config --global credential.helper osxkeychain
echo '  helper = osxkeychain' >>~/.dotfiles/.gitconfig.credential
