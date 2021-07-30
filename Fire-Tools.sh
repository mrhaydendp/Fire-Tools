#!/bin/bash

# Check if there's an ADB connection
adb devices

# User Interface
opt=$(zenity --list --title=Fire-Tools --width=800 --height=500 --column=Option --column=Tool Debloat 'Removes Amazon Apps' \
'Google-Services' 'Installs Google services and Play Store' 'Change-Launcher' 'Disables fire launcher and replaces it with Nova or Lawnchair' \
'Disable-OTA' 'Disables OTA updates' 'Batch-Install' 'Put .apk files in Custom folder for batch install')

# Options
# Comment out any packages you don't want disabled
if [ "$opt" = 'Debloat' ]
then
    adb shell pm disable-user -k amazon.alexa.tablet
    adb shell pm disable-user -k com.amazon.device.backup
    adb shell pm disable-user -k com.amazon.device.backup.sdk.internal.library
    adb shell pm disable-user -k com.amazon.device.crashmanager
    adb shell pm disable-user -k com.amazon.device.logmanager
    adb shell pm disable-user -k com.amazon.device.sync
    adb shell pm disable-user -k com.amazon.device.sync.sdk.internal
    adb shell pm disable-user -k com.amazon.dp.contacts
    adb shell pm disable-user -k com.amazon.dp.fbcontacts
    adb shell pm disable-user -k com.amazon.dp.logger
    adb shell pm disable-user -k com.amazon.geo.client.maps
    adb shell pm disable-user -k com.amazon.geo.mapsv2
    adb shell pm disable-user -k com.amazon.geo.mapsv2.services
    adb shell pm disable-user -k com.amazon.goodreads.kindle
    adb shell pm disable-user -k com.amazon.h2settingsfortablet
    adb shell pm disable-user -k com.amazon.kcp.tutorial
    adb shell pm disable-user -k com.amazon.kindle
    adb shell pm disable-user -k com.amazon.kindle.cms
    adb shell pm disable-user -k com.amazon.kindle.devicecontrols
    adb shell pm disable-user -k com.amazon.kindle.kso
    adb shell pm disable-user -k com.amazon.kindle.otter.settings
    adb shell pm disable-user -k com.amazon.kindle.personal_video
    adb shell pm disable-user -k com.amazon.kindle.unifiedSearch
    adb shell pm disable-user -k com.amazon.legalsettings
    adb shell pm disable-user -k com.amazon.logan
    adb shell pm disable-user -k com.amazon.mp3
    adb shell pm disable-user -k com.amazon.ods.kindleconnect
    adb shell pm disable-user -k com.amazon.parentalcontrols
    adb shell pm disable-user -k com.amazon.photos
    adb shell pm disable-user -k com.amazon.photos.importer
    adb shell pm disable-user -k com.amazon.platform
    adb shell pm disable-user -k com.amazon.pm
    adb shell pm disable-user -k com.amazon.precog
    adb shell pm disable-user -k com.amazon.readynowcore
    adb shell pm disable-user -k com.amazon.recess
    adb shell pm disable-user -k com.amazon.socialplatform
    adb shell pm disable-user -k com.amazon.tahoe
    adb shell pm disable-user -k com.amazon.unifiedsharefacebook
    adb shell pm disable-user -k com.amazon.unifiedsharegoodreads
    adb shell pm disable-user -k com.amazon.unifiedsharesinaweibo
    adb shell pm disable-user -k com.amazon.unifiedsharetwitter
    adb shell pm disable-user -k com.amazon.vans.alexatabletshopping.app
    adb shell pm disable-user -k com.amazon.venezia
    adb shell pm disable-user -k com.amazon.webapp
    adb shell pm disable-user -k com.amazon.whisperlink.activityview.android
    adb shell pm disable-user -k com.amazon.whisperlink.core.android
    adb shell pm disable-user -k com.android.email
    adb shell pm disable-user -k com.amazon.whisperplay.contracts
    adb shell pm disable-user -k com.amazon.windowshop
    adb shell pm disable-user -k com.amazon.zico
    adb shell pm disable-user -k com.audible.application.kindle
    adb shell pm disable-user -k com.goodreads.kindle
    adb shell pm disable-user -k com.here.odnp.service
    adb shell pm disable-user -k com.kingsoft.office.amz
    adb shell pm disable-user -k org.mopria.printplugin
    zenity --notification --text='Successfully Debloated Fire OS'
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
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    adb shell pm disable-user -k com.amazon.device.software.ota
    zenity --notification --text='Successfully Disabled OTA Updates'
    exec ./Fire-Tools.sh

# Batch Install (Install all .apk files in /Custom folder)    
elif [ "$opt" = 'Batch-Install' ]; then
    for custom in Custom/*
    do
     adb install "$custom"
    done
    zenity --notification --text='Successful Batch Install'
    exec ./Fire-Tools.sh
     
else
    clear
fi
