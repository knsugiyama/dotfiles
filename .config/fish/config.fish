. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

set -g theme_color_scheme dracula

eval (hub alias -s)
direnv hook fish | source
