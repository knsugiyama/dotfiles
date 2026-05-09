{ config, lib, ... }:
let
  # Cross-platform config directories to symlink as live editable paths.
  configDirs = [
    "gh"
    "lazygit"
    "nvim"
    "sheldon"
    "skk"
  ];
in {
  xdg.configFile = lib.genAttrs configDirs (name: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/${name}";
  });
}
