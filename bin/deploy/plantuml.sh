#!/bin/bash

set -ue

brew install graphviz
brew install plantuml

echo 'set -x PATH "/usr/local/opt/openjdk/bin" $PATH' >> ~/.config/fish/config.fish
