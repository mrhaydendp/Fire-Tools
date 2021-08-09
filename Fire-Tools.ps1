Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.ClientSize = New-Object System.Drawing.Point(340,250)
$Form.Text = "Fire-Tools"

$Debloat = New-Object System.Windows.Forms.Button
$Debloat.Text = "Debloat"
$Debloat.Size = New-Object System.Drawing.Size(120,25)
$Debloat.Location = New-Object System.Drawing.Size(5,10)
$Form.Controls.Add($Debloat)

$Undo = New-Object System.Windows.Forms.Button
$Undo.Text = "Coming Soon"
$Undo.Size = New-Object System.Drawing.Size(120,25)
$Undo.Location = New-Object System.Drawing.Size(5,50)
$Form.Controls.Add($Undo)

$Gms = New-Object System.Windows.Forms.Button
$Gms.Text = "Google Services"
$Gms.Size = New-Object System.Drawing.Size(120,25)
$Gms.Location = New-Object System.Drawing.Size(5,90)
$Form.Controls.Add($Gms)

$Launcher = New-Object System.Windows.Forms.Button
$Launcher.Text = "Change Launcher"
$Launcher.Size = New-Object System.Drawing.Size(120,25)
$Launcher.Location = New-Object System.Drawing.Size(5,130)
$Form.Controls.Add($Launcher)

$OTA = New-Object System.Windows.Forms.Button
$OTA.Text = "Disable OTA"
$OTA.Size = New-Object System.Drawing.Size(120,25)
$OTA.Location = New-Object System.Drawing.Size(5,170)
$Form.Controls.Add($OTA)

$Dark = New-Object System.Windows.Forms.Button
$Dark.Text = "Dark Mode"
$Dark.Size = New-Object System.Drawing.Size(120,25)
$Dark.Location = New-Object System.Drawing.Size(160,10)
$Form.Controls.Add($Dark)

$Batch = New-Object System.Windows.Forms.Button
$Batch.Text = "Batch Install"
$Batch.Size = New-Object System.Drawing.Size(120,25)
$Batch.Location = New-Object System.Drawing.Size(160,50)
$Form.Controls.Add($Batch)

$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    adb shell pm disable-user -k com.amazon.photos
    adb shell pm disable-user -k com.amazon.dee.app
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe
    adb shell pm disable-user -k com.kingsoft.office.amz
    adb shell pm disable-user -k com.amazon.diode
    adb shell pm disable-user -k com.amazon.webapp
    adb shell pm disable-user -k com.android.protips
    adb shell pm disable-user -k com.amazon.kindle
    adb shell pm disable-user -k amazon.speech.sim
    adb shell pm disable-user -k com.amazon.kindle.starsight
    adb shell pm disable-user -k com.amazon.geo.client.maps
    adb shell pm disable-user -k com.amazon.geo.mapsv2
    adb shell pm disable-user -k com.amazon.geo.mapsv3.resources
    adb shell pm disable-user -k com.amazon.geo.mapsv3.services
    adb shell pm disable-user -k com.amazon.tcomm
    adb shell pm disable-user -k com.amazon.tcomm.client
    adb shell pm disable-user -k com.amazon.smartgenie
    adb shell pm disable-user -k com.amazon.legalsettings
    adb shell pm disable-user -k amazon.jackson19
    adb shell pm disable-user -k com.amazon.kindle.rdmdeviceadmin
    adb shell pm disable-user -k com.amazon.cloud9
    adb shell pm disable-user -k com.amazon.identity.auth.device.authorization
    adb shell pm disable-user -k com.amazon.minerva.client.api
    adb shell pm disable-user -k com.amazon.fireinputdevices
    adb shell pm disable-user -k com.amazon.dp.fbcontacts
    adb shell pm disable-user -k com.amazon.pm
    adb shell pm disable-user -k com.amazon.ags.app
    adb shell pm disable-user -k com.svox.pico
    adb shell pm disable-user -k amazon.speech.audiostreamproviderservice
    adb shell pm disable-user -k com.amazon.client.metrics.api
    adb shell pm disable-user -k com.amazon.cardinal
    adb shell pm disable-user -k com.amazon.kor.demo
    adb shell pm disable-user -k com.amazon.cloud9.kids
    adb shell pm disable-user -k com.amazon.client.metrics
    adb shell pm disable-user -k com.amazon.recess
    adb shell pm disable-user -k com.amazon.weather
    adb shell pm disable-user -k com.amazon.kindle.unifiedSearch
    adb shell pm disable-user -k com.amazon.windowshop
    adb shell pm disable-user -k com.amazon.whisperplay.service.install
    adb shell pm disable-user -k com.amazon.dpcclient
    adb shell pm disable-user -k amazon.speech.davs.davcservice
    adb shell pm disable-user -k com.android.quicksearchbox
    adb shell pm disable-user -k com.amazon.tv.launcher
    adb shell pm disable-user -k com.amazon.kindle.personal_video
    adb shell pm disable-user -k com.amazon.dp.logger
    adb shell pm disable-user -k com.amazon.device.sync
    adb shell pm disable-user -k com.amazon.mp3
    adb shell pm disable-user -k com.amazon.nimh
    adb shell pm disable-user -k com.amazon.dcp.contracts.framework.library
    adb shell pm disable-user -k com.amazon.whisperlink.core.android
    adb shell pm disable-user -k com.amazon.comms.kids
    adb shell pm disable-user -k com.amazon.device.messaging
    adb shell pm disable-user -k com.amazon.communication.discovery
    adb shell pm disable-user -k com.amazon.cloud9.contentservice
    adb shell pm disable-user -k com.amazon.imp
    adb shell pm disable-user -k com.amazon.logan
    adb shell pm disable-user -k com.amazon.providers.contentsupport
    adb shell pm disable-user -k com.amazon.sync.service
    adb shell pm disable-user -k com.amazon.sync.provider.ipc
    adb shell pm disable-user -k com.amazon.dcp
    adb shell pm disable-user -k com.android.contacts
    adb shell pm disable-user -k com.android.providers.contacts
    adb shell pm disable-user -k com.amazon.dp.contacts
    adb shell pm disable-user -k com.amazon.appaccesskeyprovider
    adb shell pm disable-user -k com.amazon.imdb.tv.mobile.app
    adb shell pm disable-user -k com.amazon.switchaccess.root
    adb shell pm disable-user -k com.amazon.avod
    adb shell pm disable-user -k com.amazon.device.metrics
    adb shell pm disable-user -k com.amazon.kindle.kso
    adb shell pm disable-user -k com.amazon.cloud9.systembrowserprovider
    adb shell pm disable-user -k com.amazon.alexa.youtube.app
    adb shell pm disable-user -k com.amazon.bioscope
    adb shell pm disable-user -k com.amazon.dcp.contracts.library
    adb shell pm disable-user -k com.amazon.application.compatibility.enforcer
    adb shell pm disable-user -k com.amazon.media.session.monitor
    adb shell pm disable-user -k com.amazon.zico
    adb shell pm disable-user -k com.amazon.wirelessmetrics.service
    adb shell pm disable-user -k com.amazon.aca
    adb shell pm disable-user -k com.android.email
    adb shell pm disable-user -k com.goodreads.kindle
    adb shell pm disable-user -k com.amazon.csapp
    adb shell pm disable-user -k com.amazon.wallpaper
    adb shell pm disable-user -k com.amazon.tahoe
    adb shell pm disable-user -k com.android.calendar
    adb shell pm disable-user -k com.android.providers.calendar
    adb shell pm disable-user -k com.amazon.device.settings
    adb shell pm disable-user -k com.android.musicfx
    adb shell pm disable-user -k com.amazon.tv.ottssocompanionapp
    adb shell pm disable-user -k com.android.music
    adb shell pm disable-user -k com.amazon.platform
    adb shell pm disable-user -k com.amazon.kindle.cms
    adb shell pm disable-user -k com.amazon.advertisingidsettings
    adb shell pm disable-user -k com.amazon.venezia
    adb shell pm disable-user -k com.amazon.ods.kindleconnect
    adb shell pm disable-user -k com.android.providers.downloads.ui
    adb shell pm disable-user -k com.audible.application.kindle
    adb shell pm disable-user -k com.amazon.whisperplay.contracts
    adb shell pm disable-user -k com.amazon.iris
    adb shell pm disable-user -k com.amazon.securitysyncclient
    adb shell pm disable-user -k com.amazon.wifilocker | Out-Host
    if($?) { Write-Host "Successfully Debloated Fire OS" }
})

$Undo.Add_Click({
    Write-Host "Enabling Bloat"
    adb devices | Out-Host
    if($?) { Write-Host "Successfully Enabled Bloat" }
})

$Gms.Add_Click({
    Write-Host "Installing Google Services"
    $gapps = ('.\Gapps\Google Account Manger.apk','.\Gapps\Google Services Framework.apk','.\Gapps\SAI.apk')
    foreach ($array in $gapps) {
    adb install $array
    }

    $split = ('.\Gapps\Google Play Services.apkm','.\Gapps\Google Play Store.apkm')
    foreach ($array in $split) {
    adb push $array /sdcard/
    } Out-Host
    if($?) { Write-Host "Successfully Installed Google Services" }
})

$Launcher.Add_Click({
    Write-Host "Changing Default Launcher"
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Nova.apk | Out-Host
    if($?) { Write-Host "Successfully Changed Default Launcher" }
})

$OTA.Add_Click({
    Write-Host "Disabling OTA Updates"
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota | Out-Host
    if($?) { Write-Host "Successfully Disabled OTA Updates" }
})

$Dark.Add_Click({
    Write-Host "Enabling System Wide Dark Mode"
    adb shell settings put secure ui_night_mode 2 | Out-Host
    if($?) { Write-Host "Successfully Enabled Dark Mode" }
})

$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    adb devices | Out-Host
    if($?) { Write-Host "Successfully Installed All Apps" }
})

$Form.ShowDialog()