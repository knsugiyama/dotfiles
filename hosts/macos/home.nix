{ config, pkgs, lib, username, ... }: {
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home/core.nix
    ../../modules/home/git.nix
    ../../modules/home/mise.nix
    ../../modules/home/starship.nix
    ../../modules/home/shell
    ../../modules/home/tmux.nix
    ../../modules/home/config-files.nix
    ../../modules/home/terminal/ghostty.nix
  ];

  # macOS-specific config file symlinks (apps not available on Linux)
  xdg.configFile = lib.genAttrs [ "hammerspoon" "zed" ] (name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/${name}";
  });

  # macOS specific packages
  home.packages = with pkgs; [
    unar
  ];

  programs.home-manager.enable = true;
}
