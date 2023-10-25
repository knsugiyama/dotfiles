Write-Host "#####"
Write-Host "Set-ExecutionPolicy を RemoteSigned に変更"
Write-Host "#####"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# Write-Host "#####"
# Write-Host "最新のwingetをインストール"
# Write-Host "#####"

Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
Add-AppxPackage -Path winget.msixbundle
Remove-Item winget.msixbundle

# Write-Host "#####"
# Write-Host "scoop を install"
# Write-Host "#####"

irm get.scoop.sh | iex
scoop bucket add extras

Write-Host "#####"
Write-Host "git clone"
Write-Host "#####"

winget install Git.Git
git clone https://github.com/knsugiyama/dotfiles.git $env:USERPROFILE\.dotfiles

Write-Host "#####"
Write-Host "run setup script"
Write-Host "#####"

.$env:USERPROFILE\.dotfiles\dist\Windows\setup.ps1
