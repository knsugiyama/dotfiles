#!/usr/bin/env bash

set -eu

function logging() {
  if [ "$#" -eq 0 -o "$#" -gt 1 ]; then
    echo "Usage: <msg>"
    return 1
  fi

  local text="$1"
  printf "[$(date +%H:%M:%S)] $text"
}

function is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

function os_distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other
    echo 'Ubuntu'
    return
  fi
}

OS="$(uname -s)"          # Darwin Linux
DIST="$(os_distribution)" # Ubuntu         # allow empty

GITHUB_URL=https://github.com/knsugiyama/dotfiles.git
DOTPATH=~/.dotfiles

git clone --recursive "$GITHUB_URL" "$DOTPATH"

if [ "$OS" = Darwin ]; then
  # shellcheck disable=SC1090
  source "$HOME/.dotfiles/dist/Darwin/setup.sh"
elif [ "$OS" = Linux ] && [ "$DIST" = Ubuntu ]; then
  # shellcheck disable=SC1090
  source "$HOME/.dotfiles/dist/Ubuntu/setup.sh"
else
  logging "setup script is not found..."
fi
