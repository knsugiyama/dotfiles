{ pkgs, lib, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Using relative path to home directory (triggers a deprecation warning in some HM versions,
    # but currently the only functional way to place zsh config in .config/zsh via HM module)
    dotDir = ".config/zsh";

    shellAliases = import ./alias.nix;

    envExtra = ''
      # Standard XDG paths
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_CACHE_HOME="$HOME/.cache"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_STATE_HOME="$HOME/.local/state"

      # PATH configuration
      [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

      # External tool integrations
      if [ -e /opt/homebrew/bin/brew ]; then
        eval $(/opt/homebrew/bin/brew shellenv)
      fi
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    '';

    history = {
      size = 30000;
      save = 30000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      share = true;
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Nix-managed Zsh configuration
      '')
      ''
        # optsets from conf.zsh
        setopt auto_param_keys
        setopt extended_history
        setopt hist_allow_clobber
        setopt hist_fcntl_lock
        setopt hist_find_no_dups
        setopt hist_ignore_all_dups
        setopt hist_ignore_dups
        setopt hist_ignore_space
        setopt hist_no_functions
        setopt hist_no_store
        setopt hist_reduce_blanks
        setopt hist_save_no_dups
        setopt hist_verify
        setopt inc_append_history_time
        setopt share_history

        # env from env.zsh
        export EDITOR="nvim"
        export VISUAL="nvim"
        export HISTORY_IGNORE="(cd|pwd|l[sal])"

        # Functions
        ${import ./functions.nix}

        # local config
        if [ -f "$HOME/.zshrc.local" ]; then
          source "$HOME/.zshrc.local"
        fi
      ''
    ];

    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
