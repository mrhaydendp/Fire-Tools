#!/usr/bin/env sh

# GUI Specs
launcher=$(zenity --list \
  --title="Custom Launcher" \
  --width=500 --height=400 \
  --column="Launchers" \
    "Nova" \
    "Lawnchair" \
    "Custom")

# Install Selected Launcher (Nova or Lawnchair)
if [ "$launcher" = "Nova" ] || [ "$launcher" = "Lawnchair" ]; then
    adb install -g ./"$launcher"*.apk
fi

# Install Custom Launcher
[ "$launcher" = "Custom" ] &&
    launcher=$(zenity --file-selection) &&
    adb install -g "$launcher"

# If a Custom Launcher is Selected Disable File Launcher
[ "$launcher" != "" ] &&
    adb shell pm disable-user -k com.amazon.firelauncher &&
    echo "Successfully set Custom Launcher"

exec ./ui.sh