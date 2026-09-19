{
  # Reapply the locked configuration without updating packages.
  dot-apply = "pushd ~/.dotfiles && sudo darwin-rebuild switch --flake .#macos && popd";

  # Explicitly update package sources, then apply the configuration.
  dot-update = "pushd ~/.dotfiles && brew update && brew upgrade --greedy && nix flake update && sudo darwin-rebuild switch --flake .#macos && popd";
}
