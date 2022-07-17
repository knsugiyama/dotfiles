Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Write-Host "#####"
Write-Host "wingetをインストール"
Write-Host "#####"

Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile winget.msixbundle -UseBasicParsing
Add-AppxPackage -Path winget.msixbundle
Remove-Item winget.msixbundle

winget install -e -id Git.Git

Write-Host "#####"
Write-Host "scoopのインストールチェック"
Write-Host "#####"

$scoopdir = $HOME + "\scoop"
if (Test-Path $scoopdir) {
    Write-Host "すでにインストールされています。"
}
else {
    Write-Host "scoop をインストールします。"
    Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
    set-executionpolicy unrestricted -s cu
    Write-Host "インストールが完了しました。"
}

Write-Host "#####"
Write-Host "profile.ps1を追加"
Write-Host "#####"

$PS1PROFILE_DIR = "$env:USERPROFILE\Documents\PowerShell"

if (Test-Path ("$PS1PROFILE_DIR")) {
    Remove-Item $PS1PROFILE_DIR\Profile.ps1 -Recurse -Force
}
else {
    mkdir $PS1PROFILE_DIR
}

New-Item -Type SymbolicLink -Path $PS1PROFILE_DIR\Profile.ps1 -Value $env:USERPROFILE\.dotfiles\dist\Windows\Profile.ps1
# プロファイルを読み込み
. $env:USERPROFILE\.dotfiles\dist\Windows\Profile.ps1

Write-Host "############"
Write-Host "scoopによるアプリインストールを実施"
Write-Host "############"

scoop bucket add extras
scoop bucket add versions

$f = (Get-Content $env:USERPROFILE\.dotfiles\dist\Windows\init\scoop-packages) -as [string[]]
$i=1

foreach ($l in $f) {
    scoop install $l
    $i++
}

Write-Host "############"
Write-Host "wingetによるアプリインストールを実施"
Write-Host "############"

$f = (Get-Content $env:USERPROFILE\.dotfiles\dist\Windows\init\winget-packages) -as [string[]]
$i=1

foreach ($l in $f) {
    winget install -e --id $l
    $i++
}

Write-Host "############"
Write-Host "font settings"
Write-Host "############"
.$env:USERPROFILE\.dotfiles\dist\Windows\init\font.ps1

Write-Host "############"
Write-Host "install powershell modules"
Write-Host "############"
.$env:USERPROFILE\.dotfiles\dist\Windows\init\modules.ps1
