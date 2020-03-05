#!/bin/sh

install() {
  cat ${SCRIPTPATH}/packages | while read package_name;
  do
    if [ line != '' ]; then
      sudo apt install -y ${package_name}
    fi
  done
}

echo 'Ubuntu package install'

SCRIPTPATH=$(dirname $0)

sudo apt update
sudo apt upgrade
sudo apt install -y software-properties-common unzip zlib1g-dev libsecret-1-0 libsecret-1-dev

## japanease lang setting
sudo apt -y install language-pack-ja-base language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
sudo apt -y install manpages-ja manpages-ja-dev
sudo locale-gen ja_JP.UTF-8

install

## git credential
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret/
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

sh ${SCRIPTPATH}/linuxbrew.sh
