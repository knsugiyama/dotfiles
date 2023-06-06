# gpeditから、ユーザーにシンボリック作成権限を付与する必要あり
# Computer configuration → Windows Settings → Security Settings → Local Policies → User Rights Assignment → Create symbolic links
Write-Host "#####"
Write-Host "symbolic link"
Write-Host "#####"

New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitconfig -Value $env:USERPROFILE\.dotfiles\.gitconfig -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.tigrc -Value $env:USERPROFILE\.dotfiles\.tigrc -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.config\wezterm -Value $env:USERPROFILE\.dotfiles\.config\wezterm -Force

Write-Host "#####"
Write-Host "Microsoft.PowerShell_profile.ps1"
Write-Host "#####"
New-Item -Type SymbolicLink -Path $Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $env:USERPROFILE\.dotfiles\dist\Windows\Microsoft.PowerShell_profile.ps1 -Force
