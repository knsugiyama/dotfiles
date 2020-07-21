#!/bin/bash

## git credential
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret/
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
