#these are internal functions for the PSReleaseTools module

#define an internal function to download the file
function _DownloadAsset {
    [CmdletBinding(SupportsShouldProcess)]
    param([string]$Source, [string]$Destination, [string]$Hash, [switch]$Passthru)

    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] $Source to $Destination"

    if ($PSCmdlet.ShouldProcess($Destination, "Downloading $Source")) {
        Invoke-WebRequest -Uri $source -UseBasicParsing -DisableKeepAlive -OutFile $Destination
        Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Comparing file hash to $Hash"
        $f = Get-FileHash -Path $Destination -Algorithm SHA256
        if ($f.Hash -ne $Hash) {
            Write-Warning "Hash mismatch. $Destination may be incomplete."
        }

        if ($Passthru) {
            Get-Item $Destination
        }
    } #should process
} #_DownloadAsset

function GetData {
    [CmdletBinding()]
    param(
        [switch]$Preview
    )

    $uri = "https://api.github.com/repos/powershell/powershell/releases"

    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Getting current release information from $uri"
    $get = Invoke-RestMethod -Uri $uri -Method Get -ErrorAction Stop

    if ($Preview) {
        Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Getting latest preview"
        ($get).where( { $_.prerelease }) | Sort-Object -Property Published_At -Descending |
        Select-Object -First 1
    }
    else {
        Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Getting latest stable release"
        ($get).where( { -NOT $_.prerelease }) | Sort-Object -Property Published_At -Descending |
        Select-Object -First 1
    }
} #close GetData

function InstallMsi {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, HelpMessage = "The full path to the MSI file")]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path,
        [Parameter(HelpMessage = "Specify what kind of installation you want. The default if a full interactive install.")]
        [ValidateSet("Full", "Quiet", "Passive")]
        [string]$Mode = "Full",
        [Parameter(HelpMessage = "Enable PowerShell Remoting over WSMan.")]
        [switch]$EnableRemoting,
        [Parameter(HelpMessage = "Add 'Open Here' context menus to Explorer.")]
        [switch]$EnableContextMenu,
        [Parameter(HelpMessage = "Add 'Run with PowerShell 7` context menu for PowerShell files.")]
        [switch]$EnableRunContext,
        [Parameter(HelpMessage = "Disable Telemetry")]
        [switch]$DisableTelemetry,
        [Parameter(HelpMessage = "Disable updating PowerShell through Windows Update or WSUS")]
        [switch]$DisableWindowsUpdate
    )

    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Creating Start-Process parameters"

    $modeOption = switch ($Mode) {
        "Full" { "/qf" }
        "Quiet" { "/quiet" }
        "Passive" { "/passive" }
    }

    #create a log file
    $log = Join-Path $env:temp -ChildPath "PS7Install.log"
    $installOption = " $modeOption /lp! $log"

    #Register Windows Event Logging Manifest
    $installOption += " REGISTER_MANIFEST=1"
    #Add PowerShell to Path Environment Variable
    $installOption += " ADD_PATH=1"

    if ($EnableRemoting) {
        #Enable PowerShell Remoting
        $installOption += " ENABLE_PSREMOTING=1"
    }
    If ($EnableContextMenu) {
        #Add 'Open Here' context menus to Explorer
        $installOption += " ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"
    }
    if ($EnableRunContext) {
        #Add 'Run with PowerShell 7` context menu for PowerShell files
        $installOption += " ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1"
    }
    # 22 Aug 2025 Added newer installation options
    if ($DisableTelemetry) {
        $installOption += " DISABLE_TELEMETRY=1"
    }
    If ($DisableWindowsUpdate) {
        $installOption += " ENABLE_MU=0 USE_MU=0"
    }

    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] FilePath: $Path"
    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] ArgumentList: $installOption"

    if ($PSCmdlet.ShouldProcess("$Path $installOption")) {
        Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Starting installation process"
        Start-Process -FilePath $Path -ArgumentList $installOption
    } #WhatIf

    Write-Verbose "[$((Get-Date).TimeOfDay) $($MyInvocation.MyCommand)] Ending function"

} #close InstallMsi


Function NewGHIssue {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject
    )
    Process {
        # GitHubIssue([string]$Title,[string]$url,[datetime]$Created,[datetime]$Updated,[string]$Body)
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating issue for $($inputObject.title)"
        $obj = [GitHubIssue]::New($InputObject.Title, $InputObject.html_url, $inputObject.created_at, $InputObject.updated_at, $inputObject.body)
        $obj.SubmittedBy = $inputObject.user.login
        $obj.state = $InputObject.state
        $obj.Labels = $inputObject.labels.name
        $obj.CommentCount = $inputObject.comments
        $obj.Milestone = $inputObject.milestone.Title

        if ($inputObject.pull_request) {
            $obj.IsPullRequest = $True
        }

        $obj
    }
}


