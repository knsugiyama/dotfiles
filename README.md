# dotfiles

Declarative macOS environment setup with nix-darwin, Home Manager, and Homebrew.

## Setup

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

## Updating

| Command | What it does |
|---------|--------------|
| `dot-apply` | Apply the locked Nix and Homebrew configuration |
| `dot-update` | Explicitly update Nix and Homebrew packages, then apply |
| `dot-doctor` | Diagnose the repository, managed links, Git, applications, fonts, and Homebrew state |

`dot-apply` does not automatically update Homebrew packages. Routine configuration
application and package updates are intentionally separate.

## Structure

- `darwin.nix`: macOS system and Homebrew configuration
- `home.nix`: User-level Home Manager configuration
- `modules/home/`: Reusable Home Manager modules
- `.config/`: Application configuration linked into `~/.config`
