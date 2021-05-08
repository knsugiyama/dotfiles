alias ls 'ls -l'
alias ll 'ls -alF'

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# -n 行数表示, -I バイナリファイル無視
# alias grep 'grep --color -n -I'
alias grep 'grep --color -I'

alias tree "tree -NC" # N: 文字化け対策, C:色をつける

alias mkdir 'mkdir -p'
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

alias c 'clear'
alias h 'history'

alias cx 'chmod +x'
alias 'c-x' 'chmod -x'

alias top 'htop'

alias 'listen-ports' 'sudo lsof -i -P | grep LISTEN'

############
# tmux alias
############
alias t 'tmux'
alias tk 'tmux kill-session -t'
alias tl 'tmux ls'

############
# nvim alias
############
alias vi 'nvim'

############
# Docker alias
############
alias dcirms 'docker ps -aq | xargs docker rm -f && docker images -aq | xargs docker rmi -f'

