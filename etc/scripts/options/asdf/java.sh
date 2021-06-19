#!/bin/bash

asdf plugin add java

# set java home
# . ~/.asdf/plugins/java/set-java-home.fish

# asdf-java管理外のjvmを追加する方法(mac)
# 以下のような形で、シンボリックリンクをリンク元のディレクトリ、ファイル全てに対して実行する
# ln -s /Library/Java/JavaVirtualMachines/<jdk name>/Contents/Home/xxx ~/.asdf/installs/java/<jdk name>
# シンボリックリンクの作成が終わったらreshim
# asdf reshim java
