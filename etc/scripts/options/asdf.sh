#!/bin/bash

echo -e "\nsource "(brew --prefix asdf)"/asdf.fish" >> ~/.config/fish/config.fish

exec $SHELL -l
