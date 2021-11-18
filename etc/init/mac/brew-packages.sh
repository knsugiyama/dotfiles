#!/bin/sh

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo 'brew package install'

echo ".Brewfile"
brew bundle --global --verbose
