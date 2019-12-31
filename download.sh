#!/bin/bash

DOTFILESPATH=~/.dotfiles
GITHUB_URL=https://github.com/knsugiyama/dotfiles.git

# git が使えるなら git
if type "git" > /dev/null 2>&1; then
    git clone --recursive "$GITHUB_URL" "$DOTFILESPATH"

# 使えない場合は curl か wget を使用する
elif type "curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/knsugiyama/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl" > /dev/null 2>&1; then
        curl -L "$tarball"

    elif type "wget" > /dev/null 2>&1; then
        wget -O - "$tarball"

    fi | tar zxv

    # 解凍したら，DOTFILESPATH に置く
    mv -f dotfiles-master "$DOTFILESPATH"

else
    die "curl or wget or git required"
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    die "not found: $DOTFILESPATH"
fi

# シンボリックリンク作成
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".wsl" ] && continue
    [ "$f" = ".fish" ] && continue

    ln -snfv "$DOTFILESPATH"/"$f" "$HOME"/"$f"
done
