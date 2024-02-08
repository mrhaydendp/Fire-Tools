# Fire Tools
Fire Tools is a powerful collection of tools that helps debloat and install Google services on your Fire Tablet to make it feel snappier and improve usability. Additionally, it supports custom launchers such as Nova, Lawnchair, or any `.apk(m)`. If you need to install multiple apps quickly, there's a batch installer. It's as easy as dropping all your `.apk(m)`s in the Batch folder and clicking the Batch Install button!

**Fire OS 7.3.2.2+ Users: Some functions may not work, such as Custom Launcher, but most packages will still be disabled**

![Fire Tools Screenshot](/Pictures/Fire-Tools.png)

## Features
- Cross Platform (Linux, macOS, & Windows)
- Powerful Debloat Tool
- Google Play Installer (Fire HD 8 8th Gen+)
- Custom Launcher Support
- Disable OTA Updates
- Apk Extractor
- Batch Installer (.apk & .apkm files)
- Private DNS Switcher

## Setup
Select instructions for your OS:

- [Linux](Setup-Instructions.md#linux)
- [macOS](Setup-Instructions.md#macos)
- [Windows](Setup-Instructions.md#windows)

## Installation Instructions
After installation run update tool to get the latest version of scripts!

Linux/macOS:
``` shell
# Download Latest Release & Extract, Then Run
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip
unzip Fire-Tools.zip && rm Fire-Tools.zip
cd Fire-Tools && python3 main.py
```

Windows Powershell:
``` powershell
# Download Latest Release & Extract, Then Open in Explorer
Start-BitsTransfer "https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip"
Expand-Archive Fire-Tools.zip .\; Remove-Item Fire-Tools.zip
Explorer .\Fire-Tools
```

## Notes
- Set timezone settings before debloat! (re-enable `com.amazon.kindle.otter.oobe` to change date & time settings)
- Google Apps are downloaded from [ApkMirror](https://www.apkmirror.com/) and are included in releases for convienence. See [terms](https://github.com/mrhaydendp/Fire-Tools/blob/main/Fire-Tools/Gapps/README.md) 
- Debloat will disable most amazon apps with the exception of: `Calculator`, `Camera`, `Clock`, `Files`, `Fire Launcher`, `Silk Browser`, and `Settings`
- This won't void your warranty and everything can be restored with a factory reset.
- Although this is my tool, **I am not responsible for anything that may go wrong when using this tool.**
  
## Credits
Thank you to all these people's software included in this tool! Included software is not my own and is provided for convinience.
- [Google](https://www.android.com/) (Gapps)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair) (Lawnchair)
- [D0k3](https://github.com/d0k3) (Inspired by their OneClick-for-Amazon-Fire tool)
