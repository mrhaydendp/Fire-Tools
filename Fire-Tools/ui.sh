#!/usr/bin/env sh

version="22.12"

# Check for ADB
command -v adb >/dev/null 2>&1 || { echo >&2 "This application requires ADB to be installed, Exiting..."; exit 1; }

# If Device is Connected Identify Using Amazon Docs Page
device="Not Detected"
if (adb shell echo "Device Connected"); then
    model=$(adb shell getprop ro.product.model)
    [ -e identifying-tablet-devices.html ] || curl -o ./identifying-tablet-devices.html "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
    device=$(grep -B 2 "$model" < identifying-tablet-devices.html | grep -E -o "(Kindle|Fire) (.*?)[G|g]en\)")
    [ -z "$device" ] && device="Unknown/Unsupported"
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

# Invoke Tools by Adding Their Names After ./ui.sh (Ex: ./ui.sh Update), Else Resort to UI
tool="$1"
[ -n "$1" ] || {
    tool=$(zenity --list \
    --title="Fire Tools v$version - $device" \
    --text="Device: $device" \
    --width=510 --height=400 \
    --column="Tool" --column="Description" \
        "Debloat" "Disable or restore Amazon apps" \
        "Google Services" "Install Google Play" \
        "Change Launcher" "Replace Fire Launcher with alternatives" \
        "Disable OTA" "Disable Fire OS updates" \
        "Apk Extractor" "Extract .apk(s) from installed applications" \
        "Batch Installer" "Install all .apk(m) files in the Batch folder" \
        "Custom DNS" "Change Private DNS (DoT) provider" \
        "Update" "Grab the latest Fire-Tools scripts")
}

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
        packages=$(adb shell pm list packages | cut -f2 -d:)
        list=$(zenity --list --width=500 --height=400 --column=Packages $packages)
        [ -z "$list" ] || {
            mkdir ./Extracted >/dev/null 2>&1
            adb shell pm path "$list" | cut -f2 -d: | xargs -I % adb pull % ./Extracted
        };;

    "Batch Installer")
        for apps in ./Batch/*.apkm
        do
            appinstaller "$apps"
        done
        echo "Finished Installing App(s)";;

    "Custom DNS")
        server=$(zenity --entry --width=400 --height=200 --title="Input Private DNS (DoT) Provider" --text="Example Servers:\n- dns.adguard.com\n- security.cloudflare-dns.com\n- dns.quad9.net")
        [ -z "$server" ] || {
            adb shell settings put global private_dns_mode hostname &&
            adb shell settings put global private_dns_specifier "$server" &&
            echo "Successfully Changed Private DNS to: $server" ||
            echo "Failed to Set Private DNS"
        };;

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
