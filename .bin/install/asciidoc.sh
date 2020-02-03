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

echo 'export XML_CATALOG_FILES=/home/linuxbrew/.linuxbrew/etc/xml/catalog' >> ~/.bashrc

gem install bundler
gem install asciidoctor
gem install asciidoctor-pdf --pre
gem install asciidoctor-pdf-cjk
gem install asciidoctor-diagram
gem install coderay
gem install rouge
gem install concurrent-ruby
