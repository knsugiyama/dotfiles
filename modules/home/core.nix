{ pkgs, ... }:
let
  shell-utils = with pkgs; [
    ripgrep
    fd
    eza
    lsd
    fzf
    jq
    direnv
    tree
    unzip
    unar
    wget
    curl
    dasel
    git-lfs
    gnupg
    gnugrep
    hub
  ];

  dev-tools = with pkgs; [
    ghq
    stylua
    gemini-cli
    gcc
    lua
  ];

  system-tools = with pkgs; [
    tmux
    htop
  ];
in {
  xdg.enable = true;

  home.packages = shell-utils ++ dev-tools ++ system-tools;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };
}
