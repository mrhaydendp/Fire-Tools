#!/bin/bash

# UI
launcher=$(zenity --list \
  --title="Custom Launcher" \
  --width=500 --height=400 \
  --column="Launchers" \
    "Nova" \
    "Lawnchair" \
    "Custom")

# Install Nova Launcher
[ "$launcher" = "Nova" ] &&
    adb install ./"$launcher"*.apk

# Install Lawnchair
[ "$launcher" = "Lawnchair" ] &&
    adb install ./"$launcher"*.apk

# Install Custom Launcher
[ "$launcher" = "Custom" ] &&
    launcher=$(zenity --file-selection) &&
    adb install "$launcher"

# If a Custom Launcher is Selected Disable File Launcher
[ "$launcher" != "" ] &&
    adb shell pm disable-user -k com.amazon.firelauncher &&
    zenity --notification --text="Successfully set Custom Launcher"

exec ./ui.sh
