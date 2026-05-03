{ pkgs, ... }: {
  # macOS system level settings
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 5;
  system.primaryUser = "knsugiyama";

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    biz-ud-gothic
    monaspace
    plemoljp-nf
  ];

  # Basic system settings
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  users.users.knsugiyama = {
    name = "knsugiyama";
    home = "/Users/knsugiyama";
  };

  # Link apps installed by Nix to /Applications
  system.activationScripts.postActivation.text = ''
    echo "Linking Nix apps to /Applications..."
    apps_path="/Applications/Nix Apps"
    mkdir -p "$apps_path"
    find "$apps_path" -type l -exec rm {} +
    find "$apps_path" -type d -depth 1 -exec rm -rf {} +
    # Note: Only Nix-installed GUI apps should be linked here.
    # Most are now managed via Homebrew Cask below for better macOS integration.
    apps_source="${pkgs.buildEnv { name = "system-applications"; paths = [ ]; }}/Applications"
    if [ -d "$apps_source" ]; then
      find "$apps_source" -maxdepth 1 -type l | while read -r app; do
        src=$(readlink "$app")
        appname=$(basename "$src")
        echo "Creating alias for $appname..."
        ${pkgs.mkalias}/bin/mkalias "$src" "$apps_path/$appname"
      done
    fi
    '';
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "deskflow/tap"
    ];
    brews = [
      "utf8proc" # Often needed as a dependency for some macOS builds
    ];
    casks = [
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
    ];
  };
}
