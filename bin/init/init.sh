#!/bin/sh

. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/init.sh
elif [ ${OS} == 'linux' ]; then
    sudo -S sh ${CURRENTPATH}/linux/init.sh
fi
