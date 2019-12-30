source ~/dotfiles/.fish/alias.fish
cd ~/

# fzf .git ignore setting
set --export FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

# theme-bobthefish settings
set -g theme_display_hostname no
set -g theme_display_user no
set -g theme_newline_cursor yes
set -g theme_display_git_master_branch yes
set -g theme_color_scheme dracula
set -g theme_display_date no
set -g theme_display_cmd_duration no
