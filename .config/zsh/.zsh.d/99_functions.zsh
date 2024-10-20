function prj() {
  local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs exa -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
  if [ -n "$repo" ]; then
    repo=$(ghq list --full-path --exact $repo)
    BUFFER="cd ${repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N prj
bindkey '^p' prj

# https://zenn.dev/kis9a/articles/my_zsh_completion_function >>
function zsh_functions() {
  if [[ -z "$1" ]]; then
    functions | grep \(\) | grep -v '^\_' | grep -v '^\s' | grep '^[a-z]' | cut -f 1 -d " " &&
      alias | cut -f 1 -d "="
  fi
  while getopts ":a" option; do
    case "$option" in
    a)
      functions | grep \(\) | grep -v '^\_' | grep -v '^\s' | grep '^[a-z]' | cut -f 1 -d " " &&
        alias | cut -f 1 -d "=" && bash -c "compgen -c"
      break
      ;;
    *)
      cat <<'EOF'
USAGE:
zsh_functions [option]
  -a: all commands
EOF
      break
      ;;
    esac
  done
}

function zh() {
  funcs=($(zsh_functions | uniq | sort | fzf -m | tr "\n" " "))
  for f in $funcs; do
    alias "$f"
    functions "$f"
  done
}

function _zsh_function_find() {
  BUFFER="$BUFFER$(zsh_functions | uniq | sort | fzf -m)"
  zle end-of-line
}
bindkey '^o' _zsh_function_find
zle -N _zsh_function_find

function _zsh_command_find() {
  BUFFER="$BUFFER$(zsh_functions -a | uniq | sort | fzf -m)"
  zle end-of-line
}
bindkey '^k' _zsh_command_find
zle -N _zsh_command_find
# <<
