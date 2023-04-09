Write-Host "#####"
Write-Host "update"
Write-Host "#####"

$CURRENTPATH = Get-Location
$DOTFILES = "$env:USERPROFILE\.dotfiles"

Set-Location $DOTFILES

if (Test-Path ("$DOTFILES\.git")) {
    git checkout master
    git pull
}
else {
    git init
    git remote add origin https://github.com/knsugiyama/dotfiles.git
    git fetch origin
    git checkout --force origin/master
}

Set-Location $CURRENTPATH

winget upgrade --all --accept-source-agreements
Update-Module

# replace wsl.conf
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
