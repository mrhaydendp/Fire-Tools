## Supported Devices
- Fire HD 10 (9th Gen, 11th Gen)
- Fire HD 8 (8th Gen, 10th Gen)
- Fire 7 (9th Gen)

**Note this tool requires USB Debbuging to be enabled**

Linux/macOS             |  Windows
:-------------------------:|:-------------------------:
![](https://git.io/JuTh6)  |  ![](https://git.io/JuThy)

## Installer Script
For Linux, WSL, and macOS run this command in terminal:
```
wget https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz && rm Fire-Tools.tar.xz
cd Fire-Tools && ./ui.sh
```

For Windows open Powershell and paste these commands:
```
Start-BitsTransfer https://github.com/mrhaydendp/fire-tools/latest/download/Fire-Tools.Windows.zip
Expand-Archive .\Fire-Tools.Windows.zip
```
Then right click on `Fire-Tools.ps1` and open in powershell

## Setup
- [Linux/macOS](https://github.com/mrhaydendp/Fire-Tools/blob/main/Linux-Instructions.md)
- [Windows](https://github.com/mrhaydendp/Fire-Tools/blob/main/Windows-Instructions.md)
- [Fire Tablet](https://github.com/mrhaydendp/Fire-Tools/blob/main/docs/Fire%20Tablet%20Prep.md)
- [Configuration Options](https://github.com/mrhaydendp/Fire-Tools/blob/main/docs/Config%20Options.md)

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
- [Circulosmeos](https://github.com/circulosmeos) (gdown script)
- [Aefyr](https://github.com/Aefyr/SAI) (Split APKs Installer)
- [TeslaCoil Software](https://play.google.com/store/apps/developer?id=TeslaCoil%20Software&hl=en_US&gl=US) (Nova Launcher)
- [Lawnchair](https://github.com/LawnchairLauncher/Lawnchair)
- [D0k3](https://github.com/d0k3) (For inspiration to make this script)
