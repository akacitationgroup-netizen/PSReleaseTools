#load functions

# Trivial Change.

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    . $_.fullname
}

#Export the module version to a global variable that will be used in Verbose messages
$mod = Import-PowerShellDataFile -Path $PSScriptRoot\PSReleaseTools.psd1 -ErrorAction Stop
$moduleVersion = $mod.ModuleVersion

#configure TLS settings for GitHub as a "just in case" measure
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Class GitHubIssue {
    [datetime]$Created
    [datetime]$Updated
    [string]$SubmittedBy
    [string]$State = "open"
    [string]$Title
    [string]$body
    [string[]]$Labels
    [int32]$CommentCount
    [string]$Milestone
    [string]$Url
    [bool]$IsPullRequest = $False

    [void]Show() {
        Start-Process $this.url
    }

    GitHubIssue([string]$Title, [string]$url, [datetime]$Created, [datetime]$Updated, [string]$Body) {
        $this.Title = $Title
        $this.url = $url
        $this.Created = $Created
        $this.updated = $Updated
        $this.body = $Body
    }
}


#cache issue labels
$global:PSIssueLabel = Get-PSIssueLabel

#define an auto completer for Get-PSIssue
Register-ArgumentCompleter -CommandName Get-PSIssue -ParameterName Label -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Try {
        Get-Variable PSIssueLabel -Scope global -ErrorAction stop
    }
    Catch {
        $global:PSIssueLabel = Get-PSIssueLabel
    }
    #PowerShell code to populate $WordToComplete
    ($global:PSIssueLabel).where( { $_.name -like "*$wordToComplete*" }) | ForEach-Object {
        # completion text,listItem text,result type,Tooltip
        if (-not $_.description) {
            $_.description = "no description"
        }
        [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.description)
    }
}