#!/bin/bash

sudo ln -sfnv ${DOTPATH}/wsl.conf /etc/wsl.conf

# credential
sed '/  helper/d' ~/.dotfiles/.gitconfig.credential -i
echo '  helper =  /mnt/c/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe' >>~/.dotfiles/.gitconfig.credential
