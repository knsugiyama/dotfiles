#!/bin/sh

set -eu

. ${DOTPATH}/etc/scripts/lib/logging.sh
. ${DOTPATH}/etc/scripts/lib/os_detect.sh

echo $(log_echo "brew package install.")

FILE_PATH=${DOTPATH}/etc/init/files
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
  brew bundle --verbose --file=${FILE_PATH}/Brewfile
  brew update --verbose

elif [ ${OS} == 'linux' ]; then
  cat ${FILE_PATH}/linuxbrew | while read package_name; do
      if [ line != '' ]; then
          echo $(log_info "package name: $package_name")
          brew install ${package_name}
      fi
  done
fi
