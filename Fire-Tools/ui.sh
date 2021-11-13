#!/bin/bash

# Identify Device & List Model
device=$(adb shell getprop ro.product.model)
    [ "$device" = "KFMUWI" ] && device="Fire 7 (9th Gen)" && sup="1"
    [ "$device" = "KFKAWI" ] && device="Fire HD 8 (8th Gen)" && sup="1"
    [ "$device" = "KFONWI" ] && device="Fire HD 8 (10th Gen)" && sup="1"
    [ "$device" = "KFMAWI" ] && device="Fire HD 10 (9th Gen)" && sup="1"
    [ "$device" = "KFTRWI" ] && device="Fire HD 10 (11th Gen)" && sup="1"
    [ "$sup" != "1" ] && device="Unsupported Device"

# UI
tool=$(zenity --list \
  --title="Fire Tools - $device" \
  --width=500 --height=400 \
  --column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Installs Google Play" \
    "Change Launcher" "Replaces Fire Launcher with Nova, Lawnchair, or Custom" \
    "Disable OTA" "Disables OTA Updates" \
    "Dark Mode" "Enables system wide dark mode" \
    "Apk Extractor" "Extracts .apks from installed applications" \
    "Batch Installer" "Installs all .apks in the Batch folder" \
    "Update" "Grab the Fire-Tools scripts")

# Debloat Menu
[ "$tool" = "Debloat" ] && exec ./debloat.sh

# Install Google Services
if [ "$tool" = "Google Services" ]; then
    ls ./Gapps/*.apk | xargs -l adb install
    for apkm in ./Gapps/*.apkm
    do
        unzip "$apkm" -d ./Split
        adb install-multiple ./Split/*.apk
        rm -rf ./Split
    done
    zenity --notification --text="Successfully Installed Google Services"
    exec ./ui.sh
fi

# Custom Launcher Menu
[ "$tool" = "Change Launcher" ] && exec ./launcher.sh

# Disable OTA Updates
[ "$tool" = "Disable OTA" ] &&
    adb shell pm disable-user -k com.amazon.device.software.ota &&
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota &&
    zenity --notification --text="Successfully Disabled OTA Updates" &&
    exec ./ui.sh

# Enable System-Wide Dark Mode (Funky on Fire 7 9th Gen)
[ "$tool" = "Dark Mode" ] &&
    adb shell settings put secure ui_night_mode 2 &&
    zenity --notification --text="Successfully Enabled Dark Mode" &&
    exec ./ui.sh

# Select Package from List & Extract Package's APK file(s)
[ "$tool" = "Apk Extractor" ] &&
    list=$(adb shell pm list packages | cut -f 2 -d ":" | xargs -l) &&
    package=$(zenity --list --width=500 --height=400 --column=Packages $list) &&
    adb shell pm path "$package" | cut -f 2 -d ":" > Packages.txt &&
    xargs -l adb pull < Packages.txt &&
    zenity --notification --text="Successfully Extracted Apk" &&
    exec ./ui.sh

# Batch Install
[ "$tool" = "Batch Installer" ] &&
    ls ./Batch/*.apk | xargs -l adb install &&
    exec ./ui.sh

# Updater Tool
if [ "$tool" = "Update" ]; then
    changelog=$(echo "Latest Changelog:" && curl -sSL https://github.com/mrhaydendp/Fire-Tools/commit/main | sed '/<pre>/,/pre>/!d;//d' | grep "-" && echo "- See Full Changelog at https://github.com/mrhaydendp/Fire-Tools/commit/main")
    echo "$changelog"
    for sh in *.sh
    do
        curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/$sh > $sh
    done
    curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Debloat.txt > Debloat.txt
fi
