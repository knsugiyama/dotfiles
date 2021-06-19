. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

set -gx TERM xterm-256color

set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
set -g theme_color_scheme dracula
set -g theme_display_date no
set -g theme_display_cmd_duration no

eval (hub alias -s)
direnv hook fish | source
