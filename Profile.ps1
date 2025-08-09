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
function openDevShell {
    pwsh -noe -c {
        Import-Module "C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/Common7/Tools/Microsoft.VisualStudio.DevShell.dll";
        Enter-VsDevShell 52711d80;
        function prompt {
            return "$($PSStyle.Foreground.Magenta)DEV$($PSStyle.Reset) $(defPrompt)";
        }
    }
}
Set-Alias -Name dev -Value openDevShell;
Set-Content -Path (Get-PSReadLineOption).HistorySavePath -Value $null
$PSStyle.FileInfo.Directory = "`e[34;1m"
