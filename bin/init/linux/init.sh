#!/bin/sh

install() {
  cat ${SCRIPTPATH}/packages | while read package_name;
  do
    if [ line != '' ]; then
      sudo apt install -y ${package_name}
    fi
  done
}

echo 'Ubuntu package install'

SCRIPTPATH=$(dirname $0)

sudo apt update
sudo apt install -y software-properties-common
install

sh ${SCRIPTPATH}/linuxbrew.sh
