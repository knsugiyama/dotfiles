#!/bin/sh

. ${DOTPATH}/bin/lib/logging.sh
. ${DOTPATH}/bin/lib/os_detect.sh

set -ue

OS=$(os_detect)
CURRENTPATH=$(dirname $0)

echo $(log_echo "start init.")

if [ ${OS} == 'osx' ]; then
    echo $(log_echo "install homebrew")
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo $(log_echo "update homebrew")
    brew update --verbose

    ## git credential
    git config --global credential.helper osxkeychain

elif [ ${OS} == 'linux' ]; then
    echo $(log_echo "Ubuntu package install.")

    SCRIPTPATH=$(dirname $0)

    sudo apt update
    sudo apt upgrade
    sudo apt install -y software-properties-common unzip zlib1g-dev libsecret-1-0 libsecret-1-dev fontconfig

    ## japanease lang setting
    sudo apt -y install language-pack-ja-base language-pack-ja
    sudo update-locale LANG=ja_JP.UTF-8
    sudo apt -y install manpages-ja manpages-ja-dev
    sudo locale-gen ja_JP.UTF-8

    ## basic pakages install
    cat ${SCRIPTPATH}/linux/packages | while read package_name;
    do
        if [ line != '' ]; then
        echo $(log_info "package name: $package_name")
        sudo apt install -y ${package_name}
        fi
    done

    # linuxbrew の導入
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile

    ## git credential
    sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret/
    git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

fi
