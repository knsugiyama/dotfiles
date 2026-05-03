#!/usr/bin/env bash

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting dotfiles bootstrap...${NC}"

# 0. Ensure git is available (needed for cloning)
if ! command -v git &> /dev/null; then
    echo -e "${BLUE}Git not found. Installing Git...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        xcode-select --install || true
    else
        sudo apt-get update && sudo apt-get install -y git
    fi
fi

# 1. Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo -e "${BLUE}Nix not found. Installing Nix...${NC}"
    curl -L https://nixos.org/nix/install | sh -s -- --daemon

    # Source nix profile for the current session
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # Also add to current PATH if not already there
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
fi

# 2. Clone or Enter Repository
DOTPATH="${HOME}/.dotfiles"
if [ ! -f "flake.nix" ]; then
    if [ -d "$DOTPATH" ]; then
        echo -e "${BLUE}Entering existing dotfiles directory at $DOTPATH...${NC}"
        cd "$DOTPATH"
    else
        echo -e "${BLUE}Cloning dotfiles to $DOTPATH...${NC}"
        git clone https://github.com/knsugiyama/dotfiles.git "$DOTPATH"
        cd "$DOTPATH"
    fi
fi

# 3. Enable Flakes (if not already enabled)
mkdir -p ~/.config/nix
if ! grep -q "experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    echo -e "${BLUE}Enabled Nix Flakes.${NC}"
fi

# 4. Determine system type and run initial switch
OS="$(uname -s)"
echo -e "${BLUE}Detected OS: $OS${NC}"

if [ "$OS" = "Darwin" ]; then
    echo -e "${BLUE}Running nix-darwin setup...${NC}"
    nix run nix-darwin -- switch --flake .#macos
elif [ "$OS" = "Linux" ]; then
    echo -e "${BLUE}Running Home Manager setup...${NC}"
    # Note: On some Linux distros, we might need to ensure nix-command is ready
    nix run home-manager -- switch --flake .#wsl2
else
    echo -e "Unsupported OS: $OS"
    exit 1
fi
echo -e "${GREEN}Bootstrap complete! Please restart your shell.${NC}"
