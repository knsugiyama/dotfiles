#!/bin/bash

git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

pyenv install 3.8.5
pyenv install 2.7.18

pyenv global 3.8.5
