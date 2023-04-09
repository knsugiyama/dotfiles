#!/usr/bin/env bash
shopt -s expand_aliases
alias karabiner="/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
current_profile=$(karabiner --show-current-profile-name)
profile_list="$(karabiner --list-profile-names)"
next_profile=$(echo -e "${profile_list}\n${profile_list}" | awk "/${current_profile}/{getline; print}" | head -n 1)
karabiner --select-profile "${next_profile}"
