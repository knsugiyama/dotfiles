{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = import ./alias.nix;

    history = {
      size = 30000;
      save = 30000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      share = true;
    };

    initExtraFirst = ''
      # Nix-managed Zsh configuration
    '';

    initExtra = ''
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
