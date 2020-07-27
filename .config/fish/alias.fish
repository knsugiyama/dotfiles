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
# git alias
############
alias ga 'git add'
alias gaa 'git add --all'

alias gb 'git branch'
alias gba 'git branch -a'
alias gbd 'git branch -d'

alias gc 'git commit -v'
alias gcmsg 'git commit -m'
alias gc! 'git commit -v --amend'

alias gco 'git checkout'
alias gcb 'git checkout -b'
alias gcm 'git checkout master'
alias gcd 'git checkout develop'

alias gd 'git diff'
alias gdca 'git diff --cached'
alias gdt 'git diff-tree --no-commit-id --name-only -r'
alias gdw 'git diff --word-diff'
alias gdct 'git describe --tags `git rev-list --tags --max-count=1`'

alias gf 'git fetch'
alias gfa 'git fetch --all --prune'
alias gfo 'git fetch origin'

alias gpl 'git pull'
alias ggpull 'git pull origin (git_current_branch)'

alias gps 'git push'
alias ggpush 'git push origin (git_current_branch)'

alias glg 'git log --stat'
alias glgp 'git log --stat -p'
alias glgg 'git log --graph --decorate --all'
alias glgm 'git log --graph --max-count=10'
alias glo 'git log --oneline --decorate'
alias glol "git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola "git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glog 'git log --oneline --decorate --graph'
alias gloga 'git log --oneline --decorate --graph --all'
alias glp "_git_log_prettily"

alias grh 'git reset HEAD'
alias grhh 'git reset HEAD --hard'

alias gs 'git status'
alias gss 'git status -s'

alias gsta 'git stash save'
alias gstaa 'git stash apply'
alias gstc 'git stash clear'
alias gstd 'git stash drop'
alias gstl 'git stash list'
alias gstp 'git stash pop'
alias gsts 'git stash show --text'

alias vim 'nvim'
alias vimcf 'vim ~/.config/nvim'
############
# top
############
alias top 'htop'
alias mem 'top -o rsize'
alias cpu 'top -o cpu'

############
# simple repository move
############
alias g 'cd (ghq root)/(ghq list | peco)'
alias gh 'hub browse (ghq list | peco | cut -d "/" -f 2,3)'

############
# tmux alias
############
alias tk 'tmux kill-session -t'
alias tl 'tmux ls'
