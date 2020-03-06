#!/bin/bash

set -ue

brew install graphviz
brew install plantuml

echo 'set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths' >> ~/.config/fish/config.fish