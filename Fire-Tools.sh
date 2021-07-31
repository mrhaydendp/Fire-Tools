#!/bin/bash

# Check if there's an ADB connection
adb devices

# User Interface
opt=$(zenity --list --title=Fire-Tools --width=800 --height=500 --column=Option --column=Tool Debloat 'Removes Amazon apps' \
'Undo-Debloat' 'Enables all Amazon apps' 'Google-Services' 'Installs Google services and Play Store' \
'Change-Launcher' 'Disables fire launcher and replaces it with Nova or Lawnchair' \
'Disable-OTA' 'Disables OTA updates' 'Batch-Install' 'Put .apk files in Custom folder for batch install')

# Options
# Delete any packages from Debloat.txt that you don't want disabled
if [ "$opt" = 'Debloat' ]; then
    xargs -l adb shell pm disable-user -k < Debloat.txt
    zenity --notification --text='Successfully Debloated Fire OS'
    exec ./Fire-Tools.sh

elif [ "$opt" = 'Undo-Debloat' ]; then
    xargs -l adb shell pm enable < Debloat.txt
    zenity --notification --text='Successfully Enabled Debloated Packages'
    exec ./Fire-Tools.sh

# Google Services Installer (Download .apk files, push split .apks, launch and instruct SAI)
elif [ "$opt" = 'Google-Services' ]; then
    for gapps in Gapps/*.apk
  do
    adb install "$gapps"
  done
    adb push Gapps/*.apkm /sdcard
    adb shell monkey -p com.aefyr.sai.fdroid 1
    zenity --info --width=350 --height=200 --title='Install Split .apks' --text='When SAI opens tap on Install Apks then choose \
Internal file picker and check the 2 .apkm files. Next click select then press install.'
    zenity --notification --text='Successfully Installed Google Services'
    exec ./Fire-Tools.sh

# Custom Launcher (Disables Fire Launcher and replaces it with Nova or Lawnchair)
elif [ "$opt" = 'Change-Launcher' ]; then
    launcher=$(zenity --list --title='Pick a Launcher' --column=Launchers 'Nova' 'Lawnchair')
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install "$launcher".apk
    zenity --notification --text='Successfully Changed Launcher to '"$launcher"
    exec ./Fire-Tools.sh

# Disable OTA Updates
elif [ "$opt" = 'Disable-OTA' ]; then
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text='Successfully Disabled OTA Updates'
    exec ./Fire-Tools.sh

# Batch Install (Install all .apk files in /Custom folder)    
elif [ "$opt" = 'Batch-Install' ]; then
    for custom in Custom/*.apk
    do
     adb install "$custom"
    done
    zenity --notification --text='Successful Batch Install'
    exec ./Fire-Tools.sh
     
else
    clear
fi
