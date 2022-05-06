#!/usr/bin/env sh

# Check for ADB
command -v adb >/dev/null 2>&1 || { echo >&2 "This application requires ADB to be installed, Exiting..."; exit 1; }

# Get Device Name from Amazon Docs Using Model Number, if Device Not Connected Set Model to Null. Cache Website for Subsequent Searches
model=$(adb shell getprop ro.product.model) || model="Null"
[ -e identifying-tablet-devices.html ] ||
curl -o ./identifying-tablet-devices.html "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
device=$(grep -B 2 "$model" < identifying-tablet-devices.html | grep "Fire" | awk '$0=$2' FS=">" RS="<")
[ "$device" = "" ] && device="Unsupported Device"

# Change Application Installation Method Based on the Type of File
appinstaller () {
    case "$1" in
    *.apk)
        adb install -g "$1";;
    *.apkm)
        unzip "$1" -d ./Split
        adb install-multiple -g ./Split/*.apk
        rm -rf ./Split;;
    esac
}

# GUI Specs
tool=$(zenity --list \
--title="Fire Tools - $device" \
--width=510 --height=400 \
--column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Install Google Play" \
    "Change Launcher" "Replace Fire Launcher with alternatives" \
    "Disable OTA" "Disable Fire OS updates" \
    "Apk Extractor" "Extract .apk(s) from installed applications" \
    "Batch Installer" "Install all .apk(m) files in the Batch folder" \
    "Update" "Grab the latest Fire-Tools scripts")

# Debloat Menu
[ "$tool" = "Debloat" ] && exec ./debloat.sh

# Install Google Services 
if [ "$tool" = "Google Services" ]; then
    for gapps in ./Gapps/Google*.apk*
    do
        appinstaller "$gapps"
    done
    echo "Successfully Installed Google Apps"
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
    for apps in ./Batch/*.apkm
    do
        appinstaller "$apps"
    done
    echo "Finished Installing App(s)"

# Updater Tool
elif [ "$tool" = "Update" ]; then
    echo "Latest Changelog:" && curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md
    export modules="Debloat.txt ui.sh debloat.sh launcher.sh"
    for module in ${modules}
    do
        curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/"$module" > "$module"
    done
    echo "Successfully Updated, Restarting Now..."
fi

# Exit to Menu When Tool Finishes
[ "$tool" != "" ] && exec ./ui.sh
