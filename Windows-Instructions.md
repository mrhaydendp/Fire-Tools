# Method #1 Native (Powershell)
## Drivers
Download Fire Tablet drivers and or universal adb drivers 
- [Fire Tablet Drivers](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html)
- [Universal ADB Drivers](https://adb.clockworkmod.com/).

## ADB
I recommend 15 seconds ADB Installer because it has basic drivers and system wide ADB
- [15 seconds ADB Installer](https://forum.xda-developers.com/attachment.php?attachmentid=4623157&d=1540039037)

## Installation
Go to Releases Page and download `Fire-Tools.Windows.zip`. Once Downloaded unzip and right click on the .ps1 file then click "Run with PowerShell"
- [Releases Page](https://github.com/mrhaydendp/Fire-Tools/releases)

# Method #2 WSL (Windows Subsystem for Linux)

## Enable WSL
Open PowerShell as Administrator and run:
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
Reboot your machine.

## Enable Virtual Machine Feature
Before installing WSL 2, you must enable the Virtual Machine Platform optional feature. Your machine will require virtualization capabilities to use this feature.

Open PowerShell as Administrator and run:
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
Reboot your machine.

## Download the Linux Kernel Update Package
1. Download the latest package
   - [WSL2 Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
2. Run the installer

## Set WSL 2 As Your Default Version
Open PowerShell and run this command to set WSL 2 as the default version:
```
wsl --set-default-version 2
```

## Download Debian From the Windows Store
- [Debaian](https://www.microsoft.com/store/apps/9MSVKQC78PK6)

## Dependencies
Install all necessary packages:
```
sudo apt install wget adb zenity
```
