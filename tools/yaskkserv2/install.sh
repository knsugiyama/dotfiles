#!/bin/zsh
set -e

# ディレクトリの準備
[[ -d ~/bin ]] || mkdir -p ~/bin
[[ -d ~/.config/skk ]] || mkdir -p ~/.config/skk

# yaskkserv2 を $HOME 直下にクローンしてビルド
cd ~
git clone https://github.com/wachikun/yaskkserv2.git
cd yaskkserv2
cargo build --release

# 実行ファイルを配置（PATH 通す場所）
mkdir -p ~/bin
cp target/release/yaskkserv2 ~/bin/
cp target/release/yaskkserv2_make_dictionary ~/bin/

cd ~
rm -rf ~/yaskkserv2

# SKK 辞書を取得して変換
mkdir -p ~/.config/skk
cd ~/.config/skk
wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz
gunzip -f SKK-JISYO.L.gz
yaskkserv2_make_dictionary --dictionary-filename="$HOME/.config/skk/dictionary.yaskkserv2" SKK-JISYO.L
