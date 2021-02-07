. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

# theme-bobthefish settings
set -g theme_display_hostname no
set -g theme_display_user no
set -g theme_newline_cursor yes
set -g theme_display_git_master_branch yes
set -g theme_color_scheme dracula
set -g theme_display_date no
set -g theme_display_cmd_duration no

eval (hub alias -s)

set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
powerline-setup
