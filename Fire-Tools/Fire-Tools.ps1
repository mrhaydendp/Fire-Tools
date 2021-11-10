#!/bin/powershell

# Device Identifier
$device = (adb shell getprop ro.product.model)
if ( "KFMUWI" -eq $device ) {
    $device = "Fire 7 (9th Gen)"
}
elseif ( "KFKAWI" -eq $device ) {
    $device = "Fire HD 8 (8th Gen)"
}
elseif ( "KFONWI" -eq $device ) {
    $device = "Fire HD 8 (10th Gen)"
}
elseif ( "KFMAWI" -eq $device ) {
    $device = "Fire HD 10 (9th Gen)"
}
elseif ( "KFTRWI" -eq $device ) {
    $device = "Fire HD 10 (11th Gen)"
}
else {
    $device = "Unsupported Device"
}

# UI
Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Fire-Tools - $device"
$Form.StartPosition = "CenterScreen"
$Form.ClientSize = New-Object System.Drawing.Point(445,250)
$Form.BackColor = "Silver"

# Categories
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Debloat"
$Label.Size = New-Object System.Drawing.Size(120,25)
$Label.Location = New-Object System.Drawing.Size(35,15)
$Label.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Form.Controls.Add($Label)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Utilities"
$Label2.Size = New-Object System.Drawing.Size(100,25)
$Label2.Location = New-Object System.Drawing.Size(180,15)
$Label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Form.Controls.Add($Label2)

$Label3 = New-Object System.Windows.Forms.Label
$Label3.Text = "Custom Launchers"
$Label3.Size = New-Object System.Drawing.Size(160,25)
$Label3.Location = New-Object System.Drawing.Size(285,15)
$Label3.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Form.Controls.Add($Label3)

# Debloat Section
$Debloat = New-Object System.Windows.Forms.Button
$Debloat.Text = "Debloat"
$Debloat.Size = New-Object System.Drawing.Size(120,25)
$Debloat.Location = New-Object System.Drawing.Size(5,50)
$Form.Controls.Add($Debloat)

$Rebloat = New-Object System.Windows.Forms.Button
$Rebloat.Text = "Undo Debloat"
$Rebloat.Size = New-Object System.Drawing.Size(120,25)
$Rebloat.Location = New-Object System.Drawing.Size(5,90)
$Form.Controls.Add($Rebloat)

$CustomDebloat = New-Object System.Windows.Forms.Button
$CustomDebloat.Text = "Custom"
$CustomDebloat.Size = New-Object System.Drawing.Size(120,25)
$CustomDebloat.Location = New-Object System.Drawing.Size(5,130)
$Form.Controls.Add($CustomDebloat)

$OTA = New-Object System.Windows.Forms.Button
$OTA.Text = "Disable OTA"
$OTA.Size = New-Object System.Drawing.Size(120,25)
$OTA.Location = New-Object System.Drawing.Size(5,170)
$Form.Controls.Add($OTA)

# Utilities Section
$GoogleServices = New-Object System.Windows.Forms.Button
$GoogleServices.Text = "Google Services"
$GoogleServices.Size = New-Object System.Drawing.Size(120,25)
$GoogleServices.Location = New-Object System.Drawing.Size(150,50)
$Form.Controls.Add($GoogleServices)

$Dark = New-Object System.Windows.Forms.Button
$Dark.Text = "Dark Mode"
$Dark.Size = New-Object System.Drawing.Size(120,25)
$Dark.Location = New-Object System.Drawing.Size(150,90)
$Form.Controls.Add($Dark)

$Batch = New-Object System.Windows.Forms.Button
$Batch.Text = "Batch Install"
$Batch.Size = New-Object System.Drawing.Size(120,25)
$Batch.Location = New-Object System.Drawing.Size(150,130)
$Form.Controls.Add($Batch)

$ApkExtract = New-Object System.Windows.Forms.Button
$ApkExtract.Text = "Apk Extractor"
$ApkExtract.Size = New-Object System.Drawing.Size(120,25)
$ApkExtract.Location = New-Object System.Drawing.Size(150,170)
$Form.Controls.Add($ApkExtract)

# Custom Launchers Section
$Nova = New-Object System.Windows.Forms.Button
$Nova.Text = "Nova"
$Nova.Size = New-Object System.Drawing.Size(120,25)
$Nova.Location = New-Object System.Drawing.Size(295,50)
$Form.Controls.Add($Nova)

$Lawnchair = New-Object System.Windows.Forms.Button
$Lawnchair.Text = "Lawnchair"
$Lawnchair.Size = New-Object System.Drawing.Size(120,25)
$Lawnchair.Location = New-Object System.Drawing.Size(295,90)
$Form.Controls.Add($Lawnchair)

$Custom = New-Object System.Windows.Forms.Button
$Custom.Text = "Custom"
$Custom.Size = New-Object System.Drawing.Size(120,25)
$Custom.Location = New-Object System.Drawing.Size(295,130)
$Form.Controls.Add($Custom)

# Disable Amazon apps
$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    $Disable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Disable) {
    adb shell pm disable-user -k $array
    }
    Write-Host "Disabling Telemetry & Resetting Advertising ID"
    adb shell settings put secure limit_ad_tracking 1
    adb shell settings put secure usage_metrics_marketing_enabled 0
    adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
    adb shell settings put secure advertising_id null
    Write-Host "Disabling Lockscreen Ads"
    adb shell settings put global LOCKSCREEN_AD_ENABLED 0
    Write-Host "Disabling Location"
    adb shell settings put secure location_changer 1
    adb shell settings put secure location_providers_allowed null
    adb shell settings put secure enable_find_my_device -2
    Write-Host "Speeding Up Animations"
    adb shell settings put global window_animation_scale 0.50
    adb shell settings put global transition_animation_scale 0.50
    adb shell settings put global animator_duration_scale 0.50
    Write-Host "Disabling Background Apps"
    adb shell settings put global always_finish_activities 1
    Write-Host "Successfully Debloated Fire OS"
})

# Enable Amazon apps
$Rebloat.Add_Click({
    Write-Host "Enabling Bloat"
    $Enable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Enable) {
    adb shell pm enable $array
    }
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    Write-Host "Successfully Enabled Fire OS Bloat"
})

# Disable OTA updates
$OTA.Add_Click({
    Write-Host "Disabling OTA Updates"
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    Write-Host "Successfully Disabled OTA Updates"
})

# List Enabled Packages & Disable Selections
$CustomDebloat.Add_Click({
    Write-Host "Disabling Selected Packages"
    adb shell pm list packages -e | Out-File Packages.txt
    $list = Get-Content ".\Packages.txt" | ForEach-Object {
        $_.split(":")[1]
    }
    $disable = $list | Out-GridView -OutputMode Multiple
    foreach ($array in $disable) {
        adb shell pm disable-user -k $array
    }
    Write-Host "Successfully Disabled Packages"
})

# Install Google services and display intructions
$GoogleServices.Add_Click({
    Write-Host "Installing Google Services"
    $gapps = (Get-ChildItem .\Gapps\*.apk)
    foreach ($array in $gapps) {
    adb install $array
    }
    $split = (Get-ChildItem .\Gapps\*.apkm)
    foreach($array in $split)
    {
        Copy-Item $array -Destination $array".zip"
        Expand-Archive $array".zip" -DestinationPath .\Split
        $file = (Get-ChildItem .\Split\*.apk)
        adb install-multiple $file
        Remove-Item -r .\Split
        Remove-Item $array".zip"
    }
    Write-Host "Successfully Installed Google Services"
})

# Enable system-wide dark mode
$Dark.Add_Click({
    Write-Host "Enabling System Wide Dark Mode"
    adb shell settings put secure ui_night_mode 2
    Write-Host "Successfully Enabled Dark Mode"
})

# Batch install
$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    $custom = (Get-ChildItem .\Batch\*.apk)
    foreach ($array in $custom) {
    adb install $array
    }
    Write-Host "Successfully Installed All Apps"
})

# List Packages & Extract Selected
$ApkExtract.Add_Click({
    adb shell pm list packages | Out-File Packages.txt
    $list = Get-Content ".\Packages.txt" | ForEach-Object {
        $_.split(":")[1]
    }
    $Extract = $list | Out-GridView -OutputMode Single
    adb shell pm path $Extract | Out-File .\Packages.txt
    $Extract = Get-Content ".\Packages.txt" | ForEach-Object {
        $_.split(":")[1]
    }
    adb pull $Extract
    Write-Host "Extracted Selected Apk"
})

# Set Nova as default launcher
$Nova.Add_Click({
    Write-Host "Changing Default Launcher"
    adb install '.\Nova Launcher.apk'
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

# Set Lawnchair as default launcher
$Lawnchair.Add_Click({
    Write-Host "Changing Default Launcher"
    adb install '.\Lawnchair V2.apk'
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

# Set custom launcher
$Custom.Add_Click({
    Write-Host "Changing Default Launcher"
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $FileBrowser.filter = "Apk (*.apk)| *.apk"
    [void]$FileBrowser.ShowDialog()
    adb install $FileBrowser.FileName
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

$Form.ShowDialog()
