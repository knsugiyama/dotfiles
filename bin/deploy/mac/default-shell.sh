#!/bin/bash

set -ue

echo /usr/local/bin/fish | sudo tee -a /etc/shells
# デフォルトシェルを fish に変更
chsh -s /usr/local/bin/fish
