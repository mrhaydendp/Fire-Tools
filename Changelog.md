## Updated debloat.sh & ui.sh (Linux/macOS) 08/27/2022
- Decreased complexity and further increased Debloat Tool speed by up to 33% from July version
- Cleaned up & slimmed down ram check
- Slight format change with '{}'

## Updated debloat.sh & Debloat.txt (Linux/macOS) 08/15/2022
- Debloat tool now only disables packages that are present giving an up to 15% speed improvement
- Custom disable is more reliable as it now uses the debloat function 
- Updated descriptions for debloat options
- Added Hybrid Ad ID Service to Debloat.txt (All)

## Updated Fire-Tools.ps1 (Windows) 07/14/2022
- Updated device identifier dictionary to be more in line with Linux/macOS
- Updated placeholder model number for Fire 7 2022
- Added `-r` argument to appinstaller
- Cleaned up comments and Write-Host messages
- Updated titlebar with "Fire Tools" instead of "Fire-Tools"

## Updated ui.sh, launcher.sh, and debloat.sh (Linux/macOS) 07/13/2022
- Added Alexa Cards to Debloat.txt (All)
- Switched to case for interface functions
- Simplified device identifier
- Unknown devices are now "Unsupported/Unknown Devices"
- Added `-r` argument to appinstaller
- Fixed Disable OTA function not finishing
- ui.sh now passes shellcheck without warnings
- Fixed Nova & Lawnchair install
