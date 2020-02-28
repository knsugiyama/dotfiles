export PS1='\[\e[1;33m\]\u@\h \w ->\n\[\e[1;36m\] \@ \d\$\[\e[m\] '

umask 022

## for WSL2
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
PATH="$HOME/.anyenv/bin:$PATH"
