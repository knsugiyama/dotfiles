Write-Host "#####"
Write-Host "symbolic link"
Write-Host "#####"

New-Item -Type SymbolicLink -Path $HOME\.gitconfig -Value $HOME\.dotfiles\.gitconfig -Force
New-Item -Type SymbolicLink -Path $HOME\.config -Value $HOME\.dotfiles\.config -Force

Write-Host "#####"
Write-Host "Microsoft.PowerShell_profile.ps1"
Write-Host "#####"
New-Item -Type SymbolicLink -Path $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $HOME\.dotfiles\dist\Windows\Microsoft.PowerShell_profile.ps1 -Force
