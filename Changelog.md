## Updated ui.sh, launcher.sh, & debloat.sh (Linux/macOS) 3/24/22
- Posix Shell compliant
- Application now checks for adb on launch
- Switched to echo for notifications because zenity --notification isn't supported on macOS
- Removed system-wide dark mode as it was finicky with fire 7
- Batch installer can now install split apks

## Updated Debloat.txt (All) 2/25/22
- Added package name for com.amazon.dcpms.fos.service (DCPMSFOSService)
- Added com.amazon.tcomm.jackson
- Added com.amazon.device.sale.service
- Added com.amazon.sync.service
- Added com.amazon.alta.h2clientservice
- Added com.here.odnp.service
- Added com.amazon.shpm

## Updated ui.sh & debloat.sh (Linux/macOS) 1/25/22
- Improved macOS support by [danieltwagner](https://github.com/danieltwagner)

## Updated ui.sh & debloat.sh (Linux/macOS) 1/20/22
- Added Google to  install Google Services wildcard so only Google apps will be installed
- Added "Failed to Disable OTA Updates" notification if disabling OTA fails
- Removed unecessary "&&" during update process
- Cleaned up debloat descriptions
- Swapped array with mapfile to pass shellcheck checks (debloat)
