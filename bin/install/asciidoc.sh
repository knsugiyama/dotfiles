#!/bin/bash

set -ue

if !(type "ruby" > /dev/null 2>&1); then
    echo 'rbenvをインストールしてください。'
    exit 1
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
