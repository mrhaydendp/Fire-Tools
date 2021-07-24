#!/bin/bash

# User Interface
opt=$(zenity --list --title=Fire-Tools --width=800 --height=500 --column=Option --column=Tool Debloat 'Removes Amazon Apps' \
 'Google-Services' 'Installs Google services and Play Store' 'Change-Launcher' 'Disables fire launcher and replaces it with Nova Launcher' \
  Foss 'Installs free and open source alternatives such as F-Droid, Brave, Lawnchair, and Newpipe' 'Disable-OTA' 'Disables OTA updates' 'Custom-Apps' 'Put .apk files in Custom folder for batch install')

# Options
# Comment out any packages you don't want disabled
if [ $opt = 'Debloat' ]
then
    (
    adb uninstall -k --user 0 amazon.alexa.tablet
    adb uninstall -k --user 0 com.amazon.device.backup
    adb uninstall -k --user 0 com.amazon.device.backup.sdk.internal.library
    adb uninstall -k --user 0 com.amazon.device.crashmanager
    adb uninstall -k --user 0 com.amazon.device.logmanager
    adb uninstall -k --user 0 com.amazon.device.sync
    adb uninstall -k --user 0 com.amazon.device.sync.sdk.internal
    adb uninstall -k --user 0 com.amazon.dp.contacts
    adb uninstall -k --user 0 com.amazon.dp.fbcontacts
    adb uninstall -k --user 0 com.amazon.dp.logger
    adb uninstall -k --user 0 com.amazon.geo.client.maps
    adb uninstall -k --user 0 com.amazon.geo.mapsv2
    adb uninstall -k --user 0 com.amazon.geo.mapsv2.services
    adb uninstall -k --user 0 com.amazon.goodreads.kindle
    adb uninstall -k --user 0 com.amazon.h2settingsfortablet
    adb uninstall -k --user 0 com.amazon.kcp.tutorial
    adb uninstall -k --user 0 com.amazon.kindle
    adb uninstall -k --user 0 com.amazon.kindle.cms
    adb uninstall -k --user 0 com.amazon.kindle.devicecontrols
    adb uninstall -k --user 0 com.amazon.kindle.kso
    adb uninstall -k --user 0 com.amazon.kindle.otter.settings
    adb uninstall -k --user 0 com.amazon.kindle.personal_video
    adb uninstall -k --user 0 com.amazon.kindle.unifiedSearch
    adb uninstall -k --user 0 com.amazon.legalsettings
    adb uninstall -k --user 0 com.amazon.logan
    adb uninstall -k --user 0 com.amazon.mp3
    adb uninstall -k --user 0 com.amazon.ods.kindleconnect
    adb uninstall -k --user 0 com.amazon.parentalcontrols
    adb uninstall -k --user 0 com.amazon.photos
    adb uninstall -k --user 0 com.amazon.photos.importer
    adb uninstall -k --user 0 com.amazon.platform
    adb uninstall -k --user 0 com.amazon.pm
    adb uninstall -k --user 0 com.amazon.precog
    adb uninstall -k --user 0 com.amazon.readynowcore
    adb uninstall -k --user 0 com.amazon.recess
    adb uninstall -k --user 0 com.amazon.socialplatform
    adb uninstall -k --user 0 com.amazon.tahoe
    adb uninstall -k --user 0 com.amazon.unifiedsharefacebook
    adb uninstall -k --user 0 com.amazon.unifiedsharegoodreads
    adb uninstall -k --user 0 com.amazon.unifiedsharesinaweibo
    adb uninstall -k --user 0 com.amazon.unifiedsharetwitter
    adb uninstall -k --user 0 com.amazon.vans.alexatabletshopping.app
    adb uninstall -k --user 0 com.amazon.venezia
    adb uninstall -k --user 0 com.amazon.webapp
    adb uninstall -k --user 0 com.amazon.whisperlink.activityview.android
    adb uninstall -k --user 0 com.amazon.whisperlink.core.android
    adb uninstall -k --user 0 com.android.email
    adb uninstall -k --user 0 com.amazon.whisperplay.contracts
    adb uninstall -k --user 0 com.amazon.windowshop
    adb uninstall -k --user 0 com.amazon.zico
    adb uninstall -k --user 0 com.audible.application.kindle
    adb uninstall -k --user 0 com.goodreads.kindle
    adb uninstall -k --user 0 com.here.odnp.service
    adb uninstall -k --user 0 com.kingsoft.office.amz
    adb uninstall -k --user 0 org.mopria.printplugin
    ) | zenity --progress --title='Debloating Fire OS'
    exec ./Fire-Tools.sh

elif [ $opt = 'Google-Services' ]
then
    (
    for gapps in Gapps/*
    do
     adb install $gapps
    done
    ) | zenity --progress --title='Install Google Services'
    exec ./Fire-Tools.sh

elif [ $opt = 'Change-Launcher' ]
then
    (
    adb install Nova.apk
    adb shell pm disable-user --user 0 com.amazon.firelauncher
    ) | zenity --progress --title='Setting Nova Launcher As Default'
    exec ./Fire-Tools.sh

elif [ $opt = 'Foss' ]
then
    (
    for foss in Foss/*
    do
     adb install $foss
    done
    ) | zenity --progress --title='Installing FOSS Apps'
    exec ./Fire-Tools.sh

elif [ $opt = 'Disable-OTA' ]
then
    (
    adb uninstall -k --user 0 com.amazon.device.software.ota
    adb uninstall -k --user 0 com.amazon.settings.systemupdates
    adb uninstall -k --user 0 com.amazon.kindle.otter.oobe.forced.ota
    ) | zenity --progress --title='Disabling OTA Updates'
    exec ./Fire-Tools.sh
    
elif [ $opt = 'Custom-Apps' ]
then
    (
    for custom in Custom/*
    do
     adb install $custom
    done
    ) | zenity --progress --title='Installing Custom Apps'
    exec ./Fire-Tools.sh
     
else
    clear
fi
