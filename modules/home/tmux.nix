{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    historyLimit = 100000;
    terminal = "screen-256color";

    # tpm を使わず nixpkgs のプラグインで管理する(継続保存は continuum)
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-save-interval '15'
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      ##### 基本 #####
      bind-key -T edit-mode-vi WheelUpPane send-keys -X scroll-up
      bind-key -T edit-mode-vi WheelDownPane send-keys -X scroll-down
      set -g allow-rename off          # 勝手にウィンドウ名が変わるのを防ぐ

      ##### クリップボード（OSC 52） #####
      # tmux→端末へコピー（デフォルト external だが明示しておく）
      set -s set-clipboard external

      # Copy-mode の y で「tmuxバッファ + システムクリップボード」に送る
      # macOS
      if-shell 'uname | grep -qi darwin' 'bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"'
      # Linux（xclip が入っている前提）
      if-shell 'uname | grep -qi linux'  'bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -i -sel clipboard"'

      ##### 画面分割と移動（現在ディレクトリを引き継ぐ） #####
      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      ##### リロード & 新規ウィンドウ #####
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded"
      bind c new-window -c "#{pane_current_path}"

      ##### ステータス #####
      set -g status-style bg=black,fg=white
      set -g status-left "#[fg=green]#H #[fg=black]• #[fg=green]#(uname -r | cut -c 1-6)#[default]"
      set -g status-right "#[fg=green]#(cut -d ' ' -f 1-3 /proc/loadavg)#[default]"
    '';
  };
}
