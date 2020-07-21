#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/logging.sh

set -ue

SCRIPTPATH=${DOTPATH}/etc/init/linux

cat ${SCRIPTPATH}/files/brew-packages | while read brew_package_name; do
    if [ line != '' ]; then
        echo $(log_info "brew package name: $brew_package_name")
        sh -c "brew install ${brew_package_name}"
    fi
done
