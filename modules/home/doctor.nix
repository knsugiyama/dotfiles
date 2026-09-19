{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dot-doctor";
      runtimeInputs = with pkgs; [
        git
        gnugrep
        jq
      ];
      text = builtins.readFile ../../scripts/dot-doctor.sh;
    })
  ];
}
