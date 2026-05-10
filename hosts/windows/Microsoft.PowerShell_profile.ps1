# Microsoft.PowerShell_profile.ps1

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
function prj {
    $repo = ghq list --full-path | fzf
    if ($repo) {
        Set-Location $repo
    }
}
