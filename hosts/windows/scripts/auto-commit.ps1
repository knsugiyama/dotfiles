# auto-commit.ps1 — dotfiles の変更を commit して GitHub へ push する（自動実行用）
#
#   .\hosts\windows\scripts\auto-commit.ps1
#
# タスクスケジューラから定期実行することを想定しています。
# 変更がなければコミットせず、push だけ試みます。確認プロンプトは出しません。
#
# ⚠ このリポジトリを複数端末で使っている場合、他の端末が先に push していると
#   rebase が失敗することがあります（コンフリクト）。その場合は自動リトライせず
#   ログに残して終了します。気づいたら自分でリポジトリの状態を確認し、解決して
#   ください（rebase は失敗時に自動で abort 済みなので、作業ツリーは壊れません）。

$ErrorActionPreference = 'Stop'

$root   = "$HOME\.dotfiles"
$log    = Join-Path $root 'auto-commit.log'
$branch = 'develop'   # 自動 commit/push の対象はこのブランチのみ

function Write-Log([string]$msg) {
    $line = "[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $msg
    Add-Content -LiteralPath $log -Value $line -Encoding UTF8
}

try {
    Set-Location -LiteralPath $root

    $current = git rev-parse --abbrev-ref HEAD
    if ($current -ne $branch) {
        Write-Log "スキップ（現在のブランチが $current で対象外）"
        exit 0
    }

    # 1. 変更があればコミット
    $dirty = git status --porcelain 2>$null
    if ($dirty) {
        git add -A 2>&1 | Out-Null
        $msg = "auto: {0}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm')
        git commit -m $msg 2>&1 | Out-Null
        Write-Log "コミットしました"
    } else {
        Write-Log "変更なし"
    }

    # 2. リモートの変更を取り込んでから push（複数端末対策）
    git fetch origin $branch *>&1 | Out-Null

    git rebase "origin/$branch" *>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        git rebase --abort *>&1 | Out-Null
        Write-Log "失敗: rebase できませんでした（コンフリクトの可能性）。手動で確認してください。"
        exit 1
    }

    git push origin $branch *>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Log "失敗: push できませんでした"
        exit 1
    }
    Write-Log "push しました"
}
catch {
    Write-Log "失敗: $($_.Exception.Message)"
    exit 1
}
