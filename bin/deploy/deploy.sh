#!/bin/sh

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

set -ue

echo $(log_echo "start deploy.")

if [ ${OS} == 'osx' ]; then
    ${CURRENTPATH}/mac/brewfile.sh
    ${CURRENTPATH}/mac/default-shell.sh
    ${CURRENTPATH}/anyenv.sh
    ${CURRENTPATH}/mac/jenv.sh
elif [ ${OS} == 'linux' ]; then
    ${CURRENTPATH}/linux/linuxbrew.sh
    ${CURRENTPATH}/linux/font.sh
    ${CURRENTPATH}/anyenv.sh
    ${CURRENTPATH}/linux/jenv.sh
fi

${CURRENTPATH}/fisher.sh
${CURRENTPATH}/plantuml.sh
${CURRENTPATH}/asciidoc.sh
