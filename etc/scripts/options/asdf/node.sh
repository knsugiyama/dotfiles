#!/bin/bash

. ${DOTPATH}/etc/scripts/lib/is_exists.sh

asdf plugin install nodejs

# もしyarnなど npm -i g したものを入れたい場合
# npm i -g yarn
# asdf reshim nodejs
