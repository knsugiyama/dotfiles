# Microsoft.PowerShell_profile.ps1

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Import-Module PSReadLine
Import-Module -Name Terminal-Icons

# Alias
Set-Alias -Name v -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name g -Value git

# Prompt (Starship if installed)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# Functions
## winget で導入したパッケージを一括更新
function dot-up {
    winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
}

function prj {
    $repo = ghq list --full-path | fzf
    if ($repo) {
        Set-Location $repo
    }
}

# psreadline
## Fish風の自動補完
Set-PSReadLineOption -PredictionSource History
# (optional) Ctrl+f 入力で前方1単語進む : 補完の確定に使う用
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
## 重複したリストを残さない
Set-PSReadlineOption -HistoryNoDuplicates
## 区切り文字
Set-PSReadLineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'`" !?@#$%&_<>「」（）『』『』［］、，。：；／"
# zsh風のtab補完
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Keymap
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
