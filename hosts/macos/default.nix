{ pkgs, username, ... }: {
  # macOS system level settings
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 5;
  system.primaryUser = username;

  # Basic system settings
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "deskflow/tap"
    ];
    brews = [
      "utf8proc"
    ];
    casks = [
      "docker-desktop"
      "ghostty"
      "git-credential-manager"
      "google-chrome"
      "slack"
      "discord"
      "obsidian"
      "postman"
      "zoom"
      "zotero"
      "anki"
      "hammerspoon"
      "microsoft-auto-update"
      "microsoft-teams"
      "font-biz-udpgothic"
      "font-hack-nerd-font"
      "font-monaspace"
      "font-plemol-jp"
      "font-plemol-jp-hs"
      "font-plemol-jp-nf"
      "font-ibm-plex-sans-jp"
      "claude-code"
    ];
  };
}
