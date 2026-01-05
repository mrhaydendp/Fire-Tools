## Updated appinstaller, debloat.sh, Debloat.txt, main, version | Date: 01/05/26
- Version bump (26.01)
- Updated .gitignore to make packaging and testing easier
- Added `Alexa Voice Assistant` to debloat list
- Added `Factory Data Reset Allowlist Manager` to debloat list
- Added `Amazon Sharing Proxy Service` to debloat list
- Updated friendly names in Debloat.txt
- Fixed undefined error when clicking out of custom launcher selection #83
- The selected .apk file will now be displayed when using the "Custom" launcher option
- Formatting changes to keep Windows and Unix versions in line with eachother

## Updated main, build, version | Date: 09/21/25
- Version bump (25.09)
- Build scripts now use python module mode
- Platform binaries now only include necessary scripts
- Swapped to glob method of checking & deleting cached ft-identify-tablet-devices.html file
- Added line skip before "Updating Dependencies" section of update log
- Fixed incorrect append command when adding `main.py` to modules
- Fixed Linux/macOS versions crashing due to a Windows workaround #79 
- Replaced os.startfile with a notepad command since it's not cross platform and causes incompatibility on Linux/macOS
- Build scripts will now use the version file to automatically set the version variable
- Added build directories to .gitignore
- Updated Amazon device docs link for identifer scripts
- Updated imports
- Renamed path variable to default_path to fix conflict with path function 
