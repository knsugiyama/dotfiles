# oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config $env:USERPROFILE\.dotfiles\dist\Windows\config\.mytheme.omp.json | Invoke-Expression
Import-Module PSReadLine
Import-Module -Name Terminal-Icons

# Alias
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias mltp multipass

# Functions
function prj {
    cd $(ghq list -p | fzf)
}

function gch {
    # git checkout $(git for-each-ref --format='%(refname:short)' refs/heads/* | fzf)
    git checkout $(git for-each-ref --format='%(refname:short)' | fzf)
}

function make_deploy() {
#    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
    powershell $env:USERPROFILE\.dotfiles\dist\Windows\deploy.ps1

    $AUTHORIZED_KEYS = Get-Content $env:USERPROFILE\.ssh\multipass.pub

    # 基本の定義
    $MLTP_BASE = Get-Content $env:USERPROFILE\.dotfiles\dist\Common\multipass\cloud-config-base.yaml -Raw | ForEach-Object { $_ -replace '\$AUTHORIZED_KEYS', $AUTHORIZED_KEYS }
    Set-Content -Path "$env:USERPROFILE\multipass_base.yaml" -Force -Value @"
$MLTP_BASE
"@

    # BTP向け
    $MLTP_BTP = Get-Content $env:USERPROFILE\.dotfiles\dist\Common\multipass\cloud-config-btp.yaml -Raw | ForEach-Object { $_ -replace '\$AUTHORIZED_KEYS', $AUTHORIZED_KEYS }
    Set-Content -Path "$env:USERPROFILE\multipass_btp.yaml" -Force -Value @"
$MLTP_BTP
"@

    # ZENN向け
    $MLTP_ZENN = Get-Content $env:USERPROFILE\.dotfiles\dist\Common\multipass\cloud-config-zenn.yaml -Raw | ForEach-Object { $_ -replace '\$AUTHORIZED_KEYS', $AUTHORIZED_KEYS }
    Set-Content -Path "$env:USERPROFILE\multipass_zenn.yaml" -Force -Value @"
$MLTP_ZENN
"@

}

function make_update() {
#    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
    powershell $env:USERPROFILE\.dotfiles\dist\Windows\update.ps1
    make_deploy
}

function launch_multipass {
    param (
        [Parameter(Mandatory=$true)][string]$ProfileName,
        [int]$CpuSize = 2,
        [int]$MemSize = 4,
        [int]$DiskSize = 20
    )
    multipass launch --name ${ProfileName}-vm --cpus ${CpuSize} --mem ${MemSize}G --disk ${DiskSize}G --cloud-init .\multipass_${ProfileName}.yaml 22.04
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
