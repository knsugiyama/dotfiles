#!/bin/bash

# HackGen
sudo mkdir -p /usr/share/fonts/HackGen
HACK_GEN_RELEASES_URL="https://api.github.com/repos/yuru7/HackGen/releases/latest"
sudo curl -sfL "$HACK_GEN_RELEASES_URL" | grep "browser_download_url" | cut -d : -f 2,3 | tr -d \" | xargs -I{} curl -fL -o /tmp/HackGen.zip "{}"
(cd /tmp && sudo unzip -o HackGen.zip -d /usr/share/fonts/HackGen)

sudo fc-cache -vf

# echo 'set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"' >>~/.config/fish/env.fish
# echo 'powerline-setup' >>~/.config/fish/env.fish
