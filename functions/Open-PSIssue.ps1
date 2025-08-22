Function Open-PSIssue {
    [cmdletbinding()]
    [OutputType("None")]
    Param(
        [Parameter(ValueFromPipelineByPropertyName,HelpMessage = "You can optionally specify the issue URL")]
        [ValidateNotNullOrEmpty()]
        [string]$Url = "https://github.com/powershell/powershell/issues"
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running PowerShell $($PSVersionTable.PSVersion) in $($host.name)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $moduleVersion"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Opening $url"
        start-process $url
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
