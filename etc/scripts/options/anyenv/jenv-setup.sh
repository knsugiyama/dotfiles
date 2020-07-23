#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/os_detect.sh
. ${DOTPATH}/etc/scripts/lib/is_exists.sh

OS=$(os_detect)

if ! is_exists "java"; then
    echo "java is not installed."
    exit 1
fi

if [ ${OS} == 'osx' ]; then
    jenv add $(/usr/libexec/java_home -v "1.8")
elif [ ${OS} == 'linux' ]; then
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
    sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
    sudo apt update
    sudo apt install adoptopenjdk-8-hotspot
    jenv add /usr/lib/jvm/java-8-openjdk-amd64
fi

jenv global 1.8
# sjenv enable-plugin export
