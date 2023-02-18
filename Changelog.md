## Updated ui.sh, launcher.sh, Fire-Tools.ps1, version (All) 2/19/2023
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

## Updated ui.sh, launcher.sh, debloat.sh, Fire-Tools.ps1, Debloat.txt (All) 11/15/2022
- Version bump (22.11)
- Rewrote apk extractor function to be more reliable and output extracted apks in "Extracted" folder
- Simplified and rewrote custom disable function
- Added support for app bundles when selecting a custom launcher
- Added Edit feature to open Debloat.txt in your preferred text editor
- Alphabetized Debloat List

## Updated Debloat.txt, version (All) 10/12/2022
- Version bump (22.10.1)
- Updated Package Names
- Re-added DCP applications
- Added Switch Access Root
- Fixed #19
