## Updated Fire-Tools.ps1 (Windows) - 12/15/21
- Updated shebang so its more compatible
- Added MOTD function for the holidays
- Replaced Invoke-WebRequest with Invoke-RestMethod so I don't have to format changelog output

## Updated ui.sh (Linux/macOS) - 12/15/21
- Added message of the day for holiday messages
- Fixed the tense of all descriptions so they're the same
- Removed unneeded fi endings

##  Updated ui.sh, launcher.sh, and debloat.sh (Linux/macOS) - 12/07/21
- Passed all bash specific shellcheck checks (and very close to posix shell compliance)
- Updated shebang to `#!/usr/bin/env bash` for better compatibility
- Updated the debloat tool to be more efficient
- Launcher installs now grant all permissions to the launcher so there's no hang after install

## Updated Fire-Tools.ps1 (Windows) - 11/29/21
- Application now changes colors based on system theme
- Added -g argument to Google apps install and launchers to grant all permissions on installation
