#!/bin/sh


. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/brewfile.sh
    sh ${CURRENTPATH}/mac/default-shell.sh
    sh ${CURRENTPATH}/anyenv.sh
    sh ${CURRENTPATH}/mac/jenv.sh
elif [ ${OS} == 'linux' ]; then
    sh ${CURRENTPATH}/linux/linuxbrew.sh
    sh ${CURRENTPATH}/linux/font.sh
    sh ${CURRENTPATH}/anyenv.sh
    sh ${CURRENTPATH}/linux/jenv.sh
fi

sh ${CURRENTPATH}/fisher.sh
sh ${CURRENTPATH}/plantuml.sh
sh ${CURRENTPATH}/asciidoc.sh
