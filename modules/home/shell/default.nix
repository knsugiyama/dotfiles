{ pkgs, lib, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = import ./alias.nix;

    envExtra = ''
      [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      if [ -e /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

    history = {
      size = 30000;
      save = 30000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    initContent = ''
      setopt auto_param_keys
      setopt extended_history
      setopt hist_allow_clobber
      setopt hist_fcntl_lock
      setopt hist_no_functions
      setopt hist_no_store
      setopt hist_reduce_blanks
      setopt hist_save_no_dups
      setopt hist_verify

      export HISTORY_IGNORE="(cd|pwd|l[sal])"

      # Functions
      ${import ./functions.nix}

      # local config
      if [ -f "$HOME/.zshrc.local" ]; then
        source "$HOME/.zshrc.local"
      fi
    '';

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
