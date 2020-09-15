#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/logging.sh

SCRIPTPATH=${DOTPATH}/etc/init/linux

files=$(echo ${SCRIPTPATH}/git-clones/*.sh)
for f in $files; do
    echo $(log_info "git clone package name: $f")
    bash "$f"
done
