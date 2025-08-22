function Get-PSReleaseAsset {
    [CmdletBinding()]
    [OutputType('PSReleaseAsset')]
    param(
        [Parameter(HelpMessage = 'Limit results to a given platform. The default is all platforms.')]
        [ValidateSet('Rhel', 'Raspbian', 'Ubuntu', 'Debian', 'Windows', 'Arm', 'MacOS', 'Alpine', 'FXDependent', 'CBL-Mariner', 'CentOS', 'Linux')]
        [string[]]$Family,
        [ValidateSet('deb', 'gz', 'msi', 'pkg', 'rpm', 'zip', 'msix')]
        [Parameter(HelpMessage = 'Limit results to a given format. The default is all formats.')]
        [string[]]$Format,
        [Alias('x64')]
        [switch]$Only64Bit,
        [Parameter(HelpMessage = 'Get the latest preview release.')]
        [switch]$Preview,
        [Parameter(HelpMessage = 'Only get LTS release-related assets.')]
        [switch]$LTS
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running PowerShell $($PSVersionTable.PSVersion) in $($host.name)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $moduleVersion"
    } #begin

    process {
        try {
            if ($Preview) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting preview assets"
                $data = GetData -Preview -ErrorAction Stop
            }
            else {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting normal assets"
                $data = GetData -ErrorAction Stop
            }
            #parse out file names and hashes
            #updated pattern 10 March 2020 to capture LTS assets
            [regex]$rx = '(?<file>[p|P]ower[s|S]hell((-preview)|(-lts))?[-|_]\d.*)\s+-\s+(?<hash>\w+)'
            # pre GA pattern
            #"(?<file>[p|P]ower[s|S]hell(-preview)?[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            # original regex pattern
            #"(?<file>[p|P]ower[s|S]hell[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            $r = $rx.Matches($data.body)
            $r | ForEach-Object -Begin {
                $h = @{ }
            } -Process {
                #if there is a duplicate entry, assume it is part of a Note
                $f = $_.Groups['file'].Value.Trim()
                $v = $_.Groups['hash'].Value.Trim()
                if (-not ($h.ContainsKey($f))) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Adding $f [$v]"
                    $h.Add($f, $v )
                }
                else {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Ignoring duplicate asset: $f [$v]"
                }
            }

            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Found $($data.assets.count) downloads"

            # https://github.com/PowerShell/PowerShell/blob/781c9a545377092439bf881d9d9954517809465b/tools/packages.microsoft.com/mapping.json#L33
            $assetData = $data.assets | where name -NotMatch 'hashes'
            # 22 August 2025 - Create a typed custom object
            $assets = foreach ($asset in $assetData) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing $($asset.Name)"
                $familyName = switch -regex ($asset.Name) {
                    'Win-x\d{2}' { 'Windows' }
                    'arm\d{2}|aarch64' { 'Arm' }
                    'Ubuntu|deb' { 'Ubuntu' }
                    'osx' { 'MacOS' }
                    'deb' { 'Debian' }
                    'appimage' { 'AppImage' }
                    'rhel|rh' { 'Rhel' }
                    'linux-arm' { 'Raspbian' }
                    'alpine|musl' { 'Alpine' }
                    'fxdepend' { 'FXDependent' }
                    'centos|rh' { 'CentOS' }
                    'linux' { 'Linux' }
                    'cm' { 'CBL-Mariner' }
                }
                [PSCustomObject]@{
                    PSTypeName    = 'PSReleaseAsset'
                    FileName      = $asset.Name
                    Family        = $familyName
                    Format        = $asset.name.Split('.')[-1]
                    Size          = $asset.size
                    Hash          = $h.item($asset.name)
                    Created       = $asset.created_at -as [datetime]
                    Updated       = $asset.updated_at -as [datetime]
                    URL           = $asset.browser_download_Url
                    DownloadCount = $asset.download_count
                }
            } #foreach

            if ($Family) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering by family"
                $assets = $assets.where( { $_.family -match $($family -join '|') })
            }
            if ($Only64Bit) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for 64bit"
                $assets = ($assets).where( { $_.filename -match '(x|amd)64' })
            }

            if ($Format) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for format"
                $assets = $assets.where( { $_.format -match $("^$format$" -join '|') })
            }

            if ($LTS) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for LTS assets"
                $assets = $assets.where( { $_.filename -match 'LTS' })
            }
            #write the results to the pipeline
            if ($assets.filename) {
                $assets
            }
            else {
                Write-Warning 'Get-PSReleaseAsset Failed to find any release assets using the specified criteria.'
            }
        } #Try
        catch {
            throw $_
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
