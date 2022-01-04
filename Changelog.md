## Updated Fire-Tools.ps1 (Windows) - 1/4/21
- Changed "dark preference" theme color to "LightGray" because the previous one had a weird reddish hue
- Switched to better method of getting "AppsUseLightTheme" preference
- Code cleanup

## Updated Fire-Tools.ps1 & ui.sh (All) - 12/28/21
- Removed MOTD functionality

## Updated ui.sh, debloat.sh, and Debloat.txt (Linux/macOS) - 12/22/21
- Closed the if statement above "Custom Launcher" because it was causing issues
- Fixed apps not enabling/disabling if there are more than one with a similar name
- "Enable" now tells you it's enabling Fire Launcher & OTA Updates
- Added "On Deck" to the debloat list

## Updated Fire-Tools.ps1 (Windows) - 12/15/21
- Updated shebang so its more compatible
- Added MOTD function for the holidays
- Replaced Invoke-WebRequest with Invoke-RestMethod so I don't have to format changelog output
