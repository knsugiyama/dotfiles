{ ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "tokyonight-night";
      font-size = 14;
      font-family = "JetBrainsMono Nerd Font";
    };
  };
}
