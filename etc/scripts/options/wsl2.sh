#!/bin/bash

sudo ln -sfnv ${DOTPATH}/wsl.conf /etc/wsl.conf

# credential
sudo touch /usr/bin/git-credential-manager
sudo sh -c "echo \#\!/bin/sh >>/usr/bin/git-credential-manager"
sudo sh -c "echo exec /mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe $@ >>/usr/bin/git-credential-manager"

sudo chmod +x /usr/bin/git-credential-manager

sed '/  helper/d' ~/.dotfiles/.gitconfig.credential -i
echo '  helper = manager' >>~/.dotfiles/.gitconfig.credential
