## WSL (Windows Subsystem for Linux) Method

### Enable WSL
Open PowerShell as Administrator and run:
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
Reboot your machine.

### Enable Virtual Machine Feature
Before installing WSL 2, you must enable the Virtual Machine Platform optional feature. Your machine will require virtualization capabilities to use this feature.

Open PowerShell as Administrator and run:
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
Reboot your machine.

### Download the Linux Kernel Update Package
1. Download the latest package
   - [WSL2 Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
2. Run the installer

### Set WSL 2 As Your Default Version
Open PowerShell and run this command to set WSL 2 as the default version:
```
wsl --set-default-version 2
```

### Download Debian From the Windows Store
- [Debaian](https://www.microsoft.com/store/apps/9MSVKQC78PK6)

### Install Dependencies
Open Debian terminal and paste the folling command to install all dependencies:
```
sudo apt install wget adb zenity
```

## Native Method (Powershell)
**Native Version Is In The Works**

If you are on Windows drivers for Fire Tablets are found [here](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html) and ADB drivers are [here](https://adb.clockworkmod.com/).
