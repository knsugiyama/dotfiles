{ config, pkgs, username, ... }: {
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home/core.nix
    ../../modules/home/git.nix
    ../../modules/home/mise.nix
    ../../modules/home/starship.nix
    ../../modules/home/shell
    ../../modules/home/config-files.nix
  ];

  # macOS specific packages
  home.packages = with pkgs; [
    # Add macOS specific tools here
  ];

  programs.home-manager.enable = true;
}
