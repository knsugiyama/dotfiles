#!/bin/sh

. ${DOTPATH}/etc/scripts/lib/os_detect.sh

OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    brew install intellij-idea-ce

elif [ ${OS} == 'linux' ]; then
    wget https://download.jetbrains.com/idea/ideaIC-2021.1.1.tar.gz
    mkdir -p ~/opt/ideaIC && sudo tar -zxvf ideaIC-2021.*.tar.gz -C ~/opt/ideaIC --strip-components 1
    sudo ln -s ~/opt/ideaIC/bin/idea.sh /usr/bin/idea
fi
