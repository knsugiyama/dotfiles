#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/is_exists.sh

if ! is_exists "rbenv"; then
    anyenv install rbenv
fi

rbenv install 2.7.1
rbenv global 2.7.1
