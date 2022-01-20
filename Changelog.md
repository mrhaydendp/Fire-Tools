## Updated ui.sh, debloat.sh (Linux/macOS) 1/20/21
- Added Google to  install Google Services wildcard so only Google apps will be installed
- Added "Failed to Disable OTA Updates" notification if disabling OTA fails
- Removed unecessary "&&" during update process
- Cleaned up debloat descriptions
- Swapped array with mapfile to pass shellcheck checks (debloat)

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
