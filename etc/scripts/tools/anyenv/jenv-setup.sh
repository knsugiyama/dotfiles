#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh
. ${DOTPATH}/etc/scripts/lib/is_exists.sh

OS=$(os_detect)

if ! is_exists "java"; then
    echo "java is not installed."
    exit 1
fi

if [ ${OS} == 'osx' ]; then
    jenv add `/usr/libexec/java_home -v "1.8"`
elif [ ${OS} == 'linux' ]; then
    jenv add /usr/lib/jvm/java-8-openjdk-amd64
fi

jenv global 1.8
jenv enable-plugin export
