{ lib, ... }:
let
  # List of directories in .config to be managed by Home Manager
  configDirs = [
    "gh"
    "hammerspoon"
    "lazygit"
    "nvim"
    "sheldon"
    "skk"
    "zed"
  ];
in {
  # Automatically generate xdg.configFile entries for each directory in configDirs
  xdg.configFile = lib.genAttrs configDirs (name: {
    source = ../../.config/${name};
  });
}
