#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh
. ${DOTPATH}/etc/scripts/lib/is_exists.sh

if ! is_exists "goenv"; then
    anyenv install goenv
fi

OS=$(os_detect)

# goenv install 1.15.2
# goenv global 1.15.2

