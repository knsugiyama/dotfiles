ZSHDHOME=${ZDOTDIR:-${HOME}}/.zsh.d
if [ -d $ZSHDHOME -a -r $ZSHDHOME -a \
     -x $ZSHDHOME ]; then
    for i in $ZSHDHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

eval "$(sheldon source)"

if [ which yaskkserv2 >/dev/null 2>&1 ]; then
    yaskkserv2 --google-japanese-input=notfound --google-cache-filename=$HOME/.cache/skk/yaskkserv2.cache --google-suggest $HOME/.config/skk/dictionary.yaskkserv2
fi
