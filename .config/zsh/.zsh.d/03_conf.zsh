if [[ ! -e ~/.fzf.zsh ]]; then
  $(brew --prefix)/opt/fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
