#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/is_exists.sh

# goが必要
if ! is_exists "go"; then
    curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer && rm go_installer
    . ~/.bash_profile
fi

git clone https://github.com/x-motemen/ghq ghq
cd ghq
make install
cd ../
rm -rf ghq
