{ ... }: {
  programs.git.settings = {
    enable = true;
    userName = "knsugiyama15";
    userEmail = "knsugiyama15@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
    ignores = [ ".DS_Store" "*.local" ];
  };
}
