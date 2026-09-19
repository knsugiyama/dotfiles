pass_count=0
fail_count=0
check_count=0
repo=${DOTFILES_PATH:-"$HOME/.dotfiles"}
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

if [[ -t 1 ]]; then
  green=$'\033[0;32m'
  red=$'\033[0;31m'
  blue=$'\033[0;34m'
  reset=$'\033[0m'
else
  green=''
  red=''
  blue=''
  reset=''
fi

pass() {
  printf '%s[OK]%s   %s\n' "$green" "$reset" "$1"
  pass_count=$((pass_count + 1))
}

fail() {
  printf '%s[FAIL]%s %s\n' "$red" "$reset" "$1"
  fail_count=$((fail_count + 1))
}

run_check() {
  local label=$1
  shift
  check_count=$((check_count + 1))
  local log_file="$temp_dir/check-$check_count.log"

  if "$@" >"$log_file" 2>&1; then
    pass "$label"
  else
    fail "$label"
    sed 's/^/       /' "$log_file"
  fi
}

check_repository() {
  [[ -d "$repo/.git" && -f "$repo/flake.nix" ]]
}

check_git_diff() {
  git -C "$repo" diff --check && git -C "$repo" diff --cached --check
}

check_bootstrap() {
  bash -n "$repo/bootstrap.sh"
}

check_zed_settings() {
  jq empty "$repo/.config/zed/settings.json"
}

check_starship() {
  [[ -f "$repo/modules/home/starship/starship.toml" ]] || return 1
  STARSHIP_CONFIG="$repo/modules/home/starship/starship.toml" starship print-config >/dev/null
}

check_neovim() {
  local cache_dir="$temp_dir/nvim-cache"
  local state_dir="$temp_dir/nvim-state"
  [[ -f "$repo/.config/nvim/init.lua" ]] || return 1
  mkdir -p "$cache_dir" "$state_dir"
  XDG_CONFIG_HOME="$repo/.config" XDG_CACHE_HOME="$cache_dir" XDG_STATE_HOME="$state_dir" \
    nvim --headless '+qa'
}

check_flake() {
  nix flake check --no-build "$repo"
}

check_darwin_build() {
  nix build "$repo#darwinConfigurations.macos.system" --dry-run --no-link
}

printf '%sDotfiles check%s\n\n' "$blue" "$reset"

run_check 'Repository structure' check_repository
run_check 'Git diff whitespace and conflict markers' check_git_diff
run_check 'bootstrap.sh syntax' check_bootstrap
run_check 'Zed settings JSON' check_zed_settings
run_check 'Starship configuration' check_starship
run_check 'Neovim headless startup' check_neovim
run_check 'Nix flake evaluation' check_flake
run_check 'nix-darwin system build dry-run' check_darwin_build

printf '\n%sSummary%s: %d passed, %d failed\n' \
  "$blue" "$reset" "$pass_count" "$fail_count"

if [[ $fail_count -gt 0 ]]; then
  exit 1
fi
