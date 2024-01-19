## Updated ui.sh, debloat.sh, Fire-Tools.ps1, version, Debloat.txt (All) 01/19/2024
- Undo now re-enables location services
- Undo now enables core apps (OTA & Fire Launcher)
- Fixed terminal not outputting "Disabled Private DNS" (Linux/macOS)
- Fix DNS not being disabled
- Undo text now says "Disabling Private DNS" instead of just AdGuard
- Swapped to different method of disabling location services
- Removed com.amazon.wifilocker & com.amazon.kindle.starsight from Debloat.txt because they made reconnecting to Wi-Fi inconsistent

## Updated ui.sh, debloat.sh, launcher.sh, Fire-Tools.ps1, Debloat.txt, version (All) 10/25/2023
- Version bump (23.10)
- Script now waits for a device to be connected
- Swapped to printf for better Posix compatibility & multi-line support (Linux/macOS)
- App data will now get cleared during debloat process (for apps in debloat list)
- Overhauled output for debloat & appinstaller function to show success and failure messages
- Packages selected from the Custom menu can now be enabled or disabled (Linux/macOS)
- Added "Provider Bookmarks" to debloat list

## Updated ui.sh, debloat.sh, launcher.sh, Fire-Tools.ps1, Debloat.txt, version (All) 08/16/2023
- Version bump (23.08)
- Stopped disabling launcher3 because it disables recents button functionality
- Device and Fire OS version will now be shown in terminal
- Apk extractor will now tell you which apk is currently being extracted
- Updates are now only installed if version is lower than latest (Linux/macOS)
- Added option to disable Private DNS by typing "None" into textbar (Linux/macOS)
- Fixed error when editing Debloat.txt on MacOS (Linux/macOS)
- Fixed code formatting (Linux/macOS)
- Redesigned UI (Windows)
- Updated comments (Windows)
- Cleaned up terminal output (Windows)
- Revamped debloat function with cleaner output (Windows)
- Simplified device identifier (Windows)
- Cleaned up appinstaller (Windows)
- Added "|" to seperate version from device model in titlebar (Windows)
- Made window size bigger (Windows)
- Added list of selectable installed packages to disable, enable, or extract (Windows)
- Made custom launchers a dropdown list instead of multiple buttons (Windows)
- Made custom DNS a dropdown list instead of opening gridview (Windows)
- Custom DNS now pings server to make sure its valid before setting (Windows)
- Added abiltiy to type in custom DNS provider (Windows)
- Updated Google Services tooltip (Windows)

## Updated ui.sh, launcher.sh, Fire-Tools.ps1, version (All) 05/29/2023
- Version bump (23.05)
- Added Play Store check before showing success & error message
- Tablet identifier will only run if device is running Fire OS
- Custom DNS now checks for "dns" in the URL and runs a ping test before being set
- Swapped to regex for formatting custom launcher diff (Linux/macOS)
- Silenced output of split apk extraction
- If ADB is not found, you will be asked to open the ADB installation instructions page (Windows)
