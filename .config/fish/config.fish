. ~/.config/fish/alias.fish
. ~/.config/fish/myfunctions.fish
. ~/.config/fish/env.fish

set fish_greeting ""

set -gx TERM xterm-256color

set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
set -g theme_display_git_master_branch yes

eval (hub alias -s)
direnv hook fish | source

