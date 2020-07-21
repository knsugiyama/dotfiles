#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/logging.sh

set -ue

echo 'brew package install'

echo ".Brewfile"
brew bundle --global --verbose
