Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Import-Module PSReadLine
Import-Module -Name Terminal-Icons

Invoke-Expression (&starship init powershell)

############
# asdf 用
############
if ((Test-Path $HOME\.asdf)) {
    . "$HOME/.asdf/asdf.ps1"
}

############
# Alias
############
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias lg lazygit
Set-Alias wslhome open-wsl

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
    }
    elseif ($param -eq "update") {
        update
    }
    elseif ($param -eq "export") {
        export
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

function script:export {
    winget export -o $HOME\.dotfiles\dist\Windows\init\winget-app-list.json -s winget --accept-source-agreements
    scoop export > $HOME\.dotfiles\dist\Windows\init\scoopfile.json
}

function reload {
    . $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
}

function open-wsl {
    wsl --cd "~"
}
function create_multipass_vm {
    param([string]$arg1, [string]$arg2)
    $fileName = $arg1
    $vmName = $arg2
    if ($fileName -eq $null) {
        $fileName = 'myvm.yml'
    }
    if ($vmName -eq $null) {
        $vmName = 'myvm'
    }
    multipass launch --cpus 2 --disk 36G --memory 4G --cloud-init $fileName --name $vmName --timeout 1800
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
