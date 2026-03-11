# Create aliases
Set-Alias -Name py -Value python
Set-Alias -Name ar -Value arduino-cli

# Create function to open Neovim and reset cursor on exit
function ed {
    & "$HOME\Software\Neovim\bin\nvim" $args
    Write-Host -NoNewLine "`e[5 q"
}

# Create function to open custom calculator
function calc {
    Set-Location $HOME\Projects\PythonLab
    if ($?) {
        venv\Scripts\activate
        if ($?) {
            ed calc.py
        }
    }
}

# Create typing shortcuts for config paths
$alacritty = "$ENV:APPDATA\alacritty"
$nvim = "$ENV:LOCALAPPDATA\nvim"
$drive = "G:\My Drive"

# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history, and don't use it as a completion source
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
Set-PSReadLineOption -PredictionSource None
