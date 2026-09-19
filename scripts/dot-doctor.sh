pass_count=0
warn_count=0
fail_count=0

if [[ -t 1 ]]; then
  green=$'\033[0;32m'
  yellow=$'\033[0;33m'
  red=$'\033[0;31m'
  blue=$'\033[0;34m'
  reset=$'\033[0m'
else
  green=''
  yellow=''
  red=''
  blue=''
  reset=''
fi

pass() {
  printf '%s[OK]%s   %s\n' "$green" "$reset" "$1"
  pass_count=$((pass_count + 1))
}

warn() {
  printf '%s[WARN]%s %s\n' "$yellow" "$reset" "$1"
  warn_count=$((warn_count + 1))
}

fail() {
  printf '%s[FAIL]%s %s\n' "$red" "$reset" "$1"
  fail_count=$((fail_count + 1))
}

section() {
  printf '\n%s%s%s\n' "$blue" "$1" "$reset"
}

check_command() {
  if command -v "$1" >/dev/null 2>&1; then
    pass "$1 is available"
  else
    fail "$1 is not available"
  fi
}

check_managed_path() {
  local path=$1
  if [[ -L "$path" && -e "$path" ]]; then
    pass "$path is managed and valid"
  elif [[ -L "$path" ]]; then
    fail "$path is a dangling link"
  elif [[ -e "$path" ]]; then
    warn "$path exists but is not managed by Home Manager"
  else
    fail "$path is missing"
  fi
}

repo=${DOTFILES_PATH:-"$HOME/.dotfiles"}

printf '%sDotfiles doctor%s\n' "$blue" "$reset"

section 'Commands'
for command_name in nix brew git zed starship jq; do
  check_command "$command_name"
done

section 'Repository'
if [[ -d "$repo/.git" && -f "$repo/flake.nix" ]]; then
  pass "$repo is a dotfiles repository"
else
  fail "$repo is not a usable dotfiles repository"
fi

if git -C "$repo" diff --quiet && git -C "$repo" diff --cached --quiet; then
  pass 'Git worktree is clean'
else
  warn 'Git worktree has uncommitted changes'
fi

if nix flake metadata --no-write-lock-file "$repo" >/dev/null 2>&1; then
  pass 'Nix flake metadata can be evaluated'
else
  fail 'Nix flake metadata evaluation failed'
fi

section 'Home Manager links'
for managed_path in \
  "$HOME/.config/git/config" \
  "$HOME/.config/hammerspoon" \
  "$HOME/.config/nvim" \
  "$HOME/.config/zed"; do
  check_managed_path "$managed_path"
done

if [[ -e "$HOME/.gitconfig" || -L "$HOME/.gitconfig" ]]; then
  warn 'Legacy ~/.gitconfig exists and may override Home Manager settings'
else
  pass 'No legacy ~/.gitconfig override exists'
fi

if [[ -e "$HOME/.config/ghostty" || -L "$HOME/.config/ghostty" ]]; then
  warn 'Legacy Ghostty configuration still exists'
else
  pass 'No legacy Ghostty configuration exists'
fi

section 'Git'
git_editor=$(git config --get core.editor || true)
if [[ "$git_editor" == 'zed --wait' ]]; then
  pass 'Git editor is zed --wait'
else
  warn "Git editor is ${git_editor:-not configured}"
fi

if git config --get-all credential.helper | grep -Fxq 'osxkeychain'; then
  pass 'Git credential helper uses macOS Keychain'
else
  warn 'Git credential helper is not osxkeychain'
fi

section 'Applications and fonts'
if [[ -d /Applications/Zed.app ]]; then
  pass 'Zed.app is installed'
else
  fail 'Zed.app is not installed'
fi

if [[ -f "$HOME/Library/Fonts/PlemolJPConsoleNF-Regular.ttf" ]]; then
  pass 'PlemolJP Console NF is installed'
else
  warn 'PlemolJP Console NF regular font was not found'
fi

if command -v brew >/dev/null 2>&1 && command -v nix >/dev/null 2>&1; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  declared_casks=$(nix eval --json "$repo#darwinConfigurations.macos.config.homebrew.casks" 2>/dev/null | jq -r '.[] | if type == "string" then . else .name end' || true)
  missing_casks=0
  while IFS= read -r cask; do
    [[ -n "$cask" ]] || continue
    if ! brew list --cask "$cask" >/dev/null 2>&1; then
      warn "Declared Homebrew cask is missing: $cask"
      missing_casks=$((missing_casks + 1))
    fi
  done <<< "$declared_casks"
  if [[ $missing_casks -eq 0 ]]; then
    pass 'All declared Homebrew casks are installed'
  fi

  installed_casks=$(brew list --cask)
  extra_casks=0
  while IFS= read -r cask; do
    [[ -n "$cask" ]] || continue
    if ! grep -Fxq "$cask" <<< "$declared_casks"; then
      warn "Installed Homebrew cask is not declared: $cask"
      extra_casks=$((extra_casks + 1))
    fi
  done <<< "$installed_casks"
  if [[ $extra_casks -eq 0 ]]; then
    pass 'No undeclared Homebrew casks are installed'
  fi

  declared_formulae=$(nix eval --json "$repo#darwinConfigurations.macos.config.homebrew.brews" 2>/dev/null | jq -r '.[] | if type == "string" then . else .name end' || true)
  missing_formulae=0
  while IFS= read -r formula; do
    [[ -n "$formula" ]] || continue
    if ! brew list --formula "$formula" >/dev/null 2>&1; then
      warn "Declared Homebrew formula is missing: $formula"
      missing_formulae=$((missing_formulae + 1))
    fi
  done <<< "$declared_formulae"
  if [[ $missing_formulae -eq 0 ]]; then
    pass 'All declared Homebrew formulae are installed'
  fi

  installed_formulae=$(brew leaves)
  extra_formulae=0
  while IFS= read -r formula; do
    [[ -n "$formula" ]] || continue
    if ! grep -Fxq "$formula" <<< "$declared_formulae"; then
      warn "Installed top-level Homebrew formula is not declared: $formula"
      extra_formulae=$((extra_formulae + 1))
    fi
  done <<< "$installed_formulae"
  if [[ $extra_formulae -eq 0 ]]; then
    pass 'No undeclared top-level Homebrew formulae are installed'
  fi
fi

printf '\n%sSummary%s: %d OK, %d warnings, %d failures\n' \
  "$blue" "$reset" "$pass_count" "$warn_count" "$fail_count"

if [[ $fail_count -gt 0 ]]; then
  exit 1
fi
