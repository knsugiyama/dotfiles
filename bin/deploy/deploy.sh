#!/bin/sh

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

set -ue

echo $(log_echo "start deploy.")

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/brewfile.sh
    . ~/.bash_profile
    sh ${CURRENTPATH}/mac/default-shell.sh
    sh ${CURRENTPATH}/anyenv.sh
    . ~/.bash_profile
    sh ${CURRENTPATH}/mac/jenv.sh
elif [ ${OS} == 'linux' ]; then
    sh ${CURRENTPATH}/linux/linuxbrew.sh
    . ~/.bash_profile
    sh ${CURRENTPATH}/linux/font.sh
    sh ${CURRENTPATH}/anyenv.sh
    . ~/.bash_profile
    sh ${CURRENTPATH}/linux/jenv.sh
fi

sh ${CURRENTPATH}/fisher.sh
sh ${CURRENTPATH}/plantuml.sh
sh ${CURRENTPATH}/asciidoc.sh
