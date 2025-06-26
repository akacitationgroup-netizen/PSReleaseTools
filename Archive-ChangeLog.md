# Archive Change Log for PSReleaseTools

This is a change log artifact for everything prior to version 1.10.0

This file format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v0.8.1] - 2019-02-13

- Raised minimum PowerShell version to 5.1 to support CompatiblePSEditions.

## [v0.8.0] - 2019-02-13

- Modified commands to default to the most recent stable build.
- Modified commands to get preview build and related assets (Issue #7).
- Updated the manifest to reflect support for Desktop and Core editions.
- Added an alias of `x64` to the `Only64bit` parameter in `Get-PSReleaseAsset`.
- Reorganized module file layout.
- Help updates.
- Updated `README.md`.

## v0.7.0 - 2018-10-22

- Added switch parameter on `Get-PSReleaseAsset` to only get x64 versions.
- Added an option to display the current release summary as a markdown document.
- help updates.
- file cleanup for the PowerShell Gallery.
- fixed license.

## v0.6.1 - 2018-03-02

- Added code to fix TLS issue with GitHub (Issue #5).

## v0.6.0 - 2018-01-11

- Updated to support GA for PowerShell 6 (Issue #4).
- Changed Save-PSReleaseAsset Name parameter to Family.
- Modified Family values.
- Updated documentation.
- Updated screenshots and README.md.

## v0.5.1 - 2017-05-12.0

- Added asset support for SUSE and AppImage.
- Minor changes to help documentation.
- Updated Pester tests.

## v0.5.0 - 2017-01-26.0

- Modified download to pull file hashes from summary and compare them to downloaded files. This is a __BREAKING CHANGE__.
- Updated `Get-PSReleaseAsset` to include the SHA256 hash.
- Updated help.
- updated README.

## v0.4.0 - 2017-01-12.2

- Fixed semantic versioning in the manifest.
- Changed to semantic versioning.
- Updated author name in manifest.
- Added `Get-PSReleaseCurrent`.
- Updated help.

## v0.3.0 - 2017-01-05

- Renamed `Save-PSRelease` to `Save-PSReleaseAsset` for consistency (Issue #1).
- Updated documentation.
- Updated manifest.
- Published to PSGallery.

## v0.2.0 - 2017-01-04

- Added external documentation.

## v0.1.0 - 2017-01-04

- Initial module release.
- updated license copyright.
- updated README.

[v0.8.1]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v0.8.0..v0.8.1
[v0.8.0]: https://github.com/jdhitsolutions/PSReleaseTools/compare/v0.7.0..v0.8.0
