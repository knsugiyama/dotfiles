#!/bin/bash

set -ue

if [ ${OS} == 'osx' ]; then
    brew cask install font-cica

elif [ ${OS} == 'linux' ]; then
    # cica
    sudo mkdir -p /usr/share/fonts/cica
    CICA_RELEASES_URL="https://api.github.com/repos/miiton/Cica/releases"
    sudo curl -sfL "$CICA_RELEASES_URL" | jq -r '.[0].assets | .[].browser_download_url' | grep with_emoji.zip | xargs -I{} curl -fL -o /tmp/Cica.zip "{}"
    (cd /tmp && sudo unzip -o Cica.zip -d /usr/share/fonts/cica)

    sudo fc-cache -vf
fi
