#!/bin/sh

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo $(log_echo "install homebrew")
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo $(log_echo "update homebrew")
ln -s ${DOTPATH}/Brewfile ./Brewfile

brew bundle --verbose --file=${DOTPATH}/etc/scripts/init/mac/Brewfile
brew update --verbose
