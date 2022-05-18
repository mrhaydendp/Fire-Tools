## Updated ui.sh & Fire-Tools.ps1 (All) 05/18/2022
- Unidentified devices are now "Unknown or Unsupported Device" instead of "Unsupported Device"
- Updater now deletes 'identifying-tablet-devices.html' to get a new cache after update (Linux/macOS)
- Added upcoming Fire 7 (2022, 12th Gen) to identfier dictionary (Windows)
- Updated UI theme to better match Windows 11's colors (Windows) 
- Updated README.md in /Gapps

## Updated Fire-Tools.ps1 (Windows) 05/07/2022
- Updated device identifier list
- Added debloat function with enable and disable parameters to simplify and remove redundant code
- Added appinstaller function to intelligently switch app install methods based on file type (`.apk` or `.apkm`)
- Removed SplitInstaller shortcut as there is a integrated split apk installer now
- Removed recovery because it isn't necessary 
- Added tooltips to buttons

## Updated ui.sh, launcher.sh, & debloat.sh (Linux/macOS) 05/05/2022
- Made all UIs have a uniform width
- Shortened tool descriptions
- Device name is now found using amazon docs page: https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html
- Added Appinstaller function that detects and installs files based on file type (apk, apkm)
- Updater now uses an array so it won't mess with `.sh` files in the same directory and opens up the possibility of adding new scripts through the updater in the future
- Simplified and combined enable and disable into one function with arguments
- Debloat tool is now 1/3 - 1/2 a second faster

## Updated Fire-Launcher.ps1 (Windows) 3/30/2022
- Removed shebang as it was unneeded
- Updated comments
- Removed system-wide dark mode as it was finicky on Fire 7
- Slimmed down and better integrated split apk installer for gapps and batch install
- Batch install now installs split apk files
- Added `com.amazon.device.software.ota.override` to disable ota
- Slimmed down updater tool
