# Fire Tools

Fire Tools is a powerful tool that debloats and installs Google services on Amazon Fire Tablets to make them feel snappier and increase ease of use. In addition it also supports installing custom launchers such as Nova, Lawnchair, or any `.apk`. If you wish to install all your own apps at once theres a batch installer. It's as easy as dropping all your `.apk` & `.apkm` files in the Batch folder and clicking the Batch Install button!

**Fire OS 7.3.2.2+ Users: Custom Launcher will not work & some packages won't be disabled during debloat**

**Note this tool requires USB Debugging to be enabled**

## Features
- Cross Platform (Linux, macOS, Windows)
- Powerful Debloat Tool
- Google Play Installer (Fire HD 8 8th Gen & Up)
- Custom Launcher Installer
- Disable OTA Updates
- Apk Extractor
- Split Apk Support (.apkm)
- Built in Update Tool for Updating Scripts

## Supported Devices
- Fire HD 10 (9th Gen, 11th Gen)
- Fire HD 8 (8th Gen, 10th Gen)
- Fire 7 (9th Gen)

| Linux/macOS | Windows |
| ----------- | ------- |
| ![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools.png) | ![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools%20Windows.png) |

## Installation Instructions
After installation run update tool to get the latest version of scripts!

Linux, WSL, & macOS:

``` shell
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```

Windows:

- Download [Latest Release](https://github.com/mrhaydendp/Fire-Tools/releases/latest/download/Fire-Tools.tar.xz)  
- Extract With 7-Zip or Similar Application
- Open the `Fire-Tools` Folder Then Right Click on `Fire-Tools.ps1` & Open in Powershell
  
## Setup

Select Instructions for Your OS:
- [Linux](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md#linux-installation-instructions)
- [macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md#macos)
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)

## Fire Tablet Prep

Enable Developer Options & USB Debugging:

Open `Settings` and go to `Device Options` then scroll down and and tap `About Fire Tablet`

![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/About%20Fire%20Tablet.png)

Then tap `Serial Number` 7 times it should say you are 2 taps away after the 5th tap

![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/2%20Taps%20Away.png)

Press the back button and `Developer Options` will now be visible

![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Developer%20Options.png)

Now switch on `Developer Options` and `USB Debugging`. Then get a USB cable that supports data transfer (preferrably the one in the box) and plug it into the computer.

![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/USB%20Debugging.png)

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
