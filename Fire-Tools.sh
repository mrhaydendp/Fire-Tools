#bin/sh

opt=$(zenity --list --title=Fire-Tools --width=800 --height=500 --column=Option --column=Tool Debloat 'Removes Amazon Apps' \
 'Google-Services' 'Installs Google services and Play Store' 'Change-Launcher' 'Disables fire launcher and replaces it with Nova Launcher' \
  Foss 'Installs free and open source alternatives such as F-Droid, Brave, Lawnchair, and Newpipe' 'Disable-OTA' 'Disables OTA updates')

if [ $opt = 'Debloat' ]
then
    echo 'Debloating Fire OS'
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
    exec ./Fire-Tools.sh

elif [ $opt = 'Google-Services' ]
then
    echo 'Install Google Services'
    adb install Gapps/*.apk
    exec ./Fire-Tools.sh

elif [ $opt = 'Change-Launcher' ]
then
    echo 'Setting Nova as default launcher'
    adb install Nova.apk
    adb shell pm disable-user --user 0 com.amazon.firelauncher
    exec ./Fire-Tools.sh

elif [ $opt = 'Foss' ]
then
    echo 'Installing F-Droid, Brave, Lawnchair, and Newpipe'
    adb install Foss/*.apk
    exec ./Fire-Tools.sh

elif [ $opt = 'Disable-OTA' ]
then
    echo 'Disabling OTA Updates'
    adb uninstall -k --user 0 com.amazon.device.software.ota
    adb uninstall -k --user 0 com.amazon.settings.systemupdates
    adb uninstall -k --user 0 com.amazon.kindle.otter.oobe.forced.ota
    exec ./Fire-Tools.sh
else
    echo Bye!
fi
