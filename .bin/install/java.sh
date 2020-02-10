#!/bin/bash

set -ue

# jenv が使えるかチェック
if !(type "jenv" > /dev/null 2>&1); then
    echo 'jenvをインストールしてください'
    exit 1
fi

sudo apt -y install openjdk-8-jdk
jenv add /usr/lib/jvm/java-8-openjdk-amd64
jenv global openjdk64-1.8.0.242
jenv enable-plugin export

