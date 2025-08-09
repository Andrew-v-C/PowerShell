
# Allow "Duplicate tab" to work
function loc { return $executionContext.SessionState.Path.CurrentLocation; }
function defPrompt { return "PS $(loc)$('>' * ($nestedPromptLevel + 1)) "; }
function prompt {
    $out = "";
    if ($(loc).Provider.Name -eq "FileSystem") {
        $out += "$([char]27)]9;9;`"$($(loc).ProviderPath)`"$([char]27)\";
    }
    $out += $(defPrompt);
    return $out;
}

# Create custom command to enter VS Developer PowerShell
function openDevShell {
    pwsh -noe -c {
        Import-Module "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/Common7/Tools/Microsoft.VisualStudio.DevShell.dll";
        Enter-VsDevShell 52711d80;  # Will need to modify this line; refer to the "Developer PowerShell for VS" shortcut
        function prompt {
            return "$($PSStyle.Foreground.Magenta)DEV$($PSStyle.Reset) $(defPrompt)";
        }
    }
}
Set-Alias -Name dev -Value openDevShell;

# Modify style
$PSStyle.FileInfo.Directory = "`e[34;1m"

# Clear command history
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null

