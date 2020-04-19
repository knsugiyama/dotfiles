#!/bin/bash

set -ue

# /usr/libexec/java_home -V でわかる
fish -c "jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
fish -c "jenv global 1.8.0.242"
echo 'set -x JAVA_HOME (jenv prefix)' >> ~/.config/fish/env.fish
echo 'export JAVA_HOME="$(jenv prefix)"' >> .bash_profile
