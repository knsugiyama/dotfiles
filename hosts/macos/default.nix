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
    find ${pkgs.buildEnv { name = "system-applications"; paths = [ pkgs.google-chrome pkgs.slack pkgs.discord pkgs.obsidian pkgs.postman pkgs.zoom-us pkgs.zotero pkgs.anki-bin ]; }}/Applications -maxdepth 1 -type l | while read -r app; do
      src=$(readlink "$app")
      appname=$(basename "$src")
      ln -s "$src" "$apps_path/$appname"
    done
  '';

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "ghostty"
      "git-credential-manager"
      "hammerspoon"
      "microsoft-auto-update"
      "microsoft-teams"
    ];
  };
}
