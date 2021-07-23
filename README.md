# Fire-Tools
**Warning These scripts are not reversible and will require a factory reset to undo changes!**

## Features
- Removing stock apps (deboating)
- Install Google Services
- Custom Launchers
- FOSS Apps
- Disabling OTA Updates

![Fire-Tools](https://github.com/mrhaydendp/Fire-Tools/blob/main/Screenshots/Fire%20Tools.png)

## Fire Tablet Prep
### Enable Unkown Sources
Open `Settings` and got to `Security and Lockscreen` and scroll down and enable unknown sources

### Enable Developer Options
Open `Settings` and go to `device options` -> `Serial` and tap it 7 times.
Developer Options tab will now be visable tap it then switch it on at the top.
Scroll down until you find USB Debugging and switch it on


Get a USB cable that supports data transfer (preferrably the one in the box)

## Setup
### Windows (W.I.P)
If you are on Windows drivers for Fire Tablets are found [here](https://developer.amazon.com/docs/fire-tablets/connecting-adb-to-device.html) and ADB drivers are [here](https://adb.clockworkmod.com/).
### Mac
If you are on Mac OS you need install brew through this command
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Then you can install adb through this command `brew cask install android-platform-tool` and wget `brew install wget`

## Instructions
For Linux & Mac clone the repo using git and run Fire-Tools.sh
```
wget https://github.com/mrhaydendp/Fire-Tools/releases/download/Test/Fire-Tools.tar.xz
tar -xf Fire-Tools.tar.xz
cd Fire-Tools && ./Fire-Tools.sh
```

## Notes
Things you should know:
- You are allowed to fork this script and make your own for your use cases
- Google Apps are taken from [ApkMirror](https://www.apkmirror.com/) and are updated monthly
- This will disable all amazon apps except `Clock`, `Calendar`, `Calculator`, `Settings`, and `Keyboard`
- This should not void your warranty but, if unsure factory reset your device before sending it in.
- Although this is my tool, **I am not responsible for anything that may go wrong using this script.**
