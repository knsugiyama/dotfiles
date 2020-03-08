#!/bin/bash

set -ue

install() {
  cat ${SCRIPTPATH}/brew-packages | while read brew_package_name;
  do
    if [ line != '' ]; then
      brew install ${brew_package_name}
    fi
  done
}

echo 'brew package install'

SCRIPTPATH=$(dirname $0)

# linuxbrew の導入
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

install
