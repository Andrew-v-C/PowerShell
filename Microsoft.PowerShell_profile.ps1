# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history, and don't use it as a completion source
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
Set-PSReadLineOption -PredictionSource None

# Create function to open Neovim, and reset cursor on exit
function nvim {
    & "$HOME\Software\nvim-win64\bin\nvim" $args
    Write-Host -NoNewLine "`e[5 q"
}
