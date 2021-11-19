#!/usr/bin/env bash

lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

ostype() {
    # shellcheck disable=SC2119
    uname | lower
}

os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  echo 'linux'   ;;
        *'darwin'*) echo 'osx'     ;;
        *)          echo 'unknown' ;;
    esac
}
