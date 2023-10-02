#!/usr/bin/env sh

# GUI Specs
launcher=$(zenity --list \
--title="Custom Launcher" \
--width=510 --height=400 \
--column="Launchers" \
    "Nova" \
    "Lawnchair" \
    "Custom")

# Install Selected Launcher
adb shell pm list packages -3 > installed
case "$launcher" in
    "Nova" | "Lawnchair")
        adb install -g "$launcher"*;;
    
    "Custom")
        launcher=$(zenity --file-selection) &&
        case "$launcher" in
        *.apk)
            adb install -g "$launcher";;
        *.apkm)
            unzip "$launcher" -d ./Split
            adb install-multiple -r -g ./Split/*.apk
            rm -rf ./Split;;
        esac
esac

# If a Launcher is Installed Enable Widgets & Disable Fire Launcher
adb shell pm list packages -3 > installed.changed
launcher=$(diff installed* | grep -E -o "[a-z0-9]*(\.[a-z0-9]+)+[a-z0-9]")
[ -z "$launcher" ] || {
    adb shell appwidget grantbind --package "$launcher"
    rm installed* --force
    adb shell pm disable-user -k com.amazon.firelauncher
    adb shell input keyevent KEYCODE_HOME
    printf "%s\n" "Installed Launcher: $launcher"
}

exec ./ui.sh
