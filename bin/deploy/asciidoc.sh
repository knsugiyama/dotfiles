#!/bin/bash

set -ue

brew install asciidoc

XML_CATALOG_FILES_PATH=$(brew --prefix)/etc/xml/catalog
echo "export XML_CATALOG_FILES=${XML_CATALOG_FILES_PATH}/etc/xml/catalog" >> ~/.bashrc

gem install bundler
gem install asciidoctor
gem install asciidoctor-pdf --pre
gem install asciidoctor-pdf-cjk
gem install asciidoctor-diagram
gem install coderay
gem install rouge
gem install concurrent-ruby

echo 'set -x PATH "/usr/local/opt/icu4c/bin" $PATH' >> ~/.config/fish/env.fish
echo 'set -x PATH "/usr/local/opt/icu4c/sbin" $PATH' >> ~/.config/fish/env.fish
