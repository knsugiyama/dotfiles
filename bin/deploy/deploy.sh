#!/bin/sh


. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    sh ${CURRENTPATH}/mac/brewfile.sh
fi

sh ${CURRENTPATH}/font.sh
sh ${CURRENTPATH}/fisher.sh
sh ${CURRENTPATH}/anyenv.sh
sh ${CURRENTPATH}/plantuml.sh
sh ${CURRENTPATH}/asciidoc.sh
