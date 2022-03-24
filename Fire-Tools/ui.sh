#!/usr/bin/env sh

# Check for ADB
command -v adb >/dev/null 2>&1 || { echo >&2 "This application requires ADB to be installed, Exiting..."; exit 1; }

# Identify Tablet ID
device=$(adb shell getprop ro.product.model)
    [ "$device" = "KFMUWI" ] && device="Fire 7 (9th Gen)" && sup="1"
    [ "$device" = "KFKAWI" ] && device="Fire HD 8 (8th Gen)" && sup="1"
    [ "$device" = "KFONWI" ] && device="Fire HD 8 (10th Gen)" && sup="1"
    [ "$device" = "KFMAWI" ] && device="Fire HD 10 (9th Gen)" && sup="1"
    [ "$device" = "KFTRWI" ] && device="Fire HD 10 (11th Gen)" && sup="1"
    [ "$sup" != "1" ] && device="Unsupported Device"

# GUI Specs
tool=$(zenity --list \
--title="Fire Tools - $device" \
--width=510 --height=400 \
--column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Install Google Play" \
    "Change Launcher" "Replace Fire Launcher with an alternative launcher" \
    "Disable OTA" "Disable OTA Updates" \
    "Apk Extractor" "Extract .apks from installed applications" \
    "Batch Installer" "Install all .apk or .apkm files in the Batch folder" \
    "Update" "Grab the latest Fire-Tools scripts")

# Debloat Menu
[ "$tool" = "Debloat" ] && exec ./debloat.sh

# Install Google Services 
if [ "$tool" = "Google Services" ]; then
    find ./Gapps/Google*.apk -print0 | xargs -0 -L1 adb install
    for apkm in ./Gapps/Google*.apkm
    do
        unzip "$apkm" -d ./Split
        adb install-multiple ./Split/*.apk
        rm -rf ./Split
    done
fi

# Custom Launcher Menu
[ "$tool" = "Change Launcher" ] && exec ./launcher.sh

# Disable OTA Updates
if [ "$tool" = "Disable OTA" ]; then
    export ota="com.amazon.device.software.ota com.amazon.device.software.ota.override com.amazon.kindle.otter.oobe.forced.ota"
    for package in ${ota}
    do
        adb shell pm disable-user -k "$package" ||
        echo "Failed to Disable OTA Updates"; exec ./ui.sh
    done
    echo "Successfully Disabled OTA Updates"
fi 

# Select Package from List & Extract Package's APK file(s)
[ "$tool" = "Apk Extractor" ] &&
    adb shell pm list packages | cut -f 2 -d ":" > packagelist &&
    package=$(zenity --list --width=500 --height=400 --column=Packages < packagelist) &&
    adb shell pm path "$package" | cut -f 2 -d ":" > Packages.txt &&
    xargs -L1 adb pull < Packages.txt &&
    echo "Finished Extracting App(s)"

# Batch Install
if [ "$tool" = "Batch Installer" ]; then
    find ./Batch/*.apk -print0 | xargs -0 -L1 adb install
    for apkm in ./Batch/*.apkm
    do
        unzip "$apkm" -d ./Split
        adb install-multiple ./Split/*.apk
        rm -rf ./Split
    done &&
    echo "Finished Installing App(s)"

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
    echo "Updating Fire-Tools"
fi

# Exit to Menu When Tool Finishes
[ "$tool" != "" ] && exec ./ui.sh