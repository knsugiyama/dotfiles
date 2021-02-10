#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/is_exists.sh

if ! is_exists "pyenv"; then
    anyenv install pyenv
fi

