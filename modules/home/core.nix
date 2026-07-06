{ pkgs, ... }:
let
  shell-utils = with pkgs; [
    ripgrep
    fd
    eza
    fzf
    jq
    tree
    unzip
    wget
    curl
    dasel
    git-lfs
    gnupg
    gnugrep
  ];

  dev-tools = with pkgs; [
    neovim
    ghq
    stylua
    gemini-cli
    gcc
    lua
  ];

  system-tools = with pkgs; [
    htop
  ];
in {
  xdg.enable = true;

  home.packages = shell-utils ++ dev-tools ++ system-tools;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
