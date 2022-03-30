## Updated Fire-Launcher.ps1 (Windows) 3/30/22
- Removed shebang as it was unneeded
- Updated comments
- Removed system-wide dark mode as it was finicky on Fire 7
- Slimmed down and better integrated split apk installer for gapps and batch install
- Batch install now installs split apk files
- Added `com.amazon.device.software.ota.override` to disable ota
- Slimmed down updater tool

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
