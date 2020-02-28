# base action
alias l 'ls'
alias ll 'ls -ltr'
alias la 'ls -la'
alias ls 'ls -G -F'
alias ltr 'ls -ltr'

# config.fishをvimで開く
alias ef 'vim ~/.config/fish/config.fish'

# -n 行数表示, -I バイナリファイル無視
alias grep 'grep --color -n -I'
# tree
alias tree "tree -NC" # N: 文字化け対策, C:色をつける

alias mkdir 'mkdir -p'
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

alias c 'clear'
alias h 'history'

alias cx 'chmod +x'
alias 'c-x' 'chmod -x'

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# git alias
alias ga 'git add '
alias gaa 'git add --all'

alias gb 'git branch'
alias gba 'git branch -a'
alias gbd 'git branch -d'

alias gc 'git commit -v'
alias gcmsg 'git commit -m'
alias gc! 'git commit -v --amend'

alias gcb 'git checkout -b'
alias gcm 'git checkout master'
alias gcd 'git checkout develop'
alias gco 'git checkout'

alias gd 'git diff'
alias gdca 'git diff --cached'
alias gdt 'git diff-tree --no-commit-id --name-only -r'
alias gdw 'git diff --word-diff'
alias gdct 'git describe --tags `git rev-list --tags --max-count=1`'

alias gf 'git fetch'
alias gfa 'git fetch --all --prune'
alias gfo 'git fetch origin'

alias ggpull 'git pull origin (git_current_branch)'
alias ggpush 'git push origin (git_current_branch)'

alias gl 'git pull'
alias glg 'git log --stat'
alias glgp 'git log --stat -p'
alias glgg 'git log --graph'
alias glgga 'git log --graph --decorate --all'
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

# simple repository move
alias g 'cd (ghq root)/(ghq list | peco)'

# tmux alias
alias tk 'tmux kill-session -t'
alias tl 'tmux ls'

# config.fishを読み込む
function reload
  source ~/.config/fish/config.fish
end

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

function cd
  builtin cd $argv; and ls
end

function git_current_branch
  set -l ref (git symbolic-ref --quiet HEAD 2> /dev/null)
  set -l ret $status
  if [ $ret != 0 ]
    [ $ret == 128 ]; and return  # no git repo.
    set -l ref (git rev-parse --short HEAD 2> /dev/null); or return
  end
  string replace 'refs/heads/' "" $ref
end
