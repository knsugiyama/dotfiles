{ pkgs, ... }: {
  home.packages = with pkgs; [
    direnv
    gemini-cli
    ripgrep
    fd
    eza
    gh
    ghq
    fzf
    jq
    htop
    neovim
    tmux
    stylua
  ];
}
