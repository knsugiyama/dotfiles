{
  # Reapply the locked configuration without updating packages.
  dot-apply = "if [[ $(uname) == 'Darwin' ]]; then pushd ~/.dotfiles && sudo darwin-rebuild switch --flake .#macos && popd; else pushd ~/.dotfiles && home-manager switch --flake .#wsl2 && popd; fi";

  # Explicitly update package sources, then apply the configuration.
  dot-update = "if [[ $(uname) == 'Darwin' ]]; then pushd ~/.dotfiles && brew update && brew upgrade --greedy && nix flake update && sudo darwin-rebuild switch --flake .#macos && popd; else pushd ~/.dotfiles && nix flake update && home-manager switch --flake .#wsl2 && popd; fi";
}
