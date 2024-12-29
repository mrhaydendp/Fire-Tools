## Updated: main, install, version | Date: 12/29/2024
- Version bump (24.12)
- Merged #63 from @angeld7, which adds a select all checkbox to the package list
- Update tool now grabs the latest `requirements.txt` file and installs it using PIP
- Added install script to updated modules
- Python path will now be added $PATH live so the later PIP commands work (install script)
- Appinstaller function now officially supports single application installs
- If the Batch folder is empty when running batch install, the file picker dialog will pop up to let you select an `.apk(m)` file
- Merged APK and Split filetypes into APK/Split in file dialog file filter
