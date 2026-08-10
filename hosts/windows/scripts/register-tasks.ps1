# register-tasks.ps1 — タスクスケジューラへ登録する
#
#   .\hosts\windows\scripts\register-tasks.ps1              # 登録
#   .\hosts\windows\scripts\register-tasks.ps1 -Unregister  # 削除
#
# 登録されるタスク:
#   dotfiles Auto Commit … 1時間ごとに commit + push（develop ブランチ、変更がなければ何もしない）

param(
    [switch]$Unregister,
    [int]$IntervalHours = 1
)

$ErrorActionPreference = 'Stop'

$root       = "$HOME\.dotfiles"
$taskName   = 'dotfiles Auto Commit'

if ($Unregister) {
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Host "削除しました: $taskName" -ForegroundColor Yellow
    } else {
        Write-Host "未登録です: $taskName" -ForegroundColor DarkGray
    }
    return
}

# レガシー powershell.exe（5.1）は BOM なしスクリプトをシステムのANSIコードページとして
# 読むため日本語コメント／メッセージが文字化けする。pwsh（7系）があればそちらを優先する。
$pwshCmd = Get-Command pwsh.exe -ErrorAction SilentlyContinue
$psExe = if ($pwshCmd) { $pwshCmd.Source } else { (Get-Command powershell.exe).Source }

# タスクスケジューラから直接 pwsh を起動すると、-WindowStyle Hidden を付けても
# 起動時に一瞬コンソールが見えることがある。wscript.exe 経由で run-hidden.vbs を
# 挟むことで、ウィンドウを一切出さずに実行する。
$vbsWrapper = Join-Path $root 'hosts\windows\scripts\run-hidden.vbs'
$wscriptExe = Join-Path $env:WINDIR 'System32\wscript.exe'

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 30)

$action = New-ScheduledTaskAction -Execute $wscriptExe `
    -Argument "//B `"$vbsWrapper`" `"$psExe`" `"$root\hosts\windows\scripts\auto-commit.ps1`"" `
    -WorkingDirectory $root

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date.AddHours(8) `
    -RepetitionInterval (New-TimeSpan -Hours $IntervalHours) `
    -RepetitionDuration (New-TimeSpan -Days 3650)

Register-ScheduledTask -TaskName $taskName `
    -Action $action -Trigger $trigger -Settings $settings `
    -User $env:USERNAME -RunLevel Limited `
    -Description 'dotfiles(develop) の変更を commit し GitHub へ push する' -Force | Out-Null

Write-Host "登録しました: $taskName（$IntervalHours 時間ごと）" -ForegroundColor Green
Write-Host ""
Write-Host "確認: Get-ScheduledTask -TaskName '$taskName' | Format-Table TaskName, State"
Write-Host "ログ: $root\auto-commit.log"
