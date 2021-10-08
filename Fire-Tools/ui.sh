#!/bin/bash

# Connection Check
adb shell echo Device Connected

# UI
tool=$(zenity --list \
  --title="Fire Tools" \
  --width=500 --height=400 \
  --column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Installs Google Play" \
    "Change Launcher" "Replaces Fire Launcher with Nova, Lawnchair, or your own" \
    "Disable OTA" "Disables OTA Updates" \
    "Dark Mode" "Enables system wide dark mode" \
    "Apk Extractor" "Extracts .apks from installed applicaations" \
    "Batch Installer" "Installs all .apk files in the Custom folder")

# Debloat Menu
if [ "$tool" = "Debloat" ]; then
    exec ./debloat.sh

# Install Google Services
elif [ "$tool" = "Google Services" ]; then
    ls ./Gapps/*.apk | xargs -I gapps adb install "gapps"
    adb push ./Gapps/*.apkm /sdcard
    adb shell monkey -p com.aefyr.sai 1
    zenity --text-info --title="SAI Instructions" --filename=SAI\ Instructions.txt
    zenity --notification --text="Successfully Installed Google Services"
    exec ./ui.sh

# Launcher Menu
elif [ "$tool" = "Change Launcher" ]; then
    exec ./launcher.sh

# Disable OTA Updates
elif [ "$tool" = "Disable OTA" ]; then
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text="Successfully Disabled OTA Updates"
    exec ./ui.sh

# Enable System-Wide Dark Mode (Funky on Fire 7 9th Gen)
elif [ "$tool" = "Dark Mode" ]; then
    adb shell settings put secure ui_night_mode 2
    zenity --notification --text="Successfully Enabled Dark Mode"
    exec ./ui.sh

# Select Package from List & Extract Package's APK file(s)
elif [ "$tool" = "Apk Extractor" ]; then
    adb shell pm list packages | cut -f 2 -d ":" > Packages.txt
    list=$(cat Packages.txt | xargs -l)
    Extract=$(zenity --list --width=500 --height=400 --column=Packages $list)
    adb shell pm path $Extract | cut -f 2 -d ":" > Packages.txt
    xargs -l adb pull < Packages.txt
    exec ./ui.sh

# Batch Install
elif [ "$tool" = "Batch Installer" ]; then
    ls ./Batch/*.apk | xargs -I custom adb install "custom"
    zenity --notification --text="Successful Batch Install"
    exec ./ui.sh
fi