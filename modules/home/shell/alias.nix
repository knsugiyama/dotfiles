{
  ls = "eza --icons";
  ll = "eza -alF --icons";
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  cp = "cp -i";
  mv = "mv -i";
  rm = "rm -i";
  v = "nvim";
  vi = "nvim";
  vim = "nvim";
  grep = "rg";
  c = "clear";
  reload = "exec $SHELL -l";

  # Nix / Dotfiles Management
  dot-up = "if [[ $(uname) == 'Darwin' ]]; then darwin-up; else wsl-up; fi";
  darwin-up = "pushd ~/.dotfiles && sudo nix run nix-darwin -- switch --flake .#macos && popd";
  wsl-up = "pushd ~/.dotfiles && home-manager switch --flake .#wsl2 && popd";

  # Update flake.lock (inputs only, no activation)
  nix-up = "pushd ~/.dotfiles && nix flake update && popd";

  # Update flake.lock then activate
  full-up = "if [[ $(uname) == 'Darwin' ]]; then pushd ~/.dotfiles && nix flake update && sudo nix run nix-darwin -- switch --flake .#macos && popd; else pushd ~/.dotfiles && nix flake update && home-manager switch --flake .#wsl2 && popd; fi";
}
