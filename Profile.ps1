
# Create custom command to enter VS Developer PowerShell
function defPrompt { return "PS $(loc)$('>' * ($nestedPromptLevel + 1)) "; }
function openDevShell {
    pwsh -noe -c {
        Import-Module "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/Common7/Tools/Microsoft.VisualStudio.DevShell.dll";
        Enter-VsDevShell b0e67882;  # Will need to modify this line; refer to the "Developer PowerShell for VS" shortcut
        function prompt {
            return "$($PSStyle.Foreground.Magenta)DEV$($PSStyle.Reset) $(defPrompt)";
        }
    }
}
Set-Alias -Name dev -Value openDevShell;

# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history, and don't use it as a completion source
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
Set-PSReadLineOption -PredictionSource None

