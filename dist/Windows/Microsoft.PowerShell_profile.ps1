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

function create_vm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "cloud-init の yml ファイルを指定してください (例: myvm)")]
        [string]$filePath,
        [Parameter(Mandatory = $true, HelpMessage = "設定するvm名を指定してください (例: myvm)")]
        [string]$vmName
    )

    # 仮想環境の名前を設定
    $INSTANCE_NAME = $vmName
    # ssh 接続設定用に仮想環境名ディレクトリを切る
    $WORKSPACE = "$HOME\.ssh\multipass\$INSTANCE_NAME"

    _create_ssh_key -INSTANCE_NAME $INSTANCE_NAME -WORKSPACE $WORKSPACE
    _create_multipass_vm -filePath $filePath -vmName $INSTANCE_NAME

    multipass exec $vmName --working-directory "/home/ubuntu/.ssh" -- bash -c "echo '$(Get-Content $WORKSPACE\$INSTANCE_NAME.pub)' | tee -a authorized_keys"
}

function _create_ssh_key {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true")]
        [string]$INSTANCE_NAME,
        [Parameter(Mandatory = $true")]
        [string]$WORKSPACE
    )

    New-Item -ItemType Directory -Force -Path "$WORKSPACE"

    # 仮想環境名の鍵生成
    ssh-keygen -t ed25519 -N "" -f "$WORKSPACE\$INSTANCE_NAME"

    # config ファイル作成
    New-Item -ItemType File -Path "$WORKSPACE\config"

    # 設定内容のブロックを定義 (ヒアドキュメント使用)
    $configBlock = @"
Host $($INSTANCE_NAME)
    HostName $($INSTANCE_NAME).local
    User ubuntu
    IdentityFile ~/.ssh/multipass/$($INSTANCE_NAME)/$($INSTANCE_NAME)
    IdentitiesOnly yes
    ServerAliveInterval 60
    LocalForward 8080 127.0.0.1:8080
"@

    # ファイルに設定内容を追記
    try {
        Add-Content -Path "$WORKSPACE\config" -Value $configBlock -Encoding utf8 -ErrorAction Stop
    }
    catch {
        Write-Error "ファイルへの書き込みに失敗しました: $($_.Exception.Message)"
    }

    # ~/.ssh/config への Include 行追記処理
    $CONFIG_FILE = "$HOME\.ssh\config"
    $INCLUDE_LINE = "Include ~\.ssh\multipass\$INSTANCE_NAME\config"

    # ~/.ssh/config が存在するか確認、なければ作成
    if (!(Test-Path -Path $CONFIG_FILE -PathType Leaf)) {
        New-Item -ItemType File -Path $CONFIG_FILE -Force
    }

    # ~/.ssh/config に Include 行を追記
    Add-Content -Path $CONFIG_FILE -Value "$INCLUDE_LINE`n" -Encoding utf8 -ErrorAction Stop

}

function _create_multipass_vm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "cloud-init の yml ファイルを指定してください (例: myvm)")]
        [string]$filePath,
        [Parameter(Mandatory = $true, HelpMessage = "設定するvm名を指定してください (例: myvm)")]
        [string]$vmName
    )
    multipass launch --cpus 2 --disk 36G --memory 4G --cloud-init $filePath --name $vmName --timeout 1800
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
