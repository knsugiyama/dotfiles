Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Write-Host "############"
Write-Host "wingetによるアプリインストールを実施"
Write-Host "############"
winget import -i "$HOME\.dotfiles\dist\Windows\init\winget-app-list.json" --ignore-unavailable --no-upgrade --accept-package-agreements --accept-source-agreements

# AutoHotkeyのみ、インストール先の指定が必要なので、単独で実行
# Write-Output $HOME\.dotfiles\dist\Windows\config\ahk | winget install AutoHotkey.AutoHotkey

# .configフォルダを作成する
if(!(Test-Path $HOME\.config)){
  mkdir $HOME\.config
}

Write-Host "############"
Write-Host "set system env"
Write-Host "############"
Start-Process powershell.exe ("-noprofile -command Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process; " + $HOME + "\.dotfiles\dist\Windows\init\setSystemEnv.ps1") -Verb runas -wait

Write-Host "############"
Write-Host "install powershell modules"
Write-Host "############"
.$HOME\.dotfiles\dist\Windows\init\modules.ps1

Write-Host "############"
Write-Host "install wsl(ubuntu)"
Write-Host "############"
wsl --install -d Ubuntu

Write-Host "############"
Write-Host "deploy"
Write-Host "############"
Start-Process powershell.exe ("-noprofile -command Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process; " + $HOME + "\.dotfiles\dist\Windows\deploy.ps1") -Verb runas -wait
. $Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# Write-Host "#####"
# Write-Host "scoop install"
# Write-Host "#####"

# Invoke-RestMethod get.scoop.sh | Invoke-Expression
# scoop bucket add extras
# scoop import "$HOME\.dotfiles\dist\Windows\init\scoopfile.json"

git update-index --assume-unchanged $HOME/.dotfiles/.gitconfig_credential
