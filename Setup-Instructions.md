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
Simple Powershell script to grab the latest version of ADB and make it accessible system-wide:

``` powershell
# Make Sure to Run with Admin Privileges
# Grab Latest Release of Platform Tools (ADB) & Extract to Home Directory
Start-BitsTransfer "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"; Expand-Archive .\platform-tools-latest-windows.zip ~

# Add Env Variable to Access System-Wide & Cleanup .zip
[Environment]::SetEnvironmentVariable("PATH", $Env:PATH + ";$HOME\platform-tools", [EnvironmentVariableTarget]::Machine)
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
