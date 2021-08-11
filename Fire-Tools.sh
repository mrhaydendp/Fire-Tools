#!/bin/bash

# Check if there's an ADB connection
adb shell echo Device Connected

# User Interface
opt=$(zenity --list --title=Fire-Tools --width=500 --height=400 --column=Option --column=Tool Debloat 'Removes all Amazon apps' \
'Undo Debloat' 'Enables all Amazon apps' 'Google Services' 'Installs Google services' \
'Change Launcher' 'Replaces Fire Launcher with Nova or Lawnchair' \
'Disable OTA' 'Disables OTA updates' 'Dark Mode' 'Enables system wide dark mode' \
'Batch Install' 'Put .apk files in Custom folder for batch install')

# Options
# Delete any packages from Debloat.txt that you don't want disabled
if [ "$opt" = 'Debloat' ]; then
    xargs -l adb shell pm disable-user -k < Debloat.txt 
    zenity --notification --text='Successfully Debloated Fire OS'
    exec ./Fire-Tools.sh

# Enables all previously disabled bloatware
elif [ "$opt" = 'Undo Debloat' ]; then
    xargs -l adb shell pm enable < Debloat.txt
    zenity --notification --text='Successfully Enabled Debloated Packages'
    exec ./Fire-Tools.sh

# Google Services Installer (Download .apk files, push split .apks, launch and instruct SAI)
elif [ "$opt" = 'Google Services' ]; then
    ls Gapps/*.apk | xargs -I gapps adb install 'gapps'
    adb push Gapps/*.apkm /sdcard
    adb shell monkey -p com.aefyr.sai.fdroid 1
    zenity --info --width=350 --height=200 --title='Install Split .apks' --text='When SAI opens tap on Install Apks then choose \
Internal file picker and check the 2 .apkm files. Next click select then press install.'
    zenity --notification --text='Successfully Installed Google Services'
    exec ./Fire-Tools.sh

# Custom Launcher (Disables Fire Launcher and replaces it with Nova, Lawnchair, or a .apk file)
elif [ "$opt" = 'Change Launcher' ]; then
    launcher=$(zenity --list --title='Pick a Launcher' --column=Launchers 'Nova' 'Lawnchair' 'Custom')
    adb shell pm disable-user -k com.amazon.firelauncher
    if [ "$launcher" = 'Custom' ]; then
        custom=$(zenity --file-selection)
        adb install $custom
    else
        adb install "$launcher".apk
    fi
    zenity --notification --text='Successfully Changed Launcher'
    exec ./Fire-Tools.sh

# Disable OTA Updates
elif [ "$opt" = 'Disable OTA' ]; then
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text='Successfully Disabled OTA Updates'
    exec ./Fire-Tools.sh

# Enables dark mode for all apps that support it
elif [ "$opt" = 'Dark Mode' ]; then
    adb shell settings put secure ui_night_mode 2
    zenity --info --text='Reboot for changes to take effect'
    zenity --notification --text='Successfully Enabled Dark Mode'
    exec ./Fire-Tools.sh

# Batch Install (Install all .apk files in /Custom folder)
elif [ "$opt" = 'Batch Install' ]; then
    ls Custom/*.apk | xargs -I custom adb install 'custom'
    zenity --notification --text='Successful Batch Install'
    exec ./Fire-Tools.sh

else
    clear
fi
