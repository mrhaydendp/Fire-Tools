#!/bin/bash

# UI
launcher=$(zenity --list \
    --title='Custom Launcher' \
    --width=500 --height=400 \
    --column='Launchers' \
    'Nova' \
    'Lawnchair' \
    'Custom')

# Install Nova
if [ "$launcher" = 'Nova' ]; then
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install ../$launcher.apk

# Install Lawnchair
elif [ "$launcher" = 'Lawnchair' ]; then
    echo adb shell pm disable-user -k com.amazon.firelauncher
    echo adb install ../$launcher.apk

# Install custom launcher
elif [ "$launcher" = 'Custom' ]; then
    adb shell pm disable-user -k com.amazon.firelauncher
    launcher=$(zenity --file-selection)
    adb install $launcher
fi
    zenity --notification --text='Successfully Set Custom Launcher'
    exec ./ui.sh