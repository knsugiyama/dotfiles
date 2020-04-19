#!/bin/bash

set -ue

sudo apt -y install openjdk-8-jdk
fish -c "jenv add /usr/lib/jvm/java-8-openjdk-amd64"
fish -c "jenv global 1.8.0.242"
echo 'set -x JAVA_HOME (jenv prefix)' >> ~/.config/fish/env.fish
echo 'export JAVA_HOME="$(jenv prefix)"' >> .bash_profile
