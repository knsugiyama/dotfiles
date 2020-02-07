#!/bin/bash

set -ue

# rbenv が使えるかチェック
if !(type "rbenv" > /dev/null 2>&1); then
    echo 'rbenvをインストールしてください。'
    exit 1
fi

rbenv install 2.7.0
rbenv global 2.7.0
