#!/bin/bash

set -ue

brew install graphviz
brew install plantuml

# java が使えるかチェック
if !(type "java" > /dev/null 2>&1); then
    # 使えない場合は java をインストールする
    anyenv install jenv
    sudo apt -y install openjdk-8-jdk
    jenv add /usr/lib/jvm/java-8-openjdk-amd64
    jenv enable-plugin export
fi
