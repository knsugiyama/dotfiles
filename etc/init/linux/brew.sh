#!/bin/sh

set -eu

. ${DOTPATH}/etc/scripts/lib/logging.sh

echo $(log_echo "brew package install.")

SCRIPTPATH=${DOTPATH}/etc/init/linux

## basic pakages install
cat ${SCRIPTPATH}/files/brew-packages | while read package_name; do
    if [ line != '' ]; then
        echo $(log_info "package name: $package_name")
        brew install ${package_name}
    fi
done
