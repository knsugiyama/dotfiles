{ pkgs, ... }: {
  home.packages = with pkgs; [
    anki-bin
    discord
    google-chrome
    obsidian
    postman
    slack
    zoom-us
    zotero
  ];
}
