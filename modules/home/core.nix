{ pkgs, ... }: 
let
  shell-utils = with pkgs; [
    ripgrep
    fd
    eza
    fzf
    jq
    direnv
  ];

  dev-tools = with pkgs; [
    neovim
    gh
    ghq
    stylua
    gemini-cli
  ];

  system-tools = with pkgs; [
    tmux
    htop
  ];
in {
  xdg.enable = true;

  home.packages = shell-utils ++ dev-tools ++ system-tools;
}
