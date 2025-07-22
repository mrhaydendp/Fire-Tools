## Updated main, build, version | Date: 07/21/25
- Version bump (25.07.1)
- Moved changelog preview to first step in update sequence
- Removed extra newline from changelog
- Fixed updates for non Python versions
- Fixed issue with extra quotation mark causing issues with updating on Windows
- Removed auto quit after update
- Took requirements.txt out of modules since it already gets updated and ran before the modules get installed
- Apk Extractor path output now displays backslash or forward slash based on system
- Fixed hang on first boot of Fire Tools on Windows by starting ADB server before identify script
- Added build scripts for for compiling application binaries

## Updated: main, identify, version | Date: 07/19/2025
- Version bump (25.07)
- Merged #65 from @sukibaby, which fixes scripts not launching if spaces are in the source path
- Merged #66 from @angeld7, which adds a select all box
- Added touchpad/mouse scrolling on Linux
- Optimized regex pattern for faster device identification
- Simplified and optimized identify
- New device state names: Not Detected & Generic ADB
- Package selector now shows packages when using non Amazon devices
- Changed DNS reset option to "Disable" instead of "None"
- When DNS is disabled the DNS dropdown now resets back to default
- DNS dropdown now shows you what DNS is enabled on startup
- Added DNS providers: one.one.one.one, dns.quad9.net, adblock.dns.mullvad.net, family.cloudflare-dns.com, and family.adguard-dns.com
- Updated dependencies