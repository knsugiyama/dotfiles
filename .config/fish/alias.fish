alias ls 'ls -l'
alias ll 'ls -alF'

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# -n 行数表示, -I バイナリファイル無視
alias grep 'grep --color -n -I'

alias tree "tree -NC" # N: 文字化け対策, C:色をつける

alias mkdir 'mkdir -p'
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

alias c 'clear'
alias h 'history'

alias cx 'chmod +x'
alias 'c-x' 'chmod -x'

############
# top
############
alias top 'htop'
alias mem 'top -o rsize'
alias cpu 'top -o cpu'

############
# simple repository move
############
# alias g 'cd (ghq root)/(ghq list | peco)'
# alias gh 'hub browse (ghq list | peco | cut -d "/" -f 2,3)'

############
# tmux alias
############
alias t 'tmux'
alias tk 'tmux kill-session -t'
alias tl 'tmux ls'
