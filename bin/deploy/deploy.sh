#!/bin/sh

CURRENTPATH=$(dirname $0)

sh ${CURRENTPATH}/font.sh
sh ${CURRENTPATH}/fisher.sh
sh ${CURRENTPATH}/anyenv.sh
sh ${CURRENTPATH}/plantuml.sh
sh ${CURRENTPATH}/asciidoc.sh
