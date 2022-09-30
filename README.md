# Fire Tools
Fire Tools is a powerful tool that debloats and installs Google services on your Amazon Fire Tablet to make it feel snappier and improve usability. Additionally it supports custom launchers such as Nova, Lawnchair, or any `.apk`. If you need to install multiple apps quickly there's a batch installer. It's as easy as dropping all your APKs & Split APKs in the Batch folder and clicking the Batch Install button!

**Fire OS 7.3.2.2+ Users: Custom Launchers will not work & some packages won't be disabled during debloat**

**Note: This tool requires USB Debugging to be enabled**

## Features
- Cross Platform (Linux, macOS, & Windows)
- Powerful Debloat Tool
- Google Play Installer (Fire HD 8 8th Gen+)
- Disable OTA Updates
- Apk Extractor
- Split Apk Support (aka App Bundles)
- Built in Update Tool

## Officially Supported Devices
- Fire HD 10 (9th Gen, 11th Gen)
- Fire HD 8 (8th Gen, 10th Gen)
- Fire 7 (9th Gen, 12th Gen)

Linux/macOS | Windows
:----------:|:-------:
![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools.png) | ![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools%20Windows.png)

## Setup
Select instructions for your OS:

- [Linux](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md#linux-installation-instructions)
- [macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md#macos)
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)

## Installation Instructions
After installation run update tool to get the latest version of scripts!

Linux/macOS:
``` shell
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```

Windows:

- Download [Latest Release](https://github.com/mrhaydendp/Fire-Tools/releases/latest/download/Fire-Tools.tar.xz)
- Extract with 7-Zip or similar application
- Open the Fire-Tools folder & right click on Fire-Tools.ps1 then Open in PowerShell

## Fire Tablet Prep

Run Through Setup Wizard:

Select your language and set text size (if needed) then click the arrow. On the next page, select a random wireless network with a password, then click `Cancel`. You'll see a `Skip Setup` button on the bottom right, click it, then proceed to the next steps.

Enable Developer Options & USB Debugging:

Open Settings > Device Options > About Fire Tablet and tap `Serial Number` 7 times. Return to previous screen and tap on  `Developer Options` then flip on the switch. Finally scroll down to `USB Debugging` and turn it on.

![Enable USB Debugging](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/Enable%20USB%20Debugging.gif?raw=true)

Now get a USB cable that supports data transfer (preferrably the one in the box) and plug it into the computer. 

## Notes

Things you should know:
- Set timezone settings before debloat! (re-enable `com.amazon.kindle.otter.oobe` to change date & time settings)
- You are allowed to fork this tool for your own use case but you have to link back to this project
- Google Apps are downloaded from [ApkMirror](https://www.apkmirror.com/) and are included in releases for convienence. See [terms](https://github.com/mrhaydendp/Fire-Tools/blob/main/Fire-Tools/Gapps/README.md) 
- Debloat will disable all amazon apps except `Calculator`, `Camera`, `Clock`, `Files`, `Home`, and `Settings`
- This should not void your warranty but, if unsure factory reset your device to erase all changes.
- Although this is my tool, **I am not responsible for anything that may go wrong when using this tool.**
  
## Credits
Thank you to all these people's software included in this tool!
- [Google](https://www.android.com/) (Gapps)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair) (Lawnchair)
- [D0k3](https://github.com/d0k3) (Inspired by their OneClick-for-Amazon-Fire tool)
