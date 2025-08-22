Function Get-PSIssue {
    [cmdletbinding()]
    [OutputType("GitHubIssue")]
    Param(
        [Parameter(HelpMessage = "Display issues updated since this time.")]
        [datetime]$Since,
        [Parameter(HelpMessage = "Specify a comma separated list of labels to filter with. If you select multiple labels, the issue must have all of them.")]
        [string[]]$Label,
        [Parameter(HelpMessage = "The number of results to return.")]
        [ValidateSet(25, 50, 75, 100, 150, 200)]
        [int]$Count = 25

    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running PowerShell $($PSVersionTable.PSVersion) in $($host.name)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using module version $moduleVersion"

        If ($PSBoundParameters) {
            Write-Information $PSBoundParameters -Tags runtime
        }
        #number of results per page is 25 so calculate how many pages are needed.
        [int]$m = $count / 25
        if ($m -ne 1) {
            [int]$PageCount = $m + 1
        }
        else {
            [int]$PageCount = 1
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Getting $pageCount page(s)."
        $uri = "https://api.github.com/repos/PowerShell/PowerShell/issues?&state=open&sort=updated&direction=desc&per_page=25"

        $header = @{ accept = "application/vnd.github.v3+json" }

        if ($since) {
            $dt = "{0:u}" -f $since
            $uri += "&since=$dt"
        }

        if ($Label) {
            $labelString = $Label -join ","
            $uri += "&labels=$labelString"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Filtering for labels $labelString"
        }

        $irm = @{
            uri              = $uri
            headers          = $header
            DisableKeepAlive = $True
            UseBasicParsing  = $True
            OutVariable      = 'raw'
        }

        Write-Information $uri -Tags runtime
        Write-Information $header -Tags runtime

        $results = [System.Collections.Generic.List[object]]::new()
        #set a flag to indicate we should keep getting pages
        $run = $True
    } #begin
    Process {
        1..$pageCount | ForEach-Object {
            if ($run) {
                $irm.uri = "$uri&page=$_"
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting recent PowerShell issues: $($irm.uri)"
                #filter out pull requests
                $r = (Invoke-RestMethod @irm).ForEach({ $_ | NewGHIssue })
                Write-Information $raw -tags data
                if ($r.title) {
                    $results.AddRange($r)
                }
                else {
                    Write-Warning "No matching issues found."
                    $run = $False
                }
            } #if $run
        } #foreach page
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Returned $($results.count) matching issues"
        $results
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
