{ ... }: {
  programs.git = {
    enable = true;
    # Use the new settings format to avoid warnings in recent Home Manager versions
    settings = {
      user = {
        name = "knsugiyama15";
        email = "knsugiyama15@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
    signing.format = null;
    ignores = [ ".DS_Store" "*.local" ];
  };
}
