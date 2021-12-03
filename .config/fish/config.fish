. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

set -x LANG en_US.UTF-8
set -U EDITOR vim

eval (hub alias -s)
direnv hook fish | source
