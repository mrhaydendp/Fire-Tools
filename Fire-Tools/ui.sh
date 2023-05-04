#!/usr/bin/env sh

version="23.05"

# Check for Dependencies
export dependencies="adb zenity"
for dependency in ${dependencies}; do
    "$dependency" --version >/dev/null || { echo "Error Dependency Required: $dependency"; exit 1; }
done

# If Device is Running Fire OS Identify Using Amazon Docs Page (Cache Until Next Update)
device="Not Detected"
if (adb shell pm list features | grep -q "fireos"); then
    model=$(adb shell getprop ro.product.model)
    [ -e ft-identifying-tablet-devices.html ] || curl -O "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
    device=$(grep -B 2 "$model" < ft-identifying-tablet-devices.html | grep -E -o "(Kindle|Fire) (.*?)[G|g]en\)")
    [ -z "$device" ] && device="Unknown/Unsupported"
fi

# Change Application Installation Method Based on Filetype
appinstaller () {
    case "$1" in
    *.apk)
        adb install -g "$1";;
    *.apkm)
        unzip "$1" -d ./Split
        adb install-multiple -r -g ./Split/*.apk
        rm -rf ./Split;;
    esac
}

# Invoke Tools by Adding Their Names After ./ui.sh (Ex: ./ui.sh Update) Else, Resort to UI
tool="$1"
[ -n "$1" ] || {
    tool=$(zenity --list \
    --title="Fire Tools v$version" \
    --text="Device: $device" \
    --width=510 --height=400 \
    --column="Tool" --column="Description" \
        "Debloat" "Disable/enable Amazon bloat" \
        "Google Services" "Install Google services" \
        "Change Launcher" "Replace stock launcher" \
        "Disable OTA" "Disable OTA updates" \
        "Apk Extractor" "Extract .apk files from installed apps" \
        "Batch Installer" "Install all .apk(m) files in the Batch folder" \
        "Custom DNS" "Change Private DNS provider" \
        "Update" "Update scripts and debloat list")
}

# Tool Functions
case "$tool" in
    "Debloat")
        exec ./debloat.sh;;

    "Google Services")
        for gapps in ./Gapps/Google*.apk*; do
            appinstaller "$gapps"
        done
        appinstaller ./Gapps/*Store*
        installed=$(adb shell pm list packages com.android.vending)
        [ -n "$installed" ] && echo "Successfully Installed Google Apps";;

    "Change Launcher")
        exec ./launcher.sh;;

    "Disable OTA")
        export ota="com.amazon.device.software.ota com.amazon.device.software.ota.override com.amazon.kindle.otter.oobe.forced.ota"
        for package in ${ota}; do
            adb shell pm disable-user -k "$package" || { echo "Failed to Disable OTA Updates"; exec ./ui.sh; }
        done
        echo "Successfully Disabled OTA Updates";;

    "Apk Extractor")
        packages=$(adb shell pm list packages | cut -f2 -d:)
        list=$(zenity --list --width=500 --height=400 --column=Packages  --multiple $packages | tr '|' '\n')
        for package in ${list}; do
            mkdir -p ./Extracted/"$package"
            adb shell pm path "$package" | cut -f2 -d: | xargs -I % adb pull % ./Extracted/"$package"
        done;;

    "Batch Installer")
        for apps in ./Batch/*.apk*
        do
            appinstaller "$apps"
        done
        echo "Finished Installing App(s)";;

    "Custom DNS")
        server=$(zenity --entry --width=400 --height=200 --title="Input Private DNS (DoT) Provider" --text="Example Servers:\n- dns.adguard.com\n- security.cloudflare-dns.com\n- dns.quad9.net")
        [ -z "$server" ] ||
        if (ping -q -c 1 "$server" > /dev/null); then
            adb shell settings put global private_dns_mode hostname
            adb shell settings put global private_dns_specifier "$server"
            echo "Successfully Changed Private DNS to: $server"
        fi;;
        
    "Update")
        latest=$(curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version)
        [ "$version" != "$latest" ] && {
        echo "Latest Changelogs:" && curl -sSL https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md
        export modules="Debloat.txt ui.sh debloat.sh launcher.sh"
        for module in ${modules}; do
            curl -LO "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/$module"
        done
        rm ./ft-identifying-tablet-devices.html --force
        echo "Successfully Updated, Reloading Application..."
        } || echo "No Updates Available";;
esac

# Exit to Menu When Tool Finishes
[ -z "$tool" ] || exec ./ui.sh
