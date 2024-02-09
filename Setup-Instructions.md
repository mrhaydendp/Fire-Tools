## Linux
Install the necessary packages for your Linux distro, then proceed to [CustomTkinter installation](#CustomTkinter-Installation).

``` bash
# Ubuntu/Debian/Chrome OS Linux Container
sudo apt install adb python3-tk

# Arch
sudo pacman -S android-tools tk

# Fedora
sudo dnf install android-tools python3-tkinter
```

## MacOS
The necessary packages need to be installed using [Brew](https://brew.sh).

``` shell
# Required: Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Packages
brew install android-platform-tools python-tk
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

## CustomTkinter Installation
Install CustomTkinter Package with pip3 (use pip instead on Windows)

``` shell
pip3 install customtkinter
```

## Fire Tablet Prep

Run Through Setup Wizard:

Select your language and set text size (if needed) then click the arrow. On the next page, select a random wireless network with a password, then click `Cancel`. You'll see a `Skip Setup` button on the bottom right, click it, then proceed to the next steps.

Enable Developer Options & USB Debugging:

Open Settings > Device Options > About Fire Tablet and tap `Serial Number` 7 times. Return to previous screen and tap on  `Developer Options` then flip on the switch. Finally scroll down to `USB Debugging` and turn it on.

![Enable USB Debugging](/Pictures/Enable%20USB%20Debugging.gif)

Now get a USB cable that supports data transfer (preferrably the one in the box) and plug it into the computer. 
