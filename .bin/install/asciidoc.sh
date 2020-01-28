#!/bin/bash

set -ue

# rbenv が使えるかチェック
if !(type "rbenv" > /dev/null 2>&1); then
    echo 'rbenvをインストールしてください。'
    exit 1
fi
# ruby が無いならインストールする
if !(type "ruby" > /dev/null 2>&1); then
    rbenv install 2.7.0
    rbenv global 2.7.0
fi

brew install asciidoc

sudo gem install bundler
sudo gem install asciidoctor
sudo gem install asciidoctor-pdf --pre
sudo gem install asciidoctor-pdf-cjk
sudo gem install asciidoctor-diagram
sudo gem install coderay
sudo gem install rouge
sudo gem install concurrent-ruby
