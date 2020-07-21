#!/bin/bash

. ${DOTPATH}/etc/scripts/logging.sh

set -ue

echo 'brew package install'

echo ".Brewfile"
brew bundle --global --verbose
