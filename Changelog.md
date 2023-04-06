## Updated ui.sh, debloat.sh, launcher.sh, Fire-Tools.ps1, version (All) 04/06/2023
- Version bump (23.04)
- Apk Extractor can now extract multiple .APKs
- Launcher3/Quickstep will be disabled to prevent launcher dialog from showing up
- Rewrote launchers function to reduce redundant code & simplify enabling widgets
- Fire Launcher will now only be disabled after the selected launcher successfully installs
- Terminal output now shows which launcher was installed
- Terminal output now shows "Enabling Core Apps" when enabling Fire Launcher & OTA
- Fixed ADB check (Windows)
- Application now prompts to close to apply updates (Windows)
- Added padding to update status text (Windows)

## Updated ui.sh, debloat.sh, version (Linux/macOS) 03/03/2023
- Version bump (23.03)
- Fixed `; do` and `; then` statements
- Fixed debloat.sh

## Updated ui.sh, launcher.sh, Fire-Tools.ps1, version (All) 2/19/2023
- Version bump (23.02)
- Updated comments (Linux/macOS)
- Added dependency check
- Simplified caching of Amazon dev website
- Removed `-r` tag for adb install command
- Updated tool descriptions (Linux/macOS)
- Extracted apks now go into their own folder
- Fixed batch installer not installing .apk files (Linux/macOS)
- Simplified update tool downloads (Linux/macOS)
- Widgets will now be automatically enabled for any launcher

## Updated ui.sh, Fire-Tools.ps1, version (All) 12/19/2022
- Version bump (22.12)
- Added Custom DNS (Private DNS) changer
- Added ability to call tools from cli (Ex: ./ui.sh Update) (Linux/macOS)
- Moved device name to subtext (Linux/macOS)
- Swapped "- $device" with "Device: $device" for better readability (Windows)
- Optimized regex code to match device easier
- Apk Extractor now only makes "Extracted" folder when a package is selected
- Fire Launcher won't be disabled now if you don't pick a custom launcher from the file picker (Windows)
- Simplified update tool (Windows)
- Removed "Miscellaneous" category and moved update tool to Utilities (Windows)
