#!/bin/sh

echo -e "\nsource "$(brew --prefix asdf)"/asdf.fish" >> ~/.config/fish/env.fish

exec $SHELL -l
