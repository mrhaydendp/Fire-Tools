##  Updated ui.sh, launcher.sh, and debloat.sh (Linux/macOS) - 12/07/21
- Passed all bash specific shellcheck checks (and very close to posix shell compliance)
- Updated shebang to `#!/usr/bin/env bash` for better compatibility
- Updated the debloat tool to be more efficient
- Launcher installs now grant all permissions to the launcher so there's no hang after install

## Update Fire-Tools.ps1 (Windows) - 11/29/21
- Application now changes colors based on system theme
- Added -g argument to Google apps install and launchers to grant all permissions on installation

## Updated Fire-Tools.ps1 (Windows) - 11/28/21
- New rebuilt debloat tool that has multi device support & creates less errors
- Updated comments above code

## Updated ui.sh & debloat.sh (Linux/macOS) - 11/27/21
- Removed reboot to recovery option as it was unnecessary
- Fixed bug in new debloat tool where fire launcher and ota gets enabled by leaving menu
- Slightly increased UI size so Custom Launcher description fits
