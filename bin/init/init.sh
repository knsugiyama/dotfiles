#!/bin/sh

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=$(os_detect)
CURRENTPATH=$(dirname $0)

echo $(log_echo "start init.")

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/init.sh
elif [ ${OS} == 'linux' ]; then
    sh ${CURRENTPATH}/linux/init.sh
fi
