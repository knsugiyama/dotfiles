#!/bin/sh

## fisher
if [ ! -e ~/.config/fish/functions/fisher.fish ]; then
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fi

fish -c "fisher"

echo 'set -U EDITOR vim' >>~/.config/fish/env.fish
