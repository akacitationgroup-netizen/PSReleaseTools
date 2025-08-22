function Get-PSReleaseCurrent {
    [CmdletBinding()]
    [OutputType("PSReleaseStatus")]
    param(
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running PowerShell $($PSVersionTable.PSVersion) in $($host.name)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $moduleVersion"
    } #begin

    process {

        $data = GetData @PSBoundParameters

        #get the local version from the GitCommitID on v6 platforms
        #or PSVersion table for everything else
        if ($PSVersionTable.ContainsKey("GitCommitID")) {
            $local = $PSVersionTable.GitCommitID
        }
        else {
            $Local = $PSVersionTable.PSVersion
        }

        if ($data.tag_name) {
            #create a custom object. This object has a custom format file.
            [PSCustomObject]@{
                PSTypeName   = "PSReleaseStatus"
                Name         = $data.name
                Version      = $data.tag_name
                Released     = $($data.published_at -as [datetime])
                LocalVersion = $local
                URL          = $data.html_url
                Draft        = If ($data.draft -eq 'True') {$True} else {$false}
                Prerelease   = If ($data.prerelease -eq 'True') { $True } else { $false }
             }
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
