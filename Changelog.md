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

## Updated main, build, version | Date: 07/21/25
- Version bump (25.07.1)
- Moved changelog preview to first step in update sequence
- Removed extra newline from changelog
- Fixed updates for non Python versions
- Fixed issue with extra quotation mark causing issues with updating on Windows
- Removed auto quit after update
- Took requirements.txt out of modules since it already gets updated and ran before the modules get installed
- Apk Extractor path output now displays backslash or forward slash based on system
- Fixed hang on first boot of Fire Tools on Windows by starting ADB server before identify script
- Fixed ADB error when work profile is enabled by targeting default user
- Added build scripts for for compiling application binaries
