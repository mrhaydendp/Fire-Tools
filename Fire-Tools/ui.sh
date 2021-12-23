#!/usr/bin/env bash

# Show the Message of the Day
curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Motd

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
  --width=510 --height=400 \
  --column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Install Google Play" \
    "Change Launcher" "Replace Fire Launcher with Nova, Lawnchair, or Custom" \
    "Disable OTA" "Disable OTA Updates" \
    "Dark Mode" "Enable system-wide dark mode" \
    "Apk Extractor" "Extract .apks from installed applications" \
    "Batch Installer" "Install all .apks in the Batch folder" \
    "Split Apk Installer" "Install split apks" \
    "Update" "Grab the latest Fire-Tools scripts")

# Exit if No Option is Selected
[ "$tool" = "" ] && exit

# Debloat Menu
[ "$tool" = "Debloat" ] && exec ./debloat.sh

# Install Google Services
if [ "$tool" = "Google Services" ]; then
    find ./Gapps/*.apk -print0 | xargs -0 -l adb install
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
    adb shell pm disable-user -k com.amazon.device.software.ota.override &&
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota &&
    zenity --notification --text="Successfully Disabled OTA Updates" ||
    zenity --notification --text="Failed to Disable OTA Updates" &&
    exec ./ui.sh

# Enable System-Wide Dark Mode (Funky on Fire 7 9th Gen)
[ "$tool" = "Dark Mode" ] &&
    adb shell settings put secure ui_night_mode 2 &&
    zenity --notification --text="Successfully Enabled Dark Mode" &&
    exec ./ui.sh

# Select Package from List & Extract Package's APK file(s)
[ "$tool" = "Apk Extractor" ] &&
    adb shell pm list packages | cut -f 2 -d ":" > packagelist &&
    package=$(zenity --list --width=500 --height=400 --column=Packages < packagelist) &&
    adb shell pm path "$package" | cut -f 2 -d ":" > Packages.txt &&
    xargs -l adb pull < Packages.txt &&
    zenity --notification --text="Successfully Extracted Apk" &&
    exec ./ui.sh

# Batch Install
[ "$tool" = "Batch Installer" ] &&
    find ./Batch/*.apk -print0 | xargs -0 -l adb install &&
    zenity --notification --text="Successfully Installed Apk(s)" &&
    exec ./ui.sh

# Split Apk Installer
if [ "$tool" = "Split Apk Installer" ]; then
    curl -sSL https://github.com/mrhaydendp/Split-Apk-Installer/raw/main/Split%20Apk%20Installer.sh | bash
    exec ./ui.sh

# Updater Tool
elif [ "$tool" = "Update" ]; then
    echo "Latest Changelog:" && curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md
    for sh in *.sh
    do
        echo "Updating $sh"
        curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/"$sh" > "$sh"
    done
    echo "Updating Debloat List"
    curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Debloat.txt > Debloat.txt
    zenity --notification --text="Successfully Updated Fire-Tools" &&
    exec ./ui.sh
fi
