Write-Host "#####"
Write-Host "update"
Write-Host "#####"

$CURRENTPATH = Get-Location
$DOTFILES = "$HOME\.dotfiles"

Set-Location $DOTFILES

if (Test-Path ("$DOTFILES\.git")) {
    git pull
}
else {
    git init
    git remote add origin https://github.com/knsugiyama/dotfiles.git
    git fetch origin
    git checkout --force origin/main
}

Set-Location $CURRENTPATH

winget upgrade --all --accept-source-agreements --accept-package-agreements --uninstall-previous
scoop update --all
Update-Module
