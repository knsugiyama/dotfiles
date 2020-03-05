#!/bin/bash

set -ue

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 1 ]; then
        echo "Usage: <msg>"
        return 1
    fi

    local text="$1"
    printf "[$(date +%H:%M:%S)] $text"
}

is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

DOTFILESPATH=~/.dotfiles
GITHUB_URL=https://github.com/knsugiyama/dotfiles.git

download() {
  if ! is_exists "curl" && ! is_exists "wget"; then
    logging "curl or wget required"
    exit 1;
  fi

  local tarball="https://github.com/thalathalaylah/env_constructions/archive/master.tar.gz"
  if is_exists "curl"; then
    curl -L "$tarball"
  elif is_exists "wget"; then
    wget -O - "$tarball"
  fi | tar xvz

  if [ ! -d env_constructions-master ]; then
    logging "env_constructions-master: not found"
    exit 1
  fi
  command mv -f env_constructions-master "$ENV_CONSTRUCTIONS_PATH"
}

install_build_tool() {
    . ${DOTFILESPATH}/bin/lib/os_detect.sh
    OS=$(os_detect)

    # makeが存在しないと後続が続かないので
    if [ ${OS} == 'linux' ]; then
        sudo apt install -y build-essential
    fi
}

ENV_CONSTRUCTIONS_PATH=~/.env_constructions;

download
