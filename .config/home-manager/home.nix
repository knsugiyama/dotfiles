{ config, pkgs, username, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "knsugiyama";
  home.homeDirectory = if pkgs.stdenv.isDarwin 
                       then "/Users/${username}" 
                       else "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Systemwide install
  # environment.systemPackages = [
  # ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git       # 必須ツール
    ripgrep   # 高速検索
  ];

  # Zsh の設定 (既存の dotfiles との橋渡し)
  # programs.zsh = {
  #   enable = true;
  #   # Nix 管理外の秘密情報（APIキー等）を読み込む設定
  #   initExtra = ''
  #     # 秘密情報の漏洩を防ぐため、Nix 管理外のローカルファイルを読み込む
  #     if [ -f "$HOME/.zshrc.local" ]; then
  #       source "$HOME/.zshrc.local"
  #     fi
  #
  #     # 既存のシェルスクリプト製 dotfiles がある場合、ここで読み込むことも可能です
  #     # source ~/.config/old_dotfiles/zshrc
  #   '';
  # };

  # Git の基本設定 (Nix で管理すると安全)
  programs.git = {
    enable = true;
    userName = "knsugiyama15";
    userEmail = "knsugiyama15@gmail.com"; # 適宜変更してください
    extraConfig = {
      init.defaultBranch = "main";
    };
    # 秘密の Git 設定がある場合は ignores に追加
    ignores = [ ".DS_Store" "*.local" ];
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
