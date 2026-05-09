{ ... }: {
  # Ghostty is installed via Homebrew cask; manage only the config file here.
  xdg.configFile."ghostty/config".text = ''
    theme = tokyonight-night
    font-size = 14
    font-family = PlemolJP Console NF
  '';
}
