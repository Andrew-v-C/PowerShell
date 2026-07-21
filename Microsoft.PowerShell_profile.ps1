# Create aliases
Set-Alias -Name ar -Value arduino-cli
Set-Alias -Name py -Value python

# Create function to open Neovim and reset cursor on exit
function nvim {
    & "$HOME\.Software\Neovim\bin\nvim" $args
    Write-Host -NoNewLine "`e[5 q"
}

# Create typing shortcuts for config paths
$alacritty = "$ENV:APPDATA\alacritty"
$drive = "G:\My Drive"
$nvim = "$ENV:LOCALAPPDATA\nvim"

# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history, and don't use it as a completion source
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
Set-PSReadLineOption -PredictionSource None

# Report CWD to Alacritty via OSC 7 so SpawnNewInstance opens in the same directory
function prompt {
    $loc = $executionContext.SessionState.Path.CurrentLocation
    if ($loc.Provider.Name -eq "FileSystem") {
        $esc = [char]27
        $path = $loc.Path -replace '\\', '/'
        Write-Host -NoNewline "${esc}]7;file:///$path${esc}\"
    }
    "PS $($loc.Path)> "
}

# Ctrl+Shift+N in Alacritty sends Alt+n; open a new Alacritty window in the current directory
Set-PSReadLineKeyHandler -Chord "Alt+n" -ScriptBlock {
    Start-Process alacritty -WorkingDirectory $PWD.Path
}
