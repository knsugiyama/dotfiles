#!/bin/bash

mkdir -p ~/.config/fish

# link dotfiles
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/fish/config.fish  ~/.config/fish/config.fish
ln -sf ~/dotfiles/.bashrc ~/.bashrc
