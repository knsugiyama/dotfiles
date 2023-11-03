Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

oh-my-posh init pwsh --config $HOME\.dotfiles\dist\Windows\config\.mytheme.omp.json | Invoke-Expression
Import-Module PSReadLine
Import-Module -Name Terminal-Icons

############
# 環境変数のデフォルト設定
############
$env:XDG_CONFIG_HOME = $HOME + '\.config'
$env:XDG_DATA_HOME = $HOME + '\.local\share'
$env:XDG_CACHE_HOME = $HOME + '\.local\cache'
$env:XDG_STATE_HOME = $HOME + '\.local\state'

############
# Alias
############
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias lg lazygit

############
# Functions
############
function prj {
    Set-Location $(ghq list -p | fzf)
}

function gch {
    git checkout $(git for-each-ref --format='%(refname:short)' | fzf)
}

function make {
    param ([string]$param)
    if ($param -eq "deploy") {
        deploy
    } elseif ($param -eq "update") {
        update
    }
}

function script:deploy {
    Start-Process powershell.exe ("-noprofile -command Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process; " + $HOME + "\.dotfiles\dist\Windows\deploy.ps1") -Verb runas -wait
    reload
}

function script:update {
    powershell $HOME\.dotfiles\dist\Windows\update.ps1
    deploy
}

function reload {
    . $Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
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
