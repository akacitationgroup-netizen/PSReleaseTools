---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://jdhitsolutions.com/yourls/75c2f0
schema: 2.0.0
---

# Get-PSReleaseAsset

## SYNOPSIS

Get PowerShell release assets.

## SYNTAX

```yaml
Get-PSReleaseAsset [[-Family] <String[]>] [-Format <String[]>] [-Only64Bit] [-Preview] [-LTS]
 [<CommonParameters>]
```

## DESCRIPTION

Use this command to get details about the different PowerShell release assets. The default is to get all assets for the most recent stable release but you can limit results to a particular family like Windows or Ubuntu or get assets from the latest preview build.

This command will not download the file but allow you to look at the details. You can pipe these results to Save-PSReleaseAsset to download.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseAsset -Family Rhel

FileName  : powershell-7.5.2-1.rh.x86_64.rpm
Family    : {Rhel, CentOS}
Format    : rpm
Updated   : 6/24/2025 8:49:21 PM
Downloads : 9,330
SizeMB    : 71
URL       : https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-1.rh.x86_64.rpm
```

Getting the latest Red Hat related assets for the stable build.

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseAsset -Family Windows -Only64Bit -Preview | Select *

FileName      : PowerShell-7.6.0-preview.4-win-x64.exe
Family        : Windows
Format        : exe
Size          : 113824048
Hash          : 2F03028E87246732D8BB5E5F887992312C17815E90E93D1FB7FBB9055CB89DC1
Created       : 4/8/2025 9:36:42 PM
Updated       : 4/8/2025 9:36:46 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.4/PowerShell-7.6.0-preview.4-win-x64.exe
DownloadCount : 5048

FileName      : PowerShell-7.6.0-preview.4-win-x64.msi
Family        : Windows
Format        : msi
Size          : 114393088
Hash          : 844957E3954504D76926274FC606B849764FF5CD9712EBAA9BE639DB9CCD201E
Created       : 4/8/2025 9:36:47 PM
Updated       : 4/8/2025 9:36:52 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.4/PowerShell-7.6.0-preview.4-win-x64.msi
DownloadCount : 89688

FileName      : PowerShell-7.6.0-preview.4-win-x64.zip
Family        : Windows
Format        : zip
Size          : 115864208
Hash          : 385012237C108ECDFCD35DBDBB989194F56D8381F864EA69E4ECC8BD7215C6B4
Created       : 4/8/2025 9:36:53 PM
Updated       : 4/8/2025 9:36:58 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.4/PowerShell-7.6.0-preview.4-win-x64.zip
DownloadCount : 17656
```

Get the preview build assets for Windows showing all properties.

### EXAMPLE 3

```powershell
PS C:\>  Get-PSReleaseAsset -Family Arm -Format msi | Save-PSReleaseAsset -Path c:\temp -WhatIf
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/PowerShell-7.5.2-win-arm64.msi" on target "c:\temp\PowerShell-7.5.2-win-arm64.msi".
```

Run the command without -WhatIf to actually download the installation files.

## PARAMETERS

### -Family

Limit search to a particular platform. Not all families will have assets for every release.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Rhel, Raspbian, Ubuntu, Debian, Windows, Arm, MacOS, Alpine, FXDependent, CentOS, Linux, CBL-Mariner

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Only64Bit

Only display 64bit assets.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: x64

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

Limit results to a given format. The default is all formats.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted Values: deb, gz, msi, pkg, rpm, zip, msix

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

### -LTS

Only get LTS release-related assets.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReleaseAsset

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Save-PSReleaseAsset](Save-PSReleaseAsset.md)
