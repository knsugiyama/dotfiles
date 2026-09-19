#!/usr/bin/env bash

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting macOS dotfiles bootstrap...${NC}"

# Git is provided by the Xcode Command Line Tools on a fresh macOS install.
if ! command -v git &> /dev/null; then
    echo -e "${BLUE}Git not found. Installing Xcode Command Line Tools...${NC}"
    xcode-select --install
    echo "Re-run this script after the installation completes."
    exit 0
fi

if ! command -v nix &> /dev/null; then
    echo -e "${BLUE}Nix not found. Installing Nix...${NC}"
    curl -L https://nixos.org/nix/install | sh -s -- --daemon

    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
fi

DOTPATH="${HOME}/.dotfiles"
if [ ! -f "flake.nix" ]; then
    if [ -d "$DOTPATH" ]; then
        echo -e "${BLUE}Entering existing dotfiles directory at $DOTPATH...${NC}"
        cd "$DOTPATH"
    else
        echo -e "${BLUE}Cloning dotfiles to $DOTPATH...${NC}"
        git clone --branch develop https://github.com/knsugiyama/dotfiles.git "$DOTPATH"
        cd "$DOTPATH"
    fi
fi

mkdir -p ~/.config/nix
if ! grep -q "experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    echo -e "${BLUE}Enabled Nix Flakes.${NC}"
fi

echo -e "${BLUE}Running nix-darwin setup...${NC}"
nix run nix-darwin -- switch --flake .#macos

echo -e "${GREEN}Bootstrap complete! Please restart your shell.${NC}"
