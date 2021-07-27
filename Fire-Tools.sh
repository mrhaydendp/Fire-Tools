#!/bin/bash

# Check if there's an ADB connection
adb devices

# User Interface
opt=$(zenity --list --title=Fire-Tools --width=800 --height=500 --column=Option --column=Tool Debloat 'Removes Amazon Apps' \
 'Google-Services' 'Installs Google services and Play Store' 'Change-Launcher' 'Disables fire launcher and replaces it with Nova Launcher' \
  'Disable-OTA' 'Disables OTA updates' 'Custom-Apps' 'Put .apk files in Custom folder for batch install')


# Options
# Comment out any packages you don't want disabled
if [ "$opt" = 'Debloat' ]
then
    (
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
    ) | zenity --progress --title='Debloating Fire OS'
    exec ./Fire-Tools.sh

# Google Services Installer
elif [ "$opt" = 'Google-Services' ]
then
    for gapps in Gapps/*.apk
  do
    adb install "$gapps"
  done
    adb push Gapps/*.apkm /sdcard
    adb shell monkey -p com.aefyr.sai.fdroid 1
    zenity --list --column=Instructions --width=400 --height=250 'When SAI opens tap on Install Apks then choose' 'Internal file picker and check the 2 .apkm files'
    exec ./Fire-Tools.sh

# Custom Launcher (Disables Fire Launcher and replaces it with Launcher.apk)
elif [ "$opt" = 'Change-Launcher' ]
then
    (
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Launcher.apk
    ) | zenity --progress --title='Setting Nova as default launcher'
    exec ./Fire-Tools.sh

# Disable OTA Updates
elif [ "$opt" = 'Disable-OTA' ]
then
    (
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.settings.systemupdates
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    ) | zenity --progress --title='Disabling OTA Updates'
    exec ./Fire-Tools.sh

# Batch Install (Install all .apk files in /Custom folder)    
elif [ "$opt" = 'Custom-Apps' ]
then
    (
    for custom in Custom/*
    do
     adb install "$custom"
    done
    ) | zenity --progress --title='Installing Custom Apps'
    exec ./Fire-Tools.sh
     
else
    clear
fi
