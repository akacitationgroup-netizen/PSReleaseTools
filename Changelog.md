# Change Log for PSReleaseTools

This file format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [1.13.0] - 2025-08-22

### Added

- Added environment and module metadata to verbose output.

### Changed

- Added parameters `DisableTelemetry` and `DisableWindowsUpdate` to `Install-PowerShell` and `Install-PSPreview`. [[Issue #27](https://github.com/jdhitsolutions/PSReleaseTools/issues/27)]
- Updated `Get-PSReleaseAsset` to write a typed custom object to the pipeline and added defined custom formatting.
- Updated `Get-PSReleaseAsset` to better handle family groupings including support for ARM.
- Updated markdown creation in `Get-PSReleaseSummary`.
- General code cleanup.
- Updated license year.
- Help documentation updates.
- Updated change log to new format. Moved older change log entries to an archive change log for historical purposes.

### Fixed

- Fixed missing class needed for `Get-PSIssue`.
- Fixed duplicate entry in new Issue object.

## [v1.12.0] - 2022-06-04

### Changed

- Exported public functions to individual files.

### Fixed

- Fixed `A parameter cannot be found that matches parameter name 'source'` bug in `Save-PSReleaseAsset`. Renamed the `DL` private function to `_DownloadAsset`.

## [v1.11.0] - 2021-10-15

### Changed

- Modified private function `getCode` to get latest release sorting on the published date.

## [v1.10.0] - 2021-08-10

### Added

- Added a custom format file, `psreleasestatus.format.ps1xml` for the `PSReleaseStatus` type.

### Changed

- Help file cleanup.
- Modified `images/PowerShell_avatar.png` to use a transparent background.
- Modified `Get-PSReleaseCurrent` to write a `PSReleaseStatus` type of object to the pipeline.
- Updated `README.md`.

### Fixed

- Fixed broken online help links. ([Issue #25](https://github.com/jdhitsolutions/PSReleaseTools/issues/112)).

## [v1.9.0] - 2021-01-13

### Added

- Added `-EnableRunContext` parameter to `Install-PowerShell`, `Install-PSPreview`, and the internal `installMSI` functions to reflect a new MSI installation option.

### Changed

- Help updates.
- Modified `installMSI` to create a log file at `$env:temp\PS7Install.log`.
- Updated `README.md`.
- Updated license year.

## [v1.8.0] - 2020-08-25

### Added

- Added commands (`Get-PSIssue`, `Get-PSIssueLabel`,`Open-PSIssue`) to view and search issues from the PowerShell GitHub repository.
- Added format file `githubissues.format.ps1xml` which is used by `Get-PSIssue`.

### Changed

- `Changelog` clean up.
- Updated help documentation.
- Updated `README.md`.

## [v1.7.1] - 2020-07-30

### Changed

- Documentation updates.
- Merge pull request #24 from xtqqczze/lint to fix casing issues.
- Updated manifest private data tags.

## [v1.7.0] - 2020-07-10

### Changed

- Updated `README.md` (Thanks @Gimly)

### Fixed

- Fixed `critiera` typo in warning message for `Get-PSReleaseSummary`.

## [v1.6.2] - 2020-06-26

### Added

- Added a dynamic parameter called `-Online` to `Get-PSReleaseSummary` to open the GitHub release page in the default web browser.

### Changed

- Updated warning message for `Install-PSPreview` with a clearer error message.and suppressed error output. ([Issue #21](https://github.com/jdhitsolutions/PSReleaseTools/issues/21))
- Updated the same for `Install-PowerShell`.

## [v1.6.1] - 2020-03-27

### Changed

- Updated `Install-PSPreview` and `Install-PowerShell` to fix errors when using `-WhatIf`. ([Issue #19](https://github.com/jdhitsolutions/PSReleaseTools/issues/19))

## [v1.6.0] - 2020-03-11

### Added

- Added `-LTS` parameter to `Get-PSReleaseAsset` to limit results to LTS-related files.

### Changed

- Updated install functions to allow options for enabling remoting and Explorer context menus.
- Updated documentation and help to reference PowerShell 7 and not PowerShell Core. ([Issue #18](https://github.com/jdhitsolutions/PSReleaseTools/issues/18))
- Renamed `Install-PSCore` to `Install-PowerShell`. Kept `Install-PSCore` as a command alias.
- Updated commands to recognize the LTS assets.
- Updated `README.md`.

### Fixed

- Fixed bug in  Get-PSReleaseAsset` that failed to label a family for CentOS assets.

## [v1.5.0] - 2020-02-03

### Changed

- Help updates to reflect PowerShell 7.
- License update.
- Updated `README.md`.

### Fixed

- Fixed bug installing preview on Windows PowerShell ([Issue #16](https://github.com/jdhitsolutions/PSReleaseTools/issues/16)).
- Fixed regex in `Get-PSReleaseAsset` to get all preview files ([Issue #17](https://github.com/jdhitsolutions/PSReleaseTools/issues/17)).

## [v1.4.1] - 2019-08-27

### Changed

- Merged PR from @weebsnore to fix a bug when installing from a path with an apostrophe.
- Minor help corrections.

## [v1.4.0] - 2019-08-26

### Added

- Added `msix` as an asset format.

### Changed

- Changed online help links to `bit.ly` links.
- Updated `Get-PSReleaseAsset` to be stricter on format matching.

### Fixed

- Fixed bug with `Install-PSPreview` erroring on the path ([Issue #15](https://github.com/jdhitsolutions/PSReleaseTools/issues/15)).

## [v1.3.2] - 2019-07-18

### Changed

- Standardized verbose output to include a timestamp.

### Fixed

- Fixed another new bug with installation commands.

## [v1.3.1] - 2019-07-18

### Fixed

- Fixed installation issue with spaces in filenames ([Issue #13](https://github.com/jdhitsolutions/PSReleaseTools/issues/13)).

## [v1.3.0] - 2019-07-16

### Added

- Added online help links.

### Changed

- Updated `README.md`.

## [v1.2.0] - 2019-07-12

### Added

- Added `Install-PSCore` command for Windows only (Issue #11).
- Added YAML versions of help documents.

### Changed

- Reorganized module layout.
- Updated verbose messages in private functions.
- Updated help.
- Updated `README.md`.

## [v1.1.0] - 2019-07-10

### Added

- Added `Install-PSPreview` to install the latest 64bit PowerShell Preview build for Windows.

### Changed

- Updated asset cmdlets to include new families (Issue #10).
- Updated `Get-PSReleaseAsset` to allow specifying a format (Issue #9).
- Updated `Save-PSReleaseAsset` and made `Format` a formal parameter.
- Updated `README.md`.
- Help updates.

## [v1.0.0] - 2019-02-13

- There have been enough updates that this seems like a good time.

[Unreleased]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.13.0..HEAD
[1.13.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/vv1.12.0..v1.13.0
[v1.12.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.11.0..v1.12.0
[v1.11.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.10.0..v1.11.0
[v1.10.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.9.0..v1.10.0
[v1.9.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.8.0..v1.9.0
[v1.8.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.7.1..v1.8.0
[v1.7.1]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.7.0..v1.7.1
[v1.7.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.6.2..v1.7.0
[v1.6.2]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.6.1..v1.6.2
[v1.6.1]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.6.0..v1.6.1
[v1.6.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.5.0..v1.6.0
[v1.5.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.4.1..v1.5.0
[v1.4.1]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.4.0..v1.4.1
[v1.4.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.3.2..v1.4.0
[v1.3.2]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.3.1..v1.3.2
[v1.3.1]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.3.0..v1.3.1
[v1.3.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.2.0..v1.3.0
[v1.2.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.1.0..v1.2.0
[v1.1.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v1.0.0..v1.1.0
[v1.0.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v0.8.1..v1.0.0