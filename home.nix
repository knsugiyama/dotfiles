{ config, pkgs, lib, ... }:

let
  # --- ユーザー設定 ---
  username = "knsugiyama"; 
  
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11"; 

  programs.home-manager.enable = true;

  # --- パッケージのインストール ---
  home.packages = with pkgs; [
    bat
    fzf
    zoxide
    ripgrep
    eza
    nerdfonts # フォントもNixで管理可能
    (python3.withPackages (ps: with ps; [ google-generativeai ]))
  ];

  # --- Zsh の設定 ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      l = "eza -lh --icons";
      ls = "eza";
      ll = "eza -l";
      g = "gemini-cli";
      nix-switch = if pkgs.stdenv.isDarwin 
                   then "home-manager switch --flake ~/.dotfiles#user@mac"
                   else "home-manager switch --flake ~/.dotfiles#user@wsl";
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };

  # --- Starship の設定 (移管・改善版) ---
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = true;

      # プロンプトのレイアウト設定
      format = lib.concatStrings [
        "$os"
        "$sudo"
        "$custom"
        "$direnv"      # Nix/Direnv 環境の表示
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$git_metrics"
        "$fill"        # 右端まで線を引く
        "$lua"
        "$nodejs"
        "$rust"
        "$python"      # Gemini 開発用
        "\n$character"
      ];

      right_format = "$cmd_duration$time";

      # 各モジュールの詳細設定
      os = {
        disabled = false;
        format = "[](fg:#89b4fa)[$symbol]($style)[](fg:#89b4fa)";
        style = "fg:#313244 bg:#89b4fa";
        symbols = {
          Macos = "  ";
          Linux = " 󰌽 ";
          Ubuntu = "  ";
          Debian = "  ";
        };
      };

      sudo = {
        disabled = false;
        symbol = " 󰿆 sudo";
        format = "[](fg:#eba0ac)[$symbol]($style)[](fg:#eba0ac)";
        style = "bold fg:#313244 bg:#eba0ac";
      };

      directory = {
        truncation_length = 6;
        truncation_symbol = " ";
        truncate_to_repo = false;
        home_symbol = "~";
        read_only = " 󰌾 ";
        format = "[](fg:#b4befe)[$path]($style)[$read_only]($read_only_style)[](fg:#b4befe)";
        style = "bold fg:#313244 bg:#b4befe";
        read_only_style = "bold fg:#313244 bg:#b4befe";
      };

      git_branch = {
        symbol = "  ";
        truncation_length = 4;
        style = "bold fg:#89dceb bg:#45475a";
        format = "[](fg:#45475a)[$symbol$branch(:$remote_branch)]($style)";
      };

      git_status = {
        style = "bold fg:#eba0ac bg:#45475a";
        format = "[  ](fg:#89dceb bg:#45475a)[$all_status$ahead_behind]($style)";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        modified = "!\${count}";
      };

      git_metrics = {
        disabled = false;
        added_style = "bold fg:#a6e3a1 bg:#45475a";
        deleted_style = "bold fg:#89b4fa bg:#45475a";
        format = "[  ](fg:#89dceb bg:#45475a)[+$added]($added_style)[-$deleted]($deleted_style)[](fg:#45475a)";
      };

      fill = {
        symbol = "─";
        style = "fg:#89b4fa";
      };

      # Gemini 開発 (Python)
      python = {
        symbol = "🐍 ";
        format = "[](fg:#8093fd)[ $symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style)[](fg:#8093fd)";
        style = "bold fg:#313244 bg:#8093fd";
        pyenv_version_name = false;
      };

      direnv = {
        disabled = false;
        symbol = "󱄅 ";
        format = "[](fg:#fab387)[$symbol$loaded/$allowed]($style)[](fg:#fab387)";
        style = "bold fg:#313244 bg:#fab387";
      };

      rust = {
        symbol = "󱘗 ";
        format = "[](fg:#eba0ac)[ $symbol($version)]($style)[](fg:#eba0ac)";
        style = "bold fg:#313244 bg:#eba0ac";
      };

      nodejs = {
        symbol = " ";
        format = "[$symbol($version)]($style)";
        style = "bold fg:#313244 bg:#a6e3a1";
      };

      cmd_duration = {
        min_time = 100;
        format = "[󰞌 $duration ](fg:#f9e2af)";
      };

      time = {
        disabled = false;
        format = "[ $time](bold fg:#6c7086)";
        time_format = "%T";
      };

      character = {
        success_symbol = "[❯](bold #74c7ec)[❯](bold #b4befe)[❯](bold #89b4fa)";
        error_symbol = "[❯](bold #eba0ac)[❯](bold #f38ba8)[❯](bold #f17497)";
      };
    };
  };

  # --- Ghostty の設定 ---
  xdg.configFile."ghostty/config" = lib.mkIf pkgs.stdenv.isDarwin {
    text = ''
      theme = dark-fusion
      font-family = "JetBrainsMono Nerd Font"
      font-size = 14
      cursor-style = block
      macos-option-as-alt = true
    '';
  };

  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "your@example.com";
  };
}
