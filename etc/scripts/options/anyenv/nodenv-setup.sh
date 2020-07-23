#!/bin/bash

touch $(nodenv root)/default-packages
mkdir -p $(nodenv root)/plugins
git clone https://github.com/pine/nodenv-yarn-install.git $(nodenv root)/plugins/nodenv-yarn-install

nodenv install 14.5.0
nodenv global 14.5.0
