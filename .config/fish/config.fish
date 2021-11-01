. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

eval (hub alias -s)
direnv hook fish | source
