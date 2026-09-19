{ username, ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 5;
  system.primaryUser = username;

  system.defaults = {
    NSGlobalDomain = {
      # Keep source code and technical writing from being rewritten by macOS.
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    dock = {
      autohide = true;
      minimize-to-application = true;
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
    };
  };

  programs.zsh.enable = true;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  homebrew = {
    enable = true;
    # Keep normal activation deterministic. Updates are run explicitly via dot-update.
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # Homebrew 7 removed the legacy `brew bundle --cleanup` switch.
      # Remove obsolete packages explicitly instead of during every activation.
      cleanup = "none";
    };
    brews = [
      "utf8proc"
    ];
    casks = [
      "docker-desktop"
      "zed"
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
      "font-plemol-jp-nf"
      "claude-code"
    ];
  };
}
