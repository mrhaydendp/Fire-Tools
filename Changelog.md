## Updated ui.sh, launcher.sh, and debloat.sh (Linux/macOS) 07/13/2022
- Added Alexa Cards to Debloat.txt
- Switched to case for interface functions (ui, launcher, & debloat)
- Simplified device identifier
- Unknown devices are now "Unsupported/Unknown Devices"
- Added `-r` argument to appinstaller
- Fixed Disable OTA function not finishing
- ui.sh now passes shellcheck without warnings

## Updated debloat.sh & Fire-Tools.ps1 (All) 06/15/2022
- Disable background apps renamed to disable background activities to better match the setting that it changes
- Background activities now only gets disabled if device has less that 1.5GB of ram
- "Enable" now enables background activities so you can troubleshoot apps that don't play nicely with the setting

## Updated Debloat.txt (All) 06/07/2022
- Added Amazon Usage Stats Map Proxy, Arcus Proxy, Amazon App Verification, Amazon Appstore Spotlight, and Cirrus Cloud
- Updated IMDB TV name to its new name Freevee

## Updated ui.sh & Fire-Tools.ps1 (All) 05/18/2022
- Unidentified devices are now "Unknown or Unsupported Device" instead of "Unsupported Device"
- Updater now deletes 'identifying-tablet-devices.html' to get a new cache after update (Linux/macOS)
- Added upcoming Fire 7 (2022, 12th Gen) to identfier dictionary (Windows)
- Updated UI theme to better match Windows 11's colors (Windows) 
- Updated README.md in /Gapps
