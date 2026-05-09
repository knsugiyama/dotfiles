# Windows Setup Script

$DOTPATH = "$HOME\.dotfiles"

# 1. Install Winget packages
Write-Host "Installing Windows packages..." -ForegroundColor Cyan
$apps = @(
    "AutoHotkey.AutoHotkey", # Utility
    "Git.Git",
    "cli.cli", # GitHub CLI
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd",
    "starship.starship",
    "junegunn.fzf",
    "Anthropic.ClaudeCode",
    "Microsoft.Edit"
)

foreach ($app in $apps) {
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}

# 2. Create Symlinks for Configs
Write-Host "Setting up symlinks..." -ForegroundColor Cyan
$CONFIG_HOME = "$HOME\.config"
if (!(Test-Path $CONFIG_HOME)) { New-Item -ItemType Directory -Path $CONFIG_HOME }

# Symlink shared .config folders
$configDirs = @("lazygit", "gh")
foreach ($dir in $configDirs) {
    $target = "$CONFIG_HOME\$dir"
    $source = "$DOTPATH\.config\$dir"
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    New-Item -ItemType Junction -Path $target -Value $source
}

# Symlink AutoHotkey
$AHK_TARGET_DIR = "$HOME\Documents\AutoHotkey"
if (!(Test-Path $AHK_TARGET_DIR)) { New-Item -ItemType Directory -Path $AHK_TARGET_DIR }
$target = "$AHK_TARGET_DIR\AutoHotkey.ahk"
$source = "$DOTPATH\hosts\windows\ahk\AutoHotkey.ahk"
if (Test-Path $target) { Remove-Item $target -Force }
New-Item -ItemType HardLink -Path $target -Value $source

# 3. PowerShell Profile
Write-Host "Setting up PowerShell profile..." -ForegroundColor Cyan
$PROFILE_DIR = Split-Path $PROFILE
if (!(Test-Path $PROFILE_DIR)) { New-Item -ItemType Directory -Path $PROFILE_DIR }
Copy-Item "$DOTPATH\hosts\windows\Microsoft.PowerShell_profile.ps1" $PROFILE -Force

Write-Host "Windows setup complete!" -ForegroundColor Green
