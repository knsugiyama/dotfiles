#!/bin/bash

set -ue

## fisher
if [ ! -e ~/.config/fish/functions/fisher.fish ]; then
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fi

fish -C 'fisher add oh-my-fish/theme-bobthefish;'
fish -C 'fisher add jethrokuan/z;'
fish -C 'fisher add jethrokuan/fzf;'
fish -C 'fisher add decors/fish-ghq;'
fish -C 'fisher add edc/bass'
