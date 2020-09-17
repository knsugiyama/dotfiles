#!/bin/bash

## fisher
if [ ! -e ~/.config/fish/functions/fisher.fish ]; then
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fi

fish -c "fisher"
