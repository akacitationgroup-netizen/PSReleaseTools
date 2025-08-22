---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://jdhitsolutions.com/yourls/3e370b
schema: 2.0.0
---

# Install-PSPreview

## SYNOPSIS

Install the latest PowerShell Preview on Windows.

## SYNTAX

```yaml
Install-PSPreview [[-Path] <String>] [[-Mode] <String>] [-EnableRemoting] [-EnableContextMenu]
 [-EnableRunContext] [-DisableTelemetry] [-DisableWindowsUpdate] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command is intended to make it easy to download and install the latest PowerShell *preview* release on Windows platforms. The command will download the 64bit MSI package and initiate the installation process. You can control how much of the installation you want to interact with. The default is the full, interactive installer. If you have previous PowerShell preview versions installed, they will be either removed or overwritten. A log file will be created in $env:temp\PS7Install.log

This command will only work on Windows platforms. Non-Windows platforms have native installation tools.

## EXAMPLES

### Example 1

```powershell
PS C:\> Install-PSPreview -mode Passive -EnableRemoting
```

Download and install using the passive mode which will only display a progress bar.
PowerShell remoting will also be enabled.

### Example 2

```powershell
PS C:\> Install-PSPreview
```

Download and install using the full interactive mode. Use this when you need more granular control of installation options. The MSI will be downloaded and saved to $env:TEMP. It will not be deleted after installation.

## PARAMETERS

### -Path

Specify the path to the download folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: $env:\temp
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mode

Specify what kind of installation you want.

- Quiet is no interaction at all.
- Passive will display a progress bar.
- Full is the complete interactive experience.

The default is a full interactive install.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Full, Quiet, Passive

Required: False
Position: 1
Default value: Full
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableContextMenu

Enable the PowerShell context menu in Windows Explorer.

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

### -EnableRemoting

Enable PowerShell Remoting over WSMan.

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

### -EnableRunContext

Add 'Run with PowerShell 7' context menu for PowerShell files.

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

### -DisableTelemetry

Disable telemetry.

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

### -DisableWindowsUpdate

Disable updating PowerShell through Windows Update or WSUS.

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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Save-PSReleaseAsset](Save-PSReleaseAsset.md)

[Install-PowerShell](Install-PowerShell.md)
