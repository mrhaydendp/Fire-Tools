# Fire Tablet Prep
## Run Through Setup Wizard

Select your language and set the text size (if needed), then click the arrow. On the next page, select a random wireless network with a password, then click `Cancel`. You’ll see a `Skip Setup` button on the bottom right; click it, then proceed to the next steps.

## Enable Developer Options & USB Debugging

Open Settings > Device Options > About Fire Tablet then tap `Serial Number` 7 times. Return to the previous screen and tap on  `Developer Options`, then flip on the switch. Finally, scroll down to `USB Debugging` and turn it on.

![Enable USB Debugging](/Pictures/Enable%20USB%20Debugging.gif)

Now, get a USB cable that supports data transfer (preferably the one in the box) and plug it into the computer. 

# Linux
Install the necessary packages for your Linux distro, then CustomTkinter.
``` shell
# Ubuntu/Debian/Chrome OS Linux Container
sudo apt install adb python3-tk

# Arch
sudo pacman -S android-tools tk

# Fedora
sudo dnf install android-tools python3-tkinter

# CustomTkinter Installation
pip3 install customtkinter
```

# MacOS
Install [Brew](https://brew.sh/) then get the necessary packages:
``` shell
# Required: Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Dependencies
brew install android-platform-tools python-tk

# Install CustomTkinter
pip3 install customtkinter
```

# Windows
## Drivers
Download Offical Fire Tablet drivers or universal adb drivers:

- [Fire Tablet](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html)
- [Universal ADB Drivers](https://adb.clockworkmod.com/)

## ADB
Download ADB & make available system-wide:

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

## CustomTkinter
After Python3 & ADB are installed, installed install CustomTkinter with pip3 command. 
``` powershell
pip3 install customtkinter
```
