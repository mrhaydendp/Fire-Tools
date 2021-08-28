#!/bin/powershell

# Check ADB connection
adb shell echo Device Connected

# UI
Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Fire-Tools"
$Form.ClientSize = New-Object System.Drawing.Point(340,250)
$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#b8b8b8")

$Debloat = New-Object System.Windows.Forms.Button
$Debloat.Text = "Debloat"
$Debloat.Size = New-Object System.Drawing.Size(120,25)
$Debloat.Location = New-Object System.Drawing.Size(5,10)
$Form.Controls.Add($Debloat)

$Rebloat = New-Object System.Windows.Forms.Button
$Rebloat.Text = "Undo Debloat"
$Rebloat.Size = New-Object System.Drawing.Size(120,25)
$Rebloat.Location = New-Object System.Drawing.Size(5,50)
$Form.Controls.Add($Rebloat)

$GoogleServices = New-Object System.Windows.Forms.Button
$GoogleServices.Text = "Google Services"
$GoogleServices.Size = New-Object System.Drawing.Size(120,25)
$GoogleServices.Location = New-Object System.Drawing.Size(5,90)
$Form.Controls.Add($GoogleServices)

$Dark = New-Object System.Windows.Forms.Button
$Dark.Text = "Dark Mode"
$Dark.Size = New-Object System.Drawing.Size(120,25)
$Dark.Location = New-Object System.Drawing.Size(5,130)
$Form.Controls.Add($Dark)

$OTA = New-Object System.Windows.Forms.Button
$OTA.Text = "Disable OTA"
$OTA.Size = New-Object System.Drawing.Size(120,25)
$OTA.Location = New-Object System.Drawing.Size(5,170)
$Form.Controls.Add($OTA)

$Batch = New-Object System.Windows.Forms.Button
$Batch.Text = "Batch Install"
$Batch.Size = New-Object System.Drawing.Size(120,25)
$Batch.Location = New-Object System.Drawing.Size(5,210)
$Form.Controls.Add($Batch)

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Custom Launchers"
$Label.Size = New-Object System.Drawing.Size(145,25)
$Label.Location = New-Object System.Drawing.Size(150,15)
$Label.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Form.Controls.Add($Label)

$Nova = New-Object System.Windows.Forms.Button
$Nova.Text = "Nova"
$Nova.Size = New-Object System.Drawing.Size(120,25)
$Nova.Location = New-Object System.Drawing.Size(160,50)
$Form.Controls.Add($Nova)

$Lawnchair = New-Object System.Windows.Forms.Button
$Lawnchair.Text = "Lawnchair"
$Lawnchair.Size = New-Object System.Drawing.Size(120,25)
$Lawnchair.Location = New-Object System.Drawing.Size(160,90)
$Form.Controls.Add($Lawnchair)

$Custom = New-Object System.Windows.Forms.Button
$Custom.Text = "Custom"
$Custom.Size = New-Object System.Drawing.Size(120,25)
$Custom.Location = New-Object System.Drawing.Size(160,130)
$Form.Controls.Add($Custom)

# Disable Amazon apps
$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    $Disable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Disable) {
    adb shell pm disable-user -k $array
    }
    Write-Host "Successfully Debloated Fire OS"
})

# Enable Amazon apps
$Rebloat.Add_Click({
    Write-Host "Enabling Bloat"
    $Enable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Enable) {
    adb shell pm enable $array
    }
    Write-Host "Successfully Enabled Bloat"
})

# Install Google services
$GoogleServices.Add_Click({
    Write-Host "Installing Google Services"
    $gapps = Get-ChildItem ..\Gapps\*.apk
    foreach ($array in $gapps) {
    adb install $array
    }
    $split = Get-ChildItem ..\Gapps\*.apkm
    foreach ($array in $split) {
    adb push $array /sdcard/
    }
    adb shell monkey -p com.aefyr.sai 1
    Write-Host 'When SAI opens tap on Install Apks then choose Internal file
    picker and check the 2 .apkm files. Next click select then press install.'
    Write-Host "Successfully Installed Google Services"
})

# Enable system-wide dark mode
$Dark.Add_Click({
    Write-Host "Enabling System Wide Dark Mode"
    adb shell settings put secure ui_night_mode 2
    Write-Host "Successfully Enabled Dark Mode"
})

# Disable OTA updates
$OTA.Add_Click({
    Write-Host "Disabling OTA Updates"
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota
    Write-Host "Successfully Disabled OTA Updates"
})

# Batch install
$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    $custom = Get-ChildItem ..\Custom\*.apk
    foreach ($array in $custom) {
    adb install $array
    }
    Write-Host "Successfully Installed All Apps"
})

# Set Nova as default launcher
$Nova.Add_Click({
    Write-Host "Changing Default Launcher"
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Nova.apk
    Write-Host "Successfully Changed Default Launcher"
})

# Set Lawnchair as default launcher
$Lawnchair.Add_Click({
    Write-Host "Changing Default Launcher"
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Lawnchair.apk
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
