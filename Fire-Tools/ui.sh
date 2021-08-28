#!/bin/bash

# Connection Check
adb shell echo Device Connected

# UI
tool=$(zenity --list \
  --title='Fire Tools' \
  --width=500 --height=400 \
  --column='Tool' --column='Description' \
    'Debloat' 'Disable or restore Amazon apps' \
    'Google Services' 'Installs Google Play' \
    'Change Launcher' 'Replaces Fire Launcher with Nova, Lawnchair, or your own' \
    'Disable OTA' 'Disables OTA Updates' \
    'Dark Mode' 'Enables system wide dark mode' \
    'Batch Installer' 'Installs all .apk files in the Custom folder')

# Debloat menu
if [ "$tool" = 'Debloat' ]; then
    exec ./debloat.sh

# Install Google services
elif [ "$tool" = 'Google Services' ]; then
    ls ../Gapps/*.apk | xargs -I gapps adb install 'gapps'
    adb push ../Gapps/*.apkm /sdcard
    adb shell monkey -p com.aefyr.sai.fdroid 1
    zenity --text-info --title='SAI Instructions' --filename=SAI\ Instructions.txt
    zenity --notification --text='Successfully Installed Google Services'
    exec ./ui.sh

# Launcher menu
elif [ "$tool" = 'Change Launcher' ]; then
    exec ./launcher.sh

# Disable OTA updates
elif [ "$tool" = 'Disable OTA' ]; then
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text='Successfully Disabled OTA Updates'
    exec ./ui.sh

# Enable system-wide dark mode (funky on Fire 7 9th gen)
elif [ "$tool" = 'Dark Mode' ]; then
    adb shell settings put secure ui_night_mode 2
    zenity --notification --text='Successfully Enabled Dark Mode'
    exec ./ui.sh

# Batch Install
elif [ "$tool" = 'Batch Installer' ]; then
    ls ../Custom/*.apk | xargs -I custom adb install 'custom'
    zenity --notification --text='Successful Batch Install'
fi
