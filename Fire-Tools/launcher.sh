#!/bin/bash

# UI
launcher=$(zenity --list \
  --title="Custom Launcher" \
  --width=500 --height=400 \
  --column="Launchers" \
    "Nova" \
    "Lawnchair" \
    "Custom")

# Install Nova
if [ "$launcher" = "Nova" ]; then
    adb install ./$launcher*.apk
    adb shell pm disable-user -k com.amazon.firelauncher

# Install Lawnchair
elif [ "$launcher" = "Lawnchair" ]; then
    adb install ./$launcher*.apk
    adb shell pm disable-user -k com.amazon.firelauncher

# Install Custom Launcher
elif [ "$launcher" = "Custom" ]; then
    launcher=$(zenity --file-selection)
    adb install $launcher
    adb shell pm disable-user -k com.amazon.firelauncher
fi
    zenity --notification --text="Successfully set Custom Launcher"
    exec ./ui.sh
