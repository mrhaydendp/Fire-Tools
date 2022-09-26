#!/usr/bin/env sh

version="22.10"

# Check for ADB
command -v adb >/dev/null 2>&1 || { echo >&2 "This application requires ADB to be installed, Exiting..."; exit 1; }

# If Device is Connected Identify Using Amazon Docs Page
device="Device not Detected"
if (adb shell echo "Device Connected"); then
    model=$(adb shell getprop ro.product.model)
    [ -e identifying-tablet-devices.html ] || curl -o ./identifying-tablet-devices.html "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
    device=$(grep -B 2 "$model" < identifying-tablet-devices.html | grep -E -o 'Fire (.*?)\)')
    [ -z "$device" ] && device="Unsupported/Unknown Device"
fi

# Change Application Installation Method Based on Filetype
appinstaller () {
    case "$1" in
    *.apk)
        adb install -r -g "$1";;
    *.apkm)
        unzip "$1" -d ./Split
        adb install-multiple -r -g ./Split/*.apk
        rm -rf ./Split;;
    esac
}

# GUI Specs
tool=$(zenity --list \
--title="Fire Tools v$version - $device" \
--width=510 --height=400 \
--column="Tool" --column="Description" \
    "Debloat" "Disable or restore Amazon apps" \
    "Google Services" "Install Google Play" \
    "Change Launcher" "Replace Fire Launcher with alternatives" \
    "Disable OTA" "Disable Fire OS updates" \
    "Apk Extractor" "Extract .apk(s) from installed applications" \
    "Batch Installer" "Install all .apk(m) files in the Batch folder" \
    "Update" "Grab the latest Fire-Tools scripts")

# Tool Functions
case "$tool" in
    "Debloat")
        exec ./debloat.sh;;

    "Google Services")
        for gapps in ./Gapps/Google*.apk*
        do
            appinstaller "$gapps"
        done
        appinstaller ./Gapps/*Store*
        echo "Successfully Installed Google Apps";;

    "Change Launcher")
        exec ./launcher.sh;;

    "Disable OTA")
        export ota="com.amazon.device.software.ota com.amazon.device.software.ota.override com.amazon.kindle.otter.oobe.forced.ota"
        for package in ${ota}
        do
            adb shell pm disable-user -k "$package" || { echo "Failed to Disable OTA Updates";
            exec ./ui.sh; }
        done
        echo "Successfully Disabled OTA Updates";;

    "Apk Extractor")
        adb shell pm list packages | cut -f 2 -d ":" > packagelist
        package=$(zenity --list --width=500 --height=400 --column=Packages < packagelist) &&
        adb shell pm path "$package" | cut -f 2 -d ":" > Packages.txt &&
        xargs -L1 adb pull < Packages.txt &&
        echo "Finished Extracting App(s)";;

    "Batch Installer")
        for apps in ./Batch/*.apkm
        do
            appinstaller "$apps"
        done
        echo "Finished Installing App(s)";;

    "Update")
        latest=$(curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version)
        [ "$version" != "$latest" ] && {
        echo "Latest Changelogs:" && curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md
        export modules="Debloat.txt ui.sh debloat.sh launcher.sh"
        for module in ${modules}
        do
            curl -sSL "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/$module" > "$module"
        done
        rm ./identifying-tablet-devices.html --force
        echo "Successfully Updated, Reloading Application..."
        } || echo "No Updates Available";;
esac

# Exit to Menu When Tool Finishes
[ -z "$tool" ] || exec ./ui.sh
