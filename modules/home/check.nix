{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dot-check";
      runtimeInputs = with pkgs; [
        git
        jq
        neovim
        nix
        starship
      ];
      text = builtins.readFile ../../scripts/dot-check.sh;
    })
  ];
}
