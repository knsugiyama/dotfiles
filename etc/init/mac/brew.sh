#!/bin/bash

. ${DOTPATH}/etc/scripts/logging.sh

set -ue

echo $(log_echo "install homebrew")
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo $(log_echo "update homebrew")
brew update --verbose
