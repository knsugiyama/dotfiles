zstyle ':zim:zmodule' use 'degit'

ZSHDHOME=${ZDOTDIR:-${HOME}}/.zsh.d
if [ -d $ZSHDHOME -a -r $ZSHDHOME -a \
     -x $ZSHDHOME ]; then
    for i in $ZSHDHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

ZIM_HOME=~/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

if [[ -d "$HOME/.asdf" ]]; then
    . "$HOME/.asdf/asdf.sh"
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

eval "$(starship init zsh)"
