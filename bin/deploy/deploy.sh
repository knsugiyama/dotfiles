#!/bin/sh


. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/brewfile.sh
    sh ${CURRENTPATH}/mac/default-shell.sh
    sh ${CURRENTPATH}/mac/anyenv.sh
elif [ ${OS} == 'linux' ]; then
    sh ${CURRENTPATH}/linux/linuxbrew.sh
    sh ${CURRENTPATH}/linux/font.sh
    sh ${CURRENTPATH}/linux/anyenv.sh
fi

sh ${CURRENTPATH}/fisher.sh
sh ${CURRENTPATH}/plantuml.sh
sh ${CURRENTPATH}/asciidoc.sh
