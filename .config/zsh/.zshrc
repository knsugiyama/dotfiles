ZSHDHOME=${ZDOTDIR:-${HOME}}/.zsh.d
if [ -d $ZSHDHOME -a -r $ZSHDHOME -a \
     -x $ZSHDHOME ]; then
    for i in $ZSHDHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

if [[ -d "$HOME/.asdf" ]]; then
    . "$HOME/.asdf/asdf.sh"
fi

eval "$(starship init zsh)"
