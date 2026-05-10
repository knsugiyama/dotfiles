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
        editor = "nvim";
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
    includes = [
      { path = "~/.dotfiles/.gitconfig_credential"; }
    ];
    ignores = [ ".DS_Store" "*.local" ];
  };
}
