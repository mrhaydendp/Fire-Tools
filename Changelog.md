## Updated Fire-Tools.ps1 (Windows) 07/14/2022
- Updated device identifier dictionary to be more in line with Linux/macOS
- Updated placeholder model number for Fire 7 2022
- Added `-r` argument to appinstaller
- Cleaned up comments and Write-Host messages
- Updated titlebar with "Fire Tools" instead of "Fire-Tools"

## Updated ui.sh, launcher.sh, and debloat.sh (Linux/macOS) 07/13/2022
- Added Alexa Cards to Debloat.txt (All)
- Switched to case for interface functions
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
