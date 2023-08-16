## Updated ui.sh, debloat.sh, launcher.sh, Fire-Tools.ps1, Debloat.txt, version (All) 08/16/2023
- Version bump (23.08)
- Stopped disabling launcher3 because it disables recents button functionality
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

## Updated ui.sh, debloat.sh, launcher.sh, Fire-Tools.ps1, Debloat.txt, version (All) 04/06/2023
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
