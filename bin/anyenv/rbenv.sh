#!/bin/bash

set -ue

anyenv install rbenv
brew install rbenv-communal-gems

PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.bash_profile

echo 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"' >> ~/.bash_profile
