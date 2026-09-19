# dotfiles

Cross-platform environment setup: macOS (nix-darwin), WSL2 (Home Manager), and native Windows (PowerShell script).

## Setup

### macOS / WSL2

For a fresh installation, run the bootstrap script directly:

```bash
curl -sL https://raw.githubusercontent.com/knsugiyama/dotfiles/develop/bootstrap.sh | bash
```

Alternatively, clone and run manually:

```bash
git clone --branch develop https://github.com/knsugiyama/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

> Note: WSL2 では Nix のマルチユーザーインストール (`--daemon`) に systemd が必要です。
> `/etc/wsl.conf` に `[boot] systemd=true` を設定してから実行してください。

### Windows (Native)

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
git clone --branch develop https://github.com/knsugiyama/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
.\setup.ps1
```

The script is idempotent and will:

1. Install packages via `winget` (Git, gh, Neovim, ripgrep, fzf, ghq, lazygit, Starship, AutoHotkey, etc.)
2. Symlink configs (`.config` directories, `~/.gitconfig`, AutoHotkey scripts, PowerShell profile) into this repo.

## Updating

| OS | Command | What it does |
|----|---------|--------------|
| macOS / WSL2 | `dot-apply` | ロック済みのバージョンで設定を再適用 |
| macOS / WSL2 | `dot-update` | NixとHomebrewのパッケージを明示的に更新して適用 |
| Windows | `dot-up` | `winget upgrade --all` — winget パッケージを一括更新 |

macOSでは通常の `dot-apply` でHomebrewの自動更新を行いません。日常の再適用と、バージョン更新を分離しています。

## Structure

- `hosts/`: Host-specific configurations (`macos`, `wsl2`, `windows`)
- `modules/`: Shared Home Manager modules (shell, git, tmux, starship, ...)
- `.config/`: Application configuration files symlinked to `~/.config`
