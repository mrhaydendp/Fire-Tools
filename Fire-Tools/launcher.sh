#!/usr/bin/env sh

adb shell pm list packages -3 > installed

# GUI Specs
launcher=$(zenity --list \
--title="Custom Launcher" \
--width=510 --height=400 \
--column="Launchers" \
    "Nova" \
    "Lawnchair" \
    "Custom")

# Install Selected Launcher
case "$launcher" in
    "Nova" | "Lawnchair")
        adb install -g "$launcher"*;;
    
    "Custom")
        launcher=$(zenity --file-selection) &&
        case "$launcher" in
        *.apk)
            echo "adb install -g $launcher";;
        *.apkm)
            unzip "$launcher" -d ./Split
            adb install-multiple -r -g ./Split/*.apk
            rm -rf ./Split;;
        esac
esac

# If a Launcher is Selected Disable Fire Launcher & Enable Widgets
[ -z "$launcher" ] || {
    adb shell pm list packages -3 > installed.changed;
    launcher=$(diff installed* | grep "<" |awk -F: '{print $2}');
    [ -z "$launcher" ] || adb shell appwidget grantbind --package "$launcher";
    rm installed* --force;
    adb shell pm disable-user -k com.amazon.firelauncher;
    echo "Successfully set Custom Launcher"; 
}
