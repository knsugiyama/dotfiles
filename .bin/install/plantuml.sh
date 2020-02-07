#!/bin/bash

set -ue

if !(type "java" > /dev/null 2>&1); then
    echo 'javaをインストールしてください'
    exit 1
fi

brew install graphviz
brew install plantuml
