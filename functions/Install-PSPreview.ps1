function Install-PSPreview {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(HelpMessage = 'Specify the path to the download folder')]
        [string]$Path = $env:TEMP,
        [Parameter(HelpMessage = 'Specify what kind of installation you want. The default if a full interactive install.')]
        [ValidateSet('Full', 'Quiet', 'Passive')]
        [string]$Mode = 'Full',
        [Parameter(HelpMessage = 'Enable PowerShell Remoting over WSMan.')]
        [switch]$EnableRemoting,
        [Parameter(HelpMessage = "Add 'Open Here' context menus to Explorer.")]
        [switch]$EnableContextMenu,
        [Parameter(HelpMessage = "Add 'Run with PowerShell 7` context menu for PowerShell files")]
        [switch]$EnableRunContext,
        [Parameter(HelpMessage = 'Disable Telemetry')]
        [switch]$DisableTelemetry,
        [Parameter(HelpMessage = 'Disable updating PowerShell through Windows Update or WSUS')]
        [switch]$DisableWindowsUpdate
    )
    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running PowerShell $($PSVersionTable.PSVersion) in $($host.name)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $moduleVersion"
    } #begin

    process {
        #only run on Windows
        if (($PSEdition -eq 'Desktop') -or ($PSVersionTable.Platform -eq 'Win32NT')) {
            if ($PSBoundParameters.ContainsKey('WhatIf')) {
                #create a dummy file name is using -WhatIf
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating a dummy file for WhatIf purposes"
                $filename = Join-Path -Path $Path -ChildPath 'WhatIf-PS7Preview.msi'
            }
            else {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Saving download to $Path"
                $msi = Get-PSReleaseAsset -Preview -Family Windows -Only64Bit -Format msi
                if ($msi) {
                    $install = $msi | Save-PSReleaseAsset -Path $Path -Passthru
                    $filename = $install.FullName

                } #if msi found
                else {
                    Write-Warning 'No preview MSI file found to download and install.'
                }
            }

            if ($filename) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using $filename"

                #call the internal helper function
                $inParams = @{
                    Path                  = $filename
                    Mode                  = $Mode
                    EnableRemoting        = $EnableRemoting
                    EnableContextMenu     = $EnableContextMenu
                    EnableRunContext      = $EnableRunContext
                    DisableTelemetry      = $DisableTelemetry
                    DisableWindowsUpdate  = $DisableWindowsUpdate
                    ErrorAction           = 'Stop'
                }
                if ($PSCmdlet.ShouldProcess($filename, "Install PowerShell Preview using $mode mode")) {
                    InstallMSI @inParams
                }
            }
        } #if Windows
        else {
            Write-Warning 'This command will only work on Windows platforms.'
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
