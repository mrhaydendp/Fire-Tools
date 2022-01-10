#!/usr/bin/env pwsh

# Set Theme Based on AppsUseLightTheme Prefrence
$theme = @('#fafafa','#202020','#2b2b2b')
if (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme"){
    $theme = @('#363636','#f3f3f3','#fbfbfb')
}

# Device Identifier
$device = (adb shell getprop ro.product.model)
if ( "KFMUWI" -eq $device ) {
    $device = "Fire 7 (9th Gen)"
} elseif ( "KFKAWI" -eq $device ) {
    $device = "Fire HD 8 (8th Gen)"
} elseif ( "KFONWI" -eq $device ) {
    $device = "Fire HD 8 (10th Gen)"
} elseif ( "KFMAWI" -eq $device ) {
    $device = "Fire HD 10 (9th Gen)"
} elseif ( "KFTRWI" -eq $device ) {
    $device = "Fire HD 10 (11th Gen)"
} else {
    $device = "Unsupported Device"
}

# UI
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Fire-Tools - $device"
$Form.StartPosition = "CenterScreen"
$Form.ClientSize = New-Object System.Drawing.Point(715,410)
$Form.ForeColor = $theme[0]
$Form.BackColor = $theme[1]

# Categories
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Debloat"
$Label.Size = New-Object System.Drawing.Size(120,30)
$Label.Location = New-Object System.Drawing.Size(60,15)
$Label.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$Form.Controls.Add($Label)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Utilities"
$Label2.Size = New-Object System.Drawing.Size(120,30)
$Label2.Location = New-Object System.Drawing.Size(310,15)
$Label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$Form.Controls.Add($Label2)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Custom Launchers"
$Label2.Size = New-Object System.Drawing.Size(220,30)
$Label2.Location = New-Object System.Drawing.Size(500,15)
$Label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$Form.Controls.Add($Label2)

$Label3 = New-Object System.Windows.Forms.Label
$Label3.Text = "Miscellaneous"
$Label3.Size = New-Object System.Drawing.Size(170,30)
$Label3.Location = New-Object System.Drawing.Size(275,260)
$Label3.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$Form.Controls.Add($Label3)

# Buttons - Debloat
$Debloat = New-Object System.Windows.Forms.Button
$Debloat.Text = "Debloat"
$Debloat.Size = New-Object System.Drawing.Size(180,38)
$Debloat.Location = New-Object System.Drawing.Size(15,60)
$Debloat.FlatStyle = "0"
$Debloat.FlatAppearance.BorderSize = "0"
$Debloat.BackColor = $theme[2]
$Form.Controls.Add($Debloat)

$Rebloat = New-Object System.Windows.Forms.Button
$Rebloat.Text = "Undo Debloat"
$Rebloat.Size = New-Object System.Drawing.Size(180,38)
$Rebloat.Location = New-Object System.Drawing.Size(15,110)
$Rebloat.FlatStyle = "0"
$Rebloat.FlatAppearance.BorderSize = "0"
$Rebloat.BackColor = $theme[2]
$Form.Controls.Add($Rebloat)

$OTA = New-Object System.Windows.Forms.Button
$OTA.Text = "Disable OTA Updates"
$OTA.Size = New-Object System.Drawing.Size(180,38)
$OTA.Location = New-Object System.Drawing.Size(15,160)
$OTA.FlatStyle = "0"
$OTA.FlatAppearance.BorderSize = "0"
$OTA.BackColor = $theme[2]
$Form.Controls.Add($OTA)

$CustomDebloat = New-Object System.Windows.Forms.Button
$CustomDebloat.Text = "Custom Debloat"
$CustomDebloat.Size = New-Object System.Drawing.Size(180,38)
$CustomDebloat.Location = New-Object System.Drawing.Size(15,210)
$CustomDebloat.FlatStyle = "0"
$CustomDebloat.FlatAppearance.BorderSize = "0"
$CustomDebloat.BackColor = $theme[2]
$Form.Controls.Add($CustomDebloat)

# Buttons - Utilities
$GoogleServices = New-Object System.Windows.Forms.Button
$GoogleServices.Text = "Install Google Apps"
$GoogleServices.Size = New-Object System.Drawing.Size(180,38)
$GoogleServices.Location = New-Object System.Drawing.Size(265,60)
$GoogleServices.FlatStyle = "0"
$GoogleServices.FlatAppearance.BorderSize = "0"
$GoogleServices.BackColor = $theme[2]
$Form.Controls.Add($GoogleServices)

$ApkExtract = New-Object System.Windows.Forms.Button
$ApkExtract.Text = "Apk Extractor"
$ApkExtract.Size = New-Object System.Drawing.Size(180,38)
$ApkExtract.Location = New-Object System.Drawing.Size(265,110)
$ApkExtract.FlatStyle = "0"
$ApkExtract.FlatAppearance.BorderSize = "0"
$ApkExtract.BackColor = $theme[2]
$Form.Controls.Add($ApkExtract)

$Dark = New-Object System.Windows.Forms.Button
$Dark.Text = "System-Wide Dark Mode"
$Dark.Size = New-Object System.Drawing.Size(180,38)
$Dark.Location = New-Object System.Drawing.Size(265,160)
$Dark.FlatStyle = "0"
$Dark.FlatAppearance.BorderSize = "0"
$Dark.BackColor = $theme[2]
$Form.Controls.Add($Dark)

$Batch = New-Object System.Windows.Forms.Button
$Batch.Text = "Batch Install"
$Batch.Size = New-Object System.Drawing.Size(180,38)
$Batch.Location = New-Object System.Drawing.Size(265,210)
$Batch.FlatStyle = "0"
$Batch.FlatAppearance.BorderSize = "0"
$Batch.BackColor = $theme[2]
$Form.Controls.Add($Batch)

# Buttons - Custom Launchers
$Lawnchair = New-Object System.Windows.Forms.Button
$Lawnchair.Text = "Lawnchair"
$Lawnchair.Size = New-Object System.Drawing.Size(180,38)
$Lawnchair.Location = New-Object System.Drawing.Size(515,60)
$Lawnchair.FlatStyle = "0"
$Lawnchair.FlatAppearance.BorderSize = "0"
$Lawnchair.BackColor = $theme[2]
$Form.Controls.Add($Lawnchair)

$Nova = New-Object System.Windows.Forms.Button
$Nova.Text = "Nova Launcher"
$Nova.Size = New-Object System.Drawing.Size(180,38)
$Nova.Location = New-Object System.Drawing.Size(515,110)
$Nova.FlatStyle = "0"
$Nova.FlatAppearance.BorderSize = "0"
$Nova.BackColor = $theme[2]
$Form.Controls.Add($Nova)

$Custom = New-Object System.Windows.Forms.Button
$Custom.Text = "Custom Launcher"
$Custom.Size = New-Object System.Drawing.Size(180,38)
$Custom.Location = New-Object System.Drawing.Size(515,160)
$Custom.FlatStyle = "0"
$Custom.FlatAppearance.BorderSize = "0"
$Custom.BackColor = $theme[2]
$Form.Controls.Add($Custom)

# Buttons - Miscellaneous
$GitHub = New-Object System.Windows.Forms.Button
$GitHub.Text = "GitHub Page"
$GitHub.Size = New-Object System.Drawing.Size(180,38)
$GitHub.Location = New-Object System.Drawing.Size(15,305)
$GitHub.FlatStyle = "0"
$GitHub.FlatAppearance.BorderSize = "0"
$GitHub.BackColor = $theme[2]
$Form.Controls.Add($GitHub)

$Update = New-Object System.Windows.Forms.Button
$Update.Text = "Update Scripts"
$Update.Size = New-Object System.Drawing.Size(180,38)
$Update.Location = New-Object System.Drawing.Size(265,305)
$Update.FlatStyle = "0"
$Update.FlatAppearance.BorderSize = "0"
$Update.BackColor = $theme[2]
$Form.Controls.Add($Update)

$Website = New-Object System.Windows.Forms.Button
$Website.Text = "Website"
$Website.Size = New-Object System.Drawing.Size(180,38)
$Website.Location = New-Object System.Drawing.Size(515,305)
$Website.FlatStyle = "0"
$Website.FlatAppearance.BorderSize = "0"
$Website.BackColor = $theme[2]
$Form.Controls.Add($Website)

$SplitInstaller = New-Object System.Windows.Forms.Button
$SplitInstaller.Text = "Split Apk Installer"
$SplitInstaller.Size = New-Object System.Drawing.Size(180,38)
$SplitInstaller.Location = New-Object System.Drawing.Size(15,355)
$SplitInstaller.FlatStyle = "0"
$SplitInstaller.FlatAppearance.BorderSize = "0"
$SplitInstaller.BackColor = $theme[2]
$Form.Controls.Add($SplitInstaller)

$Recovery = New-Object System.Windows.Forms.Button
$Recovery.Text = "Reboot to Recovery"
$Recovery.Size = New-Object System.Drawing.Size(180,38)
$Recovery.Location = New-Object System.Drawing.Size(265,355)
$Recovery.FlatStyle = "0"
$Recovery.FlatAppearance.BorderSize = "0"
$Recovery.BackColor = $theme[2]
$Form.Controls.Add($Recovery)

# Disable Amazon apps
$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    # Search System for Packages in Debloat.txt, If There Attempt to Disable It
    $Disable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Disable){
        $search = (adb shell pm list packages | Select-String -Pattern $array.Split('#'' ')[0])
        $package = ($search[0] -Split "package:")
        if ($package -ne ""){
            Write-Host "Disabling: $package"
            adb shell pm disable-user -k $package
        }
    }
    Write-Host "Disabling Telemetry & Resetting Advertising ID"
    adb shell settings put secure limit_ad_tracking 1
    adb shell settings put secure usage_metrics_marketing_enabled 0
    adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
    adb shell pm clear com.amazon.advertisingidsettings
    Write-Host "Disabling Location"
    adb shell settings put secure location_providers_allowed -network
    Write-Host "Blocking Ads With Adguard DNS"
    adb shell settings put global private_dns_mode hostname
    adb shell settings put global private_dns_specifier dns.adguard.com
    Write-Host "Disabling Lockscreen Ads"
    adb shell settings put global LOCKSCREEN_AD_ENABLED 0
    Write-Host "Disabling Search on Lockscreen"
    adb shell settings put secure search_on_lockscreen_settings 0
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
    $Disable = [IO.File]::ReadAllLines('.\Debloat.txt')
    foreach ($array in $Disable){
        $search = (adb shell pm list packages | Select-String -Pattern $array.Split('#'' ')[0])
        $package = ($search[0] -Split "package:")
        if ($package -ne ""){
            Write-Host "Enabling: $package"
            adb shell pm enable $package
        }
    }
    Write-Host "Disabling Adguard DNS"
    adb shell settings put global private_dns_mode -hostname
    adb shell settings put global private_dns_specifier -dns.adguard.com
    Write-Host "Enabling Fire Launcher & OTA Updates"
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    Write-Host "Successfully Enabled Fire OS Bloat"
})

# Disable OTA Updates
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

# Install Google services
$GoogleServices.Add_Click({
    Write-Host "Installing Google Services"
    $gapps = (Get-ChildItem .\Gapps\*.apk)
    foreach ($array in $gapps) {
        adb install -g $array
    }
    $split = (Get-ChildItem .\Gapps\*.apkm)
    foreach($array in $split)
    {
        Copy-Item $array -Destination $array".zip"
        Expand-Archive $array".zip" -DestinationPath .\Split
        $file = (Get-ChildItem .\Split\*.apk)
        adb install-multiple -g $file
        Remove-Item -r .\Split
        Remove-Item $array".zip"
    }
    Write-Host "Successfully Installed Google Services"
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

# Enable System-Wide Dark Mode (Funky on Fire 7)
$Dark.Add_Click({
    Write-Host "Enabling System Wide Dark Mode"
    adb shell settings put secure ui_night_mode 2
    Write-Host "Successfully Enabled Dark Mode"
})

# Batch Install
$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    $custom = (Get-ChildItem .\Batch\*.apk)
    foreach ($array in $custom) {
        adb install $array
    }
    Write-Host "Successfully Installed All Apps"
})

# Set Lawnchair as Default Launcher
$Lawnchair.Add_Click({
    Write-Host "Changing Default Launcher"
    $launcher = (Get-ChildItem Lawnchair*)
    adb install -g $launcher
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

# Set Nova as Default Launcher
$Nova.Add_Click({
    Write-Host "Changing Default Launcher"
    $launcher = (Get-ChildItem Nova*)
    adb install -g $launcher
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

# Set Custom Launcher
$Custom.Add_Click({
    Write-Host "Changing Default Launcher"
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $FileBrowser.filter = "Apk (*.apk)| *.apk"
    [void]$FileBrowser.ShowDialog()
    adb install -g $FileBrowser.FileName
    adb shell pm disable-user -k com.amazon.firelauncher
    Write-Host "Successfully Changed Default Launcher"
})

# Open My GitHub Page
$GitHub.Add_Click({
    Start-Process "https://github.com/mrhaydendp"
})

# Grab Latest Fire-Tools Scripts & Show Changelog
$Update.Add_Click({
    $Changelog = (Invoke-RestMethod https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md)
    Write-Host "Latest Changelog:`n $changelog"
    Write-Host "Updating Debloat List"
    Start-BitsTransfer https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Debloat.txt
    Write-Host "Updating Fire-Tools"
    Start-BitsTransfer https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Fire-Tools.ps1
    Write-Host "Please Relaunch Application"
})

# Open My Website
$Website.Add_Click({
    Start-Process "https://mrhaydendp.github.io"
})

# Split Apk Installer
$SplitInstaller.Add_Click({
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://github.com/mrhaydendp/Split-Apk-Installer/raw/main/Split%20Apk%20Installer.ps1'))
})

# Reboot to Recovery
$Recovery.Add_Click({
    Write-Host "Rebooting Into Recovery"
    adb reboot recovery
})

$Form.ShowDialog()
