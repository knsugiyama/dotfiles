#!/bin/bash

set -ue

. ${DOTPATH}/bin/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    brew cask install intellij-idea-ce

elif [ ${OS} == 'linux' ]; then
    wget https://download.jetbrains.com/idea/ideaIC-2019.3.3-no-jbr.tar.gz
    mkdir -p ~/opt/ideaIC && sudo tar -zxvf ideaIC-2019.*.tar.gz -C ~/opt/ideaIC --strip-components 1
    sudo ln -s ~/opt/ideaIC/bin/idea.sh /usr/bin/idea
fi
