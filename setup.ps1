Write-Host "#####"
Write-Host "Set-ExecutionPolicy を RemoteSigned に変更"
Write-Host "#####"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Write-Host "#####"
Write-Host "git clone"
Write-Host "#####"

git clone https://github.com/knsugiyama/dotfiles.git $env:USERPROFILE\.dotfiles

Write-Host "#####"
Write-Host "run setup script"
Write-Host "#####"

.$env:USERPROFILE\.dotfiles\dist\Windows\setup.ps1
