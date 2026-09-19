{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "knsugiyama15";
        email = "knsugiyama15@gmail.com";
      };
      init.defaultBranch = "main";
      core = {
        editor = "zed --wait";
        quotepath = false;
        autocrlf = false;
        filemode = false;
      };
      color.ui = "auto";
      help.autocorrect = 1;
      push.default = "simple";
      fetch.prune = true;
      pull.rebase = false;
      ghq.root = "~/src";
    };
    signing.format = null;
    ignores = [ ".DS_Store" "*.local" ];
  };
}
