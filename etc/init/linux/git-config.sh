#!/bin/bash

## git credential
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret/
echo '  helper = /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret' >>~/.dotfiles/.gitconfig.credential
