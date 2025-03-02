#!/usr/bin/env bash

set -eu

INSTANCE_NAME="myvm"

# ssh 接続設定用に仮想環境名ディレクトリを切る
WORKSPACE="${HOME}/.ssh/multipass/${INSTANCE_NAME}"
mkdir -p "${WORKSPACE}"

# 仮想環境名の鍵生成
## パスフレーズは空
ssh-keygen -t ed25519 -b 521 -N "" -f "${WORKSPACE}/${INSTANCE_NAME}"

# config ファイル作成
touch "${WORKSPACE}/config"

# 公開鍵を仮想環境の authorized_keys に追加
# multipass exec <仮想環境名> --working-directory <コマンド実行ディレクトリ> -- <実行コマンド>
multipass exec hoge --working-directory "/home/ubuntu/.ssh" -- bash -c "echo '$(cat ${WORKSPACE}/${INSTANCE_NAME}.pub)' | tee -a authorized_keys"
