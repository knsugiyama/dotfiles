#!/bin/bash

set -ue

## fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -C 'fisher add oh-my-fish/theme-bobthefish;'
fish -C 'fisher add jethrokuan/z;'
fish -C 'fisher add jethrokuan/fzf;'
fish -C 'fisher add decors/fish-ghq;'
fish -C 'fisher add edc/bass'
