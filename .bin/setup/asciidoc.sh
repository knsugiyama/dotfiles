#!/bin/bash

set -ue

brew install asciidoc

# ruby が使えるかチェック
if !(type "ruby" > /dev/null 2>&1); then
    # 使えない場合は ruby をインストールする
    anyenv install rbenv
    rbenv install 2.7.0
    rbenv global 2.7.0
fi

sudo gem install bundler
sudo gem install asciidoctor
sudo gem install asciidoctor-pdf --pre
sudo gem install asciidoctor-pdf-cjk
sudo gem install asciidoctor-diagram
sudo gem install coderay
sudo gem install rouge
sudo gem install concurrent-ruby
