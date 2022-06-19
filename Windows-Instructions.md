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

## Enable & Setup WSL
  
Open PowerShell as Administrator and run:
  
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
Reboot your machine.

Enable Virtual Machine Feature:

Before installing WSL 2, you must enable the Virtual Machine Platform optional feature. Your machine will require virtualization capabilities to use this feature.
Open PowerShell as Administrator and run:
  
```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
  
Reboot your machine.

Download the Linux Kernel Update Package:
- [WSL2 Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)    
- Run the installer

Set WSL 2 as the Default Version:

Open PowerShell and run this command to set WSL 2 as the default version:

```powershell
wsl --set-default-version 2
```

## Download Debian & Fire Tools Dependencies

- [Debian](https://www.microsoft.com/store/apps/9MSVKQC78PK6)

Dependencies:

```bash
sudo apt install adb wget zenity
```
