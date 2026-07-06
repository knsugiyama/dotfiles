{ config, pkgs, username, ... }: {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  imports = [
    ../../modules/home/core.nix
    ../../modules/home/git.nix
    ../../modules/home/mise.nix
    ../../modules/home/starship.nix
    ../../modules/home/shell
    ../../modules/home/tmux.nix
    ../../modules/home/config-files.nix
  ];

  # WSL2 specific packages
  home.packages = with pkgs; [
    # Add Linux specific tools here
  ];

  programs.home-manager.enable = true;
}
