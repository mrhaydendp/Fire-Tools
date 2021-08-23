# Fire Tools
Fire Tools is a powerful script that debloats and installs Google services to Amazon Fire Tablets to make them feel snappier and increase the ease of use. In addition it also allows you to install custom launchers such as Nova and Lawnchair. If you wish to add your own apps theres a custom batch installer. It's as easy as putting your `.apk` files into the Custom folder and clicking the Batch-Install button!

**Note this tool requires USB Debbuging to be enabled**

## Supported Devices
- Fire HD 10 (9th Gen, 11th Gen)
- Fire HD 8 (8th Gen, 10th Gen)
- Fire 7 (9th Gen)

![Screenshot](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/Fire-Tools.png)

## Setup
Follow the instructions for your platform:
- [Linux/macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md)
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)

## Fire Tablet Prep
### Enable Developer Options & USB Debugging
Open `Settings` and go to `Device Options` then scroll down and and tap `About Fire Tablet`

![About](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/About%20Fire%20Tablet.png)

Then tap `Serial Number` 7 times it should say you are 2 taps away after the 5th tap

![Serial](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/2%20Taps%20Away.png)

Press the back button and `Developer Options` will now be visible

![Developer Options](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/Developer%20Options.png)

Now switch on `Developer Options` and `USB Debugging`. Then get a USB cable that supports data transfer (preferrably the one in the box) and plug it into the computer.

![USB Debugging](https://github.com/mrhaydendp/Fire-Tools/blob/main/Pictures/USB%20Debugging.png)

## Installer Script
For Linux, WSL, and macOS run this command in terminal:
```
wget https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```
For Windows version go to the [Releases Page](https://github.com/mrhaydendp/Fire-Tools/releases)

## Config Options
This script is very customizable, you can whitelist apps so they're not disabled by deleting them from Debloat.txt.
You can also batch install apps by dropping `.apk` files in the Custom folder and clicking Batch Install in the script.

## Notes
Things you should know:
- Set timezone settings before debloat! 
- You are allowed to fork this script and make your own for your use cases but you have to credit me and link back to this project
- Google Apps are taken from [ApkMirror](https://www.apkmirror.com/) and are updated monthly
- Debloat will disable all amazon apps except `Calculator`, `Camera`, `Clock`, `Files`, `Home`, and `Settings`
- This should not void your warranty but, if unsure factory reset your device before sending it in.
- Although this is my tool, **I am not responsible for anything that may go wrong when using this script.**

## Credits
Thank you to all these people's software included in this script!
- [Google](https://www.android.com/)
- [Aefyr](https://github.com/Aefyr/SAI) (Split APKs Installer)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair)
- [D0k3](https://github.com/d0k3) (For inspiration to make this script)
