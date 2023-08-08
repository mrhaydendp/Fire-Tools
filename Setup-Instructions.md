## Linux
Install the necessary packages for your Linux distro:

``` bash
# Ubuntu/Debian/Chrome OS Linux Container
sudo apt install adb zenity

# Arch
sudo pacman -S android-tools zenity

# Fedora
sudo dnf install android-tools zenity
```

## MacOS
The necessary packages need to be installed using [Brew](https://brew.sh).

``` shell
# Required: Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Packages
brew install android-platform-tools zenity
```

## Windows

### Drivers
Download Offical Fire Tablet drivers or universal adb drivers:
- [Fire Tablet Drivers](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html)
- [Universal ADB Drivers](https://adb.clockworkmod.com/).
  
### ADB
Download ADB & make available system-wide 
- [ADB Wizard](https://github.com/mrhaydendp/adb-wizard)

Or manually:
``` powershell
# Run Commands in PowerShell/Windows Terminal (Admin)
# Grab Latest Release of Platform Tools (ADB) & Extract to Home Directory
Start-BitsTransfer "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"; Expand-Archive .\platform-tools-latest-windows.zip "$HOME"

# Add Environment Variable to Access ADB System-Wide & Cleanup .zip
[Environment]::SetEnvironmentVariable("Path", "$Env:PATH" + "$HOME\platform-tools", "User")
Remove-Item .\platform-tools-latest-windows.zip
```

### 7-Zip
Needed to extract Fire-Tools releases, download from [website](https://www.7-zip.org/) or through Powershell:

``` powershell
# Winget
winget install -s winget 7-Zip

# Chocolatey
choco install 7zip
```
