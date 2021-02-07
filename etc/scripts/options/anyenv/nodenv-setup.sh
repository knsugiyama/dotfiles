#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/is_exists.sh

if ! is_exists "nodenv"; then
    anyenv install nodenv
fi

touch $(nodenv root)/default-packages
mkdir -p $(nodenv root)/plugins
git clone https://github.com/pine/nodenv-yarn-install.git $(nodenv root)/plugins/nodenv-yarn-install

# nodenv install 14.11.0
# nodenv global 14.11.0
