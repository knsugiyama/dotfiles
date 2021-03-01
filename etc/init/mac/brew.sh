#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo $(log_echo "install homebrew")
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/user/.zprofile

echo $(log_echo "update homebrew")
brew update --verbose
brew bundle
