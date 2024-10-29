alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias grep='rg'

alias c='clear'
alias reload='exec $SHELL -l'

alias ls='eza -alh --icons=auto --no-user'
alias cat='bat --theme="Dracula"'

alias cdf='cd "$(dirname "$(fzf --preview="bat --color=always {}")")"'
