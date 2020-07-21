#!/bin/bash

set -ue

. ${DOTPATH}/etc/scripts/lib/os_detect.sh

CURRENTPATH=$(dirname $0)
OS=$(os_detect)

if [ ${OS} == 'osx' ]; then
    brew cask install google-cloud-sdk

    echo "source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'" >>~/.bashrc
    echo "source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'" >>~/.bashrc

    if (type "fish" >/dev/null 2>&1); then
        echo "source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc" >>~/.config/fish/env.fish
    fi

elif [ ${OS} == 'linux' ]; then
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-get update && sudo apt-get install google-cloud-sdk
fi
