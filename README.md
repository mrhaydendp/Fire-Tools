# Fire Tools

Fire Tools is a powerful script that debloats and installs Google services to Amazon Fire Tablets to make them feel snappier and increase the ease of use. In addition it also allows you to install custom launchers such as: Nova, Lawnchair, and others. If you wish to add your own apps theres a custom batch installer. It's as easy as putting your `.apk` files into the Custom folder and clicking the Batch-Install button!

**Note this tool requires USB Debbuging and Unknown Sources to be enabled**

## Supported Devices
- Fire HD 10 (9th Gen, 11th Gen)
- Fire HD 8 (8th Gen, 10th Gen)
- Fire 7 (9th Gen)

![Screenshot](https://github.com/mrhaydendp/Fire-Tools/blob/main/Fire-Tools.png)


## Setup
First go here for Tablet Setup
- [Fire Tablet Prep](https://github.com/mrhaydendp/Fire-Tools/blob/main/Fire%20Tablet%20Prep.md)

Then follow the instructions for your platform:
- [Linux/macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md)
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)

## Installer Script
For Linux, WSL, and macOS run this command in terminal:
```
wget https://github.com/mrhaydendp/Fire-Tools/releases/download/v1.1/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./Fire-Tools.sh
```

## Config Options
This script is very customizable, you can whitelist apps so they're not disabled by commenting out the package name ex:
```
#com.package.name
```
The Launcher can also be changed by swapping out `Launcher.apk` (Nova by default) with one of your choice and clicking Custom-Launcher in the script. You can also batch install apps by dropping the `.apk` files in the Custom folder and clicking Batch-Install in the script.

## Notes
Things you should know:
- You are allowed to fork this script and make your own for your use cases
- Google Apps are taken from [ApkMirror](https://www.apkmirror.com/) and are updated monthly
- Debloat will disable all amazon apps except `Calculator`, `Camera`, `Clock`, `Files`, `Home`, and `Settings`
- This should not void your warranty but, if unsure factory reset your device before sending it in.
- Although this is my tool, **I am not responsible for anything that may go wrong when using this script.**

## Credits
Thank you to all these peoples software included in this script!
- [Google](https://www.android.com/)
- [F-Droid](https://www.f-droid.org/en/about/)
- [AuroraOSS](https://auroraoss.com/contact/)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Brave](https://brave.com/about/)
- [Team Newpipe](https://github.com/TeamNewPipe)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair)
- [D0k3](https://github.com/d0k3) (For inspiration to make this script)
