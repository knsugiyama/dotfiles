# dotfiles (Nix-native)

Modular Nix configuration for macOS (nix-darwin) and WSL2 (Home Manager).

## Setup

For a fresh installation on macOS or Linux, you can run the bootstrap script directly:

```bash
curl -sL https://raw.githubusercontent.com/knsugiyama/dotfiles/main/bootstrap.sh | bash
```

Alternatively, clone and run manually:

```bash
git clone https://github.com/knsugiyama/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

### Windows (Native)

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
git clone https://github.com/knsugiyama/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
.\setup.ps1
```

The script will:
1. Install essential utilities via `winget` (AutoHotkey, Git, Starship, etc.)
2. Link your shared `.config` directories (lazygit, gh) and AutoHotkey scripts to the Windows host.
3. Configure your PowerShell profile.

## Structure

- `hosts/`: Host-specific configurations (macos, wsl2)
- `modules/`: Shared Home Manager modules
- `.config/`: Application configuration files managed by Home Manager
