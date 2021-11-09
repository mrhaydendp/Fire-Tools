#!/bin/bash

# UI
opt=$(zenity --list \
  --title=Debloat \
  --width=500 --height=400 \
  --column="Option" --column="Description" \
    "Enable" "Enables all Amazon apps" \
    "Disable" "Disables all Amazon apps" \
    "Custom" "Lists installed packages and lets you disable them")

# Enable Apps
if [ "$opt" = "Enable" ]; then
    xargs -l adb shell pm enable < Debloat.txt
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text="Successfully Enabled Fire OS Bloat"

# Disable Apps
elif [ "$opt" = "Disable" ]; then
    xargs -l adb shell pm disable-user -k < Debloat.txt
    adb shell settings put global window_animation_scale 0.50
    adb shell settings put global transition_animation_scale 0.50
    adb shell settings put global animator_duration_scale 0.50
    zenity --notification --text="Successfully Debloated Fire OS"

# List Packages & Disable Apps
elif [ "$opt" = "Custom" ]; then
    adb shell pm list packages -e | cut -f 2 -d ":" > Packages.txt
    list=$(cat Packages.txt | xargs -l)
    disable=$(zenity --list --width=500 --height=400 --column=Packages --multiple $list)
    echo "$disable" | tr '|' '\n' > Packages.txt
    xargs -l adb shell pm disable-user -k < Packages.txt
    zenity --notification --text="Successfully Disabled Packages"
fi
    exec ./ui.sh
