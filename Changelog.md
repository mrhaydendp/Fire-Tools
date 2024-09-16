## Updated: appinstaller, debloat, install, main, version | Date: 09/15/2024
- Version bump (24.09)
- Added "packagelist" file check before checking for custom launcher to reduce errors
- Improved readability and consistency of scripts by replacing $args[1]/$1 variables with $app/option throughout all scripts
- Debloat script now requires an option to run instead of automatically debloating
- Simplified/sped up PowerShell debloat script by formatting Debloat.txt instead of every string it outputs into the array (to match Linux/macOS)
- Formatting fixes
- Created install script for all platforms that installs dependencies and adds Fire Tools to start/app menu
