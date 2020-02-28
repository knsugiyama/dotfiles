#!/bin/sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    echo 'not implemented'
    exit 1
elif [ ${OS} == 'linux' ]; then
    sudo -S sh ${CURRENTPATH}/linux/init.sh
fi
