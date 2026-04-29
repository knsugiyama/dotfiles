{
  description = "Mac と WSL2 で共有する Nix 開発環境の設計図";

  # 外部リポジトリの定義
  inputs = {
    # 最新のパッケージリポジトリ
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # ホームディレクトリ管理ツール (Home Manager)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ghostty ターミナルの最新版を取得
    ghostty.url = "github:ghostty-org/ghostty";
  };

  # 環境の構築ロジック
  outputs = { self, nixpkgs, home-manager, ghostty, ... }:
    let
      # 共通の引数をモジュールに渡すためのヘルパー
      extraSpecialArgs = { inherit ghostty; };
    in
    {
      homeConfigurations = {
        # --- Mac 用の設定 (Apple Silicon) ---
        # 実行コマンド: nix run home-manager -- switch --flake ~/.dotfiles#user@mac
        "user@mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Intel Mac の場合は x86_64-darwin に変更
          modules = [
            ./home.nix
            {
              # Mac 専用の追加パッケージ（Ghostty）
              home.packages = [
                ghostty.packages.aarch64-darwin.default
              ];
            }
          ];
          inherit extraSpecialArgs;
        };

        # --- WSL2 用の設定 (Ubuntu等) ---
        # 実行コマンド: nix run home-manager -- switch --flake ~/.dotfiles#user@wsl
        "user@wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
            # WSL2 では Windows 側のターミナルを使うため、Ghostty はインストールしない
          ];
          inherit extraSpecialArgs;
        };
      };
    };
}
