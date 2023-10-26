Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

$env:XDG_CONFIG_HOME = $HOME + '\.config'
$env:XDG_DATA_HOME = $HOME + '\.local\share'
$env:XDG_CACHE_HOME = $HOME + '\.local\cache'
$env:XDG_STATE_HOME = $HOME + '\.local\state'

Write-Host "############"
Write-Host "wingetによるアプリインストールを実施"
Write-Host "############"

winget import $HOME\.dotfiles\dist\Windows\init\winget-app-list.json

# AutoHotkeyのみ、インストール先の指定が必要なので、単独で実行
Write-Output $HOME\.dotfiles\dist\Windows\config\ahk | winget install AutoHotkey.AutoHotkey

# .configフォルダを作成する
if(!(Test-Path $HOME\.config)){
  mkdir $HOME\.config
}

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

Write-Host "#####"
Write-Host "scoop install"
Write-Host "#####"
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop bucket add extras
