adb shell echo Device Connected

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

$Launcher = New-Object System.Windows.Forms.Label
$Launcher.Text = "Custom Launchers"
$Launcher.Size = New-Object System.Drawing.Size(145,25)
$Launcher.Location = New-Object System.Drawing.Size(150,15)
$Launcher.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$Form.Controls.Add($Launcher)

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

$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    $Disable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Disable) {
    adb shell pm disable-user -k $array
    } Out-Host
    if($?) { Write-Host "Successfully Debloated Fire OS" }
})

$Rebloat.Add_Click({
    Write-Host "Enabling Bloat"
    $Enable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Enable) {
    adb shell pm enable $array
    } Out-Host
    if($?) { Write-Host "Successfully Enabled Bloat" }
})

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
    adb shell monkey -p com.aefyr.sai.fdroid 1
    Write-Host 'When SAI opens tap on Install Apks then choose Internal file
    picker and check the 2 .apkm files. Next click select then press install.'
    Out-Host
    if($?) { Write-Host "Successfully Installed Google Services" }
})

$Dark.Add_Click({
    Write-Host "Enabling System Wide Dark Mode"
    adb shell settings put secure ui_night_mode 2 | Out-Host
    if($?) { Write-Host "Successfully Enabled Dark Mode" }
})

$OTA.Add_Click({
    Write-Host "Disabling OTA Updates"
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.kindle.otter.oobe.forced.ota | Out-Host
    if($?) { Write-Host "Successfully Disabled OTA Updates" }
})

$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    $custom = Get-ChildItem ..\Custom\*.apk
    foreach ($array in $custom) {
    adb install $array
    } Out-Host
    if($?) { Write-Host "Successfully Installed All Apps" }
})

$Nova.Add_Click({
    Write-Host "Changing Default Launcher"
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Nova.apk | Out-Host
    if($?) { Write-Host "Successfully Changed Default Launcher" }
})

$Lawnchair.Add_Click({
    Write-Host "Changing Default Launcher"
    adb shell pm disable-user -k com.amazon.firelauncher
    adb install Lawnchair.apk | Out-Host
    if($?) { Write-Host "Successfully Changed Default Launcher" }
})

$Custom.Add_Click({
    Write-Host "Changing Default Launcher"
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $FileBrowser.filter = "Apk (*.apk)| *.apk"
    [void]$FileBrowser.ShowDialog()
    adb install $FileBrowser.FileName
    adb shell pm disable-user -k com.amazon.firelauncher | Out-Host
    if($?) { Write-Host "Successfully Changed Default Launcher" }
})

$Form.ShowDialog()