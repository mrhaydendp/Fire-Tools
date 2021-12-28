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

## Updated ui.sh (Linux/macOS) - 12/15/21
- Added message of the day for holiday messages
- Fixed the tense of all descriptions so they're the same
- Removed unneeded fi endings
