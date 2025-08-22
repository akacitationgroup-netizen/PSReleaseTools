---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://jdhitsolutions.com/yourls/35d171
schema: 2.0.0
---

# Save-PSReleaseAsset

## SYNOPSIS

Download the latest PowerShell from the Github PowerShell repository.

## SYNTAX

### All (Default)

```yaml
Save-PSReleaseAsset [[-Path] <String>] [-All] [-Passthru] [-Preview] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Family

```yaml
Save-PSReleaseAsset [[-Path] <String>] -Family <String[]> [-Format <String[]>] [-Passthru] [-Preview] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### file

```yaml
Save-PSReleaseAsset [[-Path] <String>] [-Asset <Object>] [-Passthru] [-Preview] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

This command will download the latest stable PowerShell 7 releases from the PowerShell GitHub repository. You can download everything or limit the download to specific platforms. Use -Preview to get the latest preview build.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Save-PSReleaseAsset D:\PS7 -all
```

Save all release assets for all platforms.

### EXAMPLE 2

```powershell
PS C:\> Save-PSReleaseAsset -path D:\PS7 -family Windows -format msi
```

Download and save Windows MSI packages.

### EXAMPLE 3

```powershell
PS C:\> Save-PSReleaseAsset -path D:\PS7Linux -name Ubuntu,Debian
```

Download and save Ubuntu and Debian packages.

### EXAMPLE 4

```powershell
PS C:\> Get-PSReleaseAsset -Family rhel -preview | Save-PSReleaseAsset -path D:\Temp -passthru

    Directory: D:\Temp


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         2/3/2020  10:22 AM       57876871 powershell-preview-7.0.0_rc.2-1.rhel.7.x86_64.rpm
```

Get the RedHat assets for the latest preview build and save them to D:\Temp

## PARAMETERS

### -Path

The destination folder for all downloads.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -All

Download all files to the destination path. This is the default behavior.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Asset

An asset object piped from Get-PSReleaseAsset.

```yaml
Type: Object
Parameter Sets: file
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Family

The platform you wish to download.

```yaml
Type: String[]
Parameter Sets: Family
Aliases:
Accepted values: 'Rhel', 'Raspbian', 'Ubuntu', 'Debian', 'Windows', 'Arm', 'MacOS', 'Alpine', 'FXDependent', 'CBL-Mariner', 'CentOS', 'Linux'

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

Limit results to a given format. The default is all formats.

```yaml
Type: String[]
Parameter Sets: Family
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

### -Passthru

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### system.string

## OUTPUTS

### System.IO.FileInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Invoke-WebRequest]()

[Get-PSReleaseAsset](Get-PSReleaseAsset.md)
