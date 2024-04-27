$DOTFILES = "$HOME\.dotfiles"
Set-Location $DOTFILES

Write-Host "#####"
Write-Host "symbolic link"
Write-Host "#####"

New-Item -Type SymbolicLink -Path $HOME\.gitconfig -Value $HOME\.dotfiles\.gitconfig -Force
New-Item -Type SymbolicLink -Path $HOME\.config -Value $HOME\.dotfiles\.config -Force
New-Item -Type SymbolicLink -Path $HOME\.vimrc -Value $HOME\.dotfiles\.vimrc -Force

Write-Host "#####"
Write-Host "Microsoft.PowerShell_profile.ps1"
Write-Host "#####"
New-Item -Type SymbolicLink -Path $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $HOME\.dotfiles\dist\Windows\Microsoft.PowerShell_profile.ps1 -Force

Write-Host "#####"
Write-Host 'replace wsl.conf.'
Write-Host "#####"

$wslConf = @'
[boot]
systemd=true
[automount]
enabled = true
options = "metadata,umask=22"
mountFsTab = false
'@

wsl.exe -d Ubuntu --user root --exec bash -c "rm -f /etc/wsl.conf || true && echo '$wslConf' >/etc/wsl.conf"
wsl.exe --shutdown

Write-Host "#####"
Write-Host 'export package files'
Write-Host "#####"
winget export -o "$DOTFILES\dist\Windows\init\winget-app-list.json" -s winget --accept-source-agreements
scoop export > "$DOTFILES\dist\Windows\init\scoopfile.json"

