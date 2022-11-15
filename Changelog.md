## Updated ui.sh, launcher.sh, debloat.sh, Fire-Tools.ps1, Debloat.txt (All) 11/15/2022
- Version bump (22.11)
- Rewrote apk extractor function to be more reliable and output extracted apks in "Extracted" folder
- Simplified and rewrote custom disable function
- Added support for app bundles when selecting a custom launcher
- Added Edit feature to open Debloat.txt in your preferred text editor
- Alphabetized Debloat List

## Updated Debloat.txt (All) 10/12/2022
- Version bump (22.10.1)
- Updated Package Names
- Re-added DCP applications
- Added Switch Access Root
- Fixed #19

## Updated ui.sh, debloat.sh, Fire-Tools.ps1, Debloat.txt (All) 10/01/2022
- Removed problematic packages in debloat list & updated names
- Switched to new Ubuntu-esque versioning scheme (22.10)
- Moved update check to update tool so application launches faster
- Simplified tablet identifier with regex & added feature to Windows
- Removed unecessary lines in debloat proccess
- Speed up debloat tool by ~ 4.8x, using sub-proccesses to disable multiple applications simultaneously (Linux/macOS)

## Updated ui.sh, Fire-Tools.ps1, Debloat.txt (All) 09/20/2022
- Re-introduced version numbers starting with 2.3.1
- Fixed Google Services installer
- Cleaned up and slimmed down Debloat & Appinstaller functions (Windows)
- Updated README.md in Gapps folder with sources
- Removed Silk Browser & Amazon Wallpaper from Debloat.txt because they are useful if you don't have replacements downloaded
