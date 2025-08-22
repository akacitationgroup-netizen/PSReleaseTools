---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://jdhitsolutions.com/yourls/cef4e4
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information about the latest PowerShell 7.x release.

## SYNTAX

### default (Default)

```yaml
Get-PSReleaseSummary [-Preview] [<CommonParameters>]
```

### md

```yaml
Get-PSReleaseSummary [-AsMarkdown] [-Preview] [<CommonParameters>]
```

### online

```yaml
Get-PSReleaseSummary [-Preview] [-Online] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PowerShell GitHub repository for the latest stable release information using the GitHub APIs. Use -Preview to get information about the latest preview build. You do not need to have a GitHub account to use this command, although you may still reach an API limit if you run this command repeatedly in a short time frame.

The default output is a text report but you have the option to create a markdown version.

Use the -Online parameter to open the GitHub release page in your browser. This parameter only works in Windows.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseSummary

-----------------------------------------------------------
v7.5.2 Release of PowerShell
Published: 06/24/2025 21:31:53
-----------------------------------------------------------
## [7.5.2] - 2025-06-24

### Engine Updates and Fixes

- Move .NET method invocation logging to after the needed type conversion is done for method arguments (#25357)

### General Cmdlet Updates and Fixes

- Set standard handles explicitly when starting a process with `-NoNewWindow` (#25324)
- Make inherited protected internal instance members accessible in class scope. (#25547) (Thanks @mawosoft!)
- Remove the old fuzzy suggestion and fix the local script file name suggestion (#25330)
- Fix `PSMethodInvocationConstraints.GetHashCode` method (#25306) (Thanks @crazyjncsu!)

### Build and Packaging Improvements

<details>

<summary>

<p>Update to .NET SDK 9.0.301</p>

</summary>
...
```

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseSummary -AsMarkdown -preview | Show-Markdown -useBrowser
```

Get the latest preview release summary as markdown and use the Show-Markdown command in PowerShell Core to render the markdown in the console. Note that Show-Markdown may not render tables correctly.

## PARAMETERS

### -AsMarkdown

Create a markdown version of the report. If using Show-Markdown, tables may not render correctly. You will have best results if use the -UseBrowser parameter of Show-Markdown.

```yaml
Type: SwitchParameter
Parameter Sets: md
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Preview

Get the latest preview release.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

Open the GitHub release page in your browser. This parameter only works on Windows systems.

```yaml
Type: SwitchParameter
Parameter Sets: online
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-PSReleaseCurrent](Get-PSReleaseCurrent.md)
