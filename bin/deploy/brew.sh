#!/bin/bash

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=$(os_detect)

echo 'brew package install'

SCRIPTPATH=$(dirname $0)

if [ ${OS} == 'osx' ]; then
  echo ".Brewfile"
  brew bundle --global --verbose

elif [ ${OS} == 'linux' ]; then
  cat ${SCRIPTPATH}/linux/brew-packages | while read brew_package_name;
  do
    if [ line != '' ]; then
      echo $(log_info "brew package name: $brew_package_name")
      sh -c "brew install ${brew_package_name}"
    fi
  done
fi
