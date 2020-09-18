#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh
. ${DOTPATH}/etc/scripts/lib/is_exists.sh

OS=$(os_detect)

goenv install 1.15.2
goenv global 1.15.2

if [ ${OS} == 'linux' ]; then
    if ! is_exists "ghq"; then
    	go get github.com/x-motemen/ghq
    fi
fi


