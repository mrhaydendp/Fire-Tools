# Fire Tools

Fire Tools is a powerful script that debloats and installs Google services on Amazon Fire Tablets to make them feel snappier and increase ease of use. In addition it also supports installing custom launchers such as Nova, Lawnchair, or any `.apk`. If you wish to install all your own apps at once theres a batch installer. It's as easy as dropping all your `.apk` files in the Batch folder and clicking the Batch Install button!

**Fire OS 7.3.2.2+ Users: Custom Launcher will not work & some packages won't be disabled during debloat**

**Note this tool requires USB Debugging to be enabled**

## Features

- Cross-Device Debloat Tool
  
- Manual Disable
  
- Google Services
  
- Disable Privacy Infringing Settings
  
- AdGuard Private DNS
  
- Custom Launchers
  
- System-Wide Dark Mode
  
- Apk extractor
  
- Batch Installer
  
- Split Apk Installer
  

## Supported Devices

- Fire HD 10 (9th Gen, 11th Gen)
  
- Fire HD 8 (8th Gen, 10th Gen)
  
- Fire 7 (9th Gen)
  

| ![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools.png) | ![](https://github.com/mrhaydendp/Fire-Tools/raw/main/Pictures/Fire-Tools%20Windows.png) |
| --- | --- |

## Installation Instructions

Linux, WSL, & macOS:

```bash
wget https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```

Windows:

- Download [Latest Release](https://github.com/mrhaydendp/Fire-Tools/releases/download/v2.1/Fire-Tools.tar.xz)
  
- Extract With 7-Zip or Similar Application
  
- Open the `Fire-Tools` Folder Then Right Click on `Fire-Tools.ps1` & Open in Powershell
  

## Setup

- [Linux/macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md)
  
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)
  
- [Config Options](https://github.com/mrhaydendp/Fire-Tools/blob/main/Config%20Options.md)
  

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
- You are allowed to fork this script and make your own for your use cases but you have to credit me and link back to this project
- Google Apps are downloaded from [ApkMirror](https://www.apkmirror.com/)
- Debloat will disable all amazon apps except `Calculator`, `Camera`, `Clock`, `Files`, `Home`, and `Settings`
- This should not void your warranty but, if unsure factory reset your device before sending it in.
- Although this is my tool, **I am not responsible for anything that may go wrong when using this script.**
  
## Credits
Thank you to all these people's software included in this script!
- [Google](https://www.android.com/) (Gapps)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair) (Lawnchair)
- [D0k3](https://github.com/d0k3) (For inspiration to make this script)
