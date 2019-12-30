#!/bin/bash

DOTFILESPATH=~/.dotfiles
GITHUB_URL=https://github.com/knsugiyama/dotfiles.git

# git が使えるなら git
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTFILESPATH"

# 使えない場合は curl か wget を使用する
elif has "curl" || has "wget"; then
    tarball="https://github.com/knsugiyama/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if has "curl"; then
        curl -L "$tarball"

    elif has "wget"; then
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
