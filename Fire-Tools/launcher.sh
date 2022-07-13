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
case "$launcher" in
    "Nova" | "Lawnchair")
        adb install -g "$launcher";;
    
    "Custom")
        launcher=$(zenity --file-selection) &&
        adb install -g "$launcher";;
esac

# If a Launcher is Selected Disable Fire Launcher
[ -z "$launcher" ] || {
    adb shell pm disable-user -k com.amazon.firelauncher;
    echo "Successfully set Custom Launcher"; 
    }

exec ./ui.sh