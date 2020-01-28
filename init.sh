!/bin/bash

set -ue

DOTFILESPATH=~/.dotfiles
GITHUB_URL=https://github.com/knsugiyama/dotfiles.git

sudo apt update
sudo apt upgrade

# git が使えるかチェック
if !(type "git" > /dev/null 2>&1); then
    # 使えない場合は git をインストールする
    sudo apt install git
fi

git clone --recursive "$GITHUB_URL" "$DOTFILESPATH"

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    die "not found: $DOTFILESPATH"
fi

# シンボリックリンク作成
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".bin" ] && continue
    [ "$f" = ".config" ] && continue
    [ "$f" = ".gitignore" ] && continue

    ln -snfv "$DOTFILESPATH"/"$f" "$HOME"/"$f"
done

# 以降のインストールおよびセットアップ作業にはmakeコマンドが必要なので、install
sudo apt install -y make
