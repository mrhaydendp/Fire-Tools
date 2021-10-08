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
    zenity --notification --text="Successfully Enabled Debloated Packages"

# Disable Apps
elif [ "$opt" = "Disable" ]; then
    xargs -l adb shell pm disable-user -k < Debloat.txt
    zenity --notification --text="Successfully Debloated Fire OS"

# List Packages & Disable Apps
elif [ "$opt" = "Custom" ]; then
    adb shell pm list packages | cut -f 2 -d ":" > Packages.txt
    list=$(cat CustomDisable.txt | xargs -l)
    disable=$(zenity --list --width=500 --height=400 --column=Packages --multiple $list)
    echo "$disable" | tr '|' '\n' > Packages.txt
    xargs -l adb shell pm disable-user -k < Packages.txt
    zenity --notification --text="Successfully Disabled Packages"
fi
    exec ./ui.sh