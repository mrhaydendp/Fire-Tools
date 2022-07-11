# Method #1 Native (Powershell)

## Drivers

Download Offical Fire Tablet drivers or universal adb drivers:

- [Fire Tablet Drivers](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html)
- [Universal ADB Drivers](https://adb.clockworkmod.com/).
  
## ADB
Simple Powershell script to grab latest ADB and make it accessible system-wide:

``` powershell
# Make Sure to Run with Admin Privileges
# Grab Latest Release of Platform Tools (ADB) & Extract to C:
Start-BitsTransfer "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"; Expand-Archive .\platform-tools-latest-windows.zip C:\

# Add Env Variable to Access System-Wide & Cleanup .zip
[Environment]::SetEnvironmentVariable("PATH", $Env:PATH + ";C:\platform-tools", [EnvironmentVariableTarget]::Machine)
Remove-Item .\platform-tools-latest-windows.zip
```

## Installation
  
- Download [Latest Release](https://github.com/mrhaydendp/Fire-Tools/releases/download/v2.1/Fire-Tools.tar.xz)
- Extract With 7-Zip or Similar Application    
- Open the `Fire-Tools` Folder Then Right Click on `Fire-Tools.ps1` & Open in Powershell

# Method #2 WSL (Windows Subsytem for Linux)

## Install & Setup WSL
Since Windows 11 & Windows 10 version 2004+ the WSL install is a lot easier and can be completed in one command.

``` powershell
# Automated Install (Ubuntu)
wsl --install

# For a Specific Distro use "wsl -l -o" to List Available Distros
wsl --install -d distroname
```

## Update & Grab Dependencies
Now run updates then install ADB & Zenity.

``` bash
# Update
sudo apt update && sudo apt full-upgrade

# Dependencies for Fire Tools
sudo apt install adb zenity

```

## Installation
Follow the [installation instructions](https://github.com/mrhaydendp/Fire-Tools#installation-instructions) on the main page or copy the command from here:

``` bash
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```
