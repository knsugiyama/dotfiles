# Windows Setup Script (idempotent)

$DOTPATH = "$HOME\.dotfiles"

# --- Helpers ---------------------------------------------------------------

# Create a link only when it does not already point to the desired source.
# Never Remove-Item -Recurse on a real directory: abort instead of destroying data.
function Ensure-Link {
    param(
        [string]$Path,      # link location
        [string]$Source,    # link target inside the repo
        [ValidateSet("Junction", "SymbolicLink")] [string]$Kind
    )

    if (Test-Path $Path) {
        $item = Get-Item $Path -Force
        if ($item.LinkType) {
            $current = $item.Target | Select-Object -First 1
            if ($current -eq $Source) {
                Write-Host "  OK: $Path -> $Source" -ForegroundColor DarkGray
                return
            }
            # Wrong link: delete only the reparse point, never the contents
            $item.Delete()
        }
        else {
            Write-Host "  SKIP: $Path exists and is not a link. Back it up and re-run." -ForegroundColor Yellow
            return
        }
    }

    New-Item -ItemType $Kind -Path $Path -Value $Source -ErrorAction Stop | Out-Null
    Write-Host "  LINK: $Path -> $Source" -ForegroundColor Green
}

# --- 1. Install winget packages ---------------------------------------------

Write-Host "Installing Windows packages..." -ForegroundColor Cyan
$apps = @(
    "AutoHotkey.AutoHotkey",
    "Git.Git",
    "GitHub.cli",
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd",
    "starship.starship",
    "junegunn.fzf",
    "Neovim.Neovim",
    "JesseDuffield.lazygit",
    "eza-community.eza",
    "x-motemen.ghq",
    "Anthropic.ClaudeCode",
    "Microsoft.Edit"
)

foreach ($app in $apps) {
    winget install --exact --id $app --silent --accept-package-agreements --accept-source-agreements
}

# PowerShell modules used by the profile
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
}

# --- 2. Create links for configs ---------------------------------------------

Write-Host "Setting up links..." -ForegroundColor Cyan
$CONFIG_HOME = "$HOME\.config"

# If ~/.config itself is already a symlink into the repo, per-directory junctions
# would be self-referential -- everything under it is already shared.
$configItem = if (Test-Path $CONFIG_HOME) { Get-Item $CONFIG_HOME -Force } else { $null }
if ($configItem -and $configItem.LinkType -and (($configItem.Target | Select-Object -First 1) -eq "$DOTPATH\.config")) {
    Write-Host "  OK: $CONFIG_HOME is already a symlink into the repo; skipping per-directory links." -ForegroundColor DarkGray
}
else {
    if (-not (Test-Path $CONFIG_HOME)) { New-Item -ItemType Directory -Path $CONFIG_HOME | Out-Null }
    foreach ($dir in @("lazygit", "gh", "nvim")) {
        Ensure-Link -Path "$CONFIG_HOME\$dir" -Source "$DOTPATH\.config\$dir" -Kind Junction
    }
}

# Git config (~/.gitconfig -> repo). Repo file is the Windows host config;
# macOS/WSL generate theirs via modules/home/git.nix.
Ensure-Link -Path "$HOME\.gitconfig" -Source "$DOTPATH\.gitconfig" -Kind SymbolicLink

# AutoHotkey (symlink, not hardlink: git replaces files on checkout and breaks hardlinks)
$AHK_TARGET_DIR = "$HOME\Documents\AutoHotkey"
if (-not (Test-Path $AHK_TARGET_DIR)) { New-Item -ItemType Directory -Path $AHK_TARGET_DIR | Out-Null }
Ensure-Link -Path "$AHK_TARGET_DIR\AutoHotkey.ahk" -Source "$DOTPATH\hosts\windows\ahk\AutoHotkey.ahk" -Kind SymbolicLink

# --- 3. PowerShell profile ----------------------------------------------------

Write-Host "Setting up PowerShell profile..." -ForegroundColor Cyan
$PROFILE_DIR = Split-Path $PROFILE
if (-not (Test-Path $PROFILE_DIR)) { New-Item -ItemType Directory -Path $PROFILE_DIR | Out-Null }
# Older versions of this script copied the profile; back up the real file so
# Ensure-Link can replace it with a symlink.
if ((Test-Path $PROFILE) -and -not (Get-Item $PROFILE -Force).LinkType) {
    Copy-Item $PROFILE "$PROFILE.bak" -Force
    Remove-Item $PROFILE -Force
    Write-Host "  Existing profile backed up to $PROFILE.bak" -ForegroundColor Yellow
}
try {
    Ensure-Link -Path $PROFILE -Source "$DOTPATH\hosts\windows\Microsoft.PowerShell_profile.ps1" -Kind SymbolicLink
}
catch {
    # Symlink creation needs admin or Developer Mode; fall back to copy
    Write-Host "  Symlink failed; copying profile instead." -ForegroundColor Yellow
    Copy-Item "$DOTPATH\hosts\windows\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
}

Write-Host "Windows setup complete!" -ForegroundColor Green
