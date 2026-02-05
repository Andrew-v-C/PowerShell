# Create aliases
Set-Alias -Name py -Value python
Set-Alias -Name ar -Value arduino-cli

# Create function to open Neovim and reset cursor on exit
function ed {
    & "$HOME\Software\Neovim\bin\nvim" $args
    Write-Host -NoNewLine "`e[5 q"
}

# Create variables for convenience
$docs = "$HOME\OneDrive\Documents"
$proj = "$HOME\Projects"

# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history, and don't use it as a completion source
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
Set-PSReadLineOption -PredictionSource None
