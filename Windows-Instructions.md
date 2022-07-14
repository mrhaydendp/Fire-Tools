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
