# Set Theme Based on AppsUseLightTheme Prefrence
$theme = @('#fafafa','#202020','#2b2b2b')
if (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme"){
    $theme = @('#363636','#f3f3f3','#fbfbfb')
}

# Device Identifier Dictionary
$device = (adb shell getprop ro.product.model)
if ( $device -eq "KFKAWI" ){
    $device = "Fire HD 8 (2018, 8th Gen)"
} elseif ( $device -eq "KFMUWI" ){
    $device = "Fire 7 (2019, 9th Gen)"
} elseif ( $device -eq "KFMAWI" ){
    $device = "Fire HD 10 (2019, 9th Gen)"
} elseif ( $device -eq "KFONWI" ){
    $device = "Fire HD 8 (2020, 10th Gen)"
} elseif ( $device -like 'KFTR*WI' ){
    $device = "Fire HD 10 (2021, 11th gen)"
} else {
    $device = "Unsupported Device"
}

function debloat {
    if ($args[0] -eq "Disable"){
        adb shell pm disable-user -k $args[1] | Out-Host
    }
    if ($args[0] -eq "Enable"){
        adb shell pm enable $args[1] | Out-Host
    }    

}
function appinstaller {
    if ($args[0] -like '*.apk'){
        adb install -g $args[0] | Out-Host
    }
    if ($args[0] -like '*.apkm'){
        Copy-Item $args -Destination $args".zip"
        Expand-Archive $args".zip" -DestinationPath .\Split
        $file = (Get-ChildItem .\Split\*.apk)
        adb install-multiple -g $file | Out-Host
        Remove-Item -r .\Split
        Remove-Item $args".zip"
    }
}

# GUI Specs
Add-Type -AssemblyName System.Windows.Forms
$tooltip = New-Object System.Windows.Forms.ToolTip
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
$tooltip.SetToolTip($Debloat, "Disable all Amazon apps")
$Form.Controls.Add($Debloat)

$Rebloat = New-Object System.Windows.Forms.Button
$Rebloat.Text = "Undo Debloat"
$Rebloat.Size = New-Object System.Drawing.Size(180,38)
$Rebloat.Location = New-Object System.Drawing.Size(15,110)
$Rebloat.FlatStyle = "0"
$Rebloat.FlatAppearance.BorderSize = "0"
$Rebloat.BackColor = $theme[2]
$tooltip.SetToolTip($Rebloat, "Enable all Amazon apps")
$Form.Controls.Add($Rebloat)

$OTA = New-Object System.Windows.Forms.Button
$OTA.Text = "Disable OTA Updates"
$OTA.Size = New-Object System.Drawing.Size(180,38)
$OTA.Location = New-Object System.Drawing.Size(15,160)
$OTA.FlatStyle = "0"
$OTA.FlatAppearance.BorderSize = "0"
$OTA.BackColor = $theme[2]
$tooltip.SetToolTip($OTA, "Disable Fire OS updates")
$Form.Controls.Add($OTA)

$CustomDebloat = New-Object System.Windows.Forms.Button
$CustomDebloat.Text = "Custom Debloat"
$CustomDebloat.Size = New-Object System.Drawing.Size(180,38)
$CustomDebloat.Location = New-Object System.Drawing.Size(15,210)
$CustomDebloat.FlatStyle = "0"
$CustomDebloat.FlatAppearance.BorderSize = "0"
$CustomDebloat.BackColor = $theme[2]
$tooltip.SetToolTip($CustomDebloat, "Disable selected packages")
$Form.Controls.Add($CustomDebloat)

# Buttons - Utilities
$GoogleServices = New-Object System.Windows.Forms.Button
$GoogleServices.Text = "Install Google Apps"
$GoogleServices.Size = New-Object System.Drawing.Size(180,38)
$GoogleServices.Location = New-Object System.Drawing.Size(265,60)
$GoogleServices.FlatStyle = "0"
$GoogleServices.FlatAppearance.BorderSize = "0"
$GoogleServices.BackColor = $theme[2]
$tooltip.SetToolTip($GoogleServices, "Install Google Play Services")
$Form.Controls.Add($GoogleServices)

$ApkExtract = New-Object System.Windows.Forms.Button
$ApkExtract.Text = "Apk Extractor"
$ApkExtract.Size = New-Object System.Drawing.Size(180,38)
$ApkExtract.Location = New-Object System.Drawing.Size(265,110)
$ApkExtract.FlatStyle = "0"
$ApkExtract.FlatAppearance.BorderSize = "0"
$ApkExtract.BackColor = $theme[2]
$tooltip.SetToolTip($ApkExtract, "Extract .apk(s) from installed applications")
$Form.Controls.Add($ApkExtract)

$Batch = New-Object System.Windows.Forms.Button
$Batch.Text = "Batch Install"
$Batch.Size = New-Object System.Drawing.Size(180,38)
$Batch.Location = New-Object System.Drawing.Size(265,160)
$Batch.FlatStyle = "0"
$Batch.FlatAppearance.BorderSize = "0"
$Batch.BackColor = $theme[2]
$tooltip.SetToolTip($Batch, "Install all .apk(m) files in the Batch folder")
$Form.Controls.Add($Batch)

# Buttons - Custom Launchers
$Lawnchair = New-Object System.Windows.Forms.Button
$Lawnchair.Text = "Lawnchair"
$Lawnchair.Size = New-Object System.Drawing.Size(180,38)
$Lawnchair.Location = New-Object System.Drawing.Size(515,60)
$Lawnchair.FlatStyle = "0"
$Lawnchair.FlatAppearance.BorderSize = "0"
$Lawnchair.BackColor = $theme[2]
$tooltip.SetToolTip($Lawnchair, "Set Lawnchair as default launcher")
$Form.Controls.Add($Lawnchair)

$Nova = New-Object System.Windows.Forms.Button
$Nova.Text = "Nova Launcher"
$Nova.Size = New-Object System.Drawing.Size(180,38)
$Nova.Location = New-Object System.Drawing.Size(515,110)
$Nova.FlatStyle = "0"
$Nova.FlatAppearance.BorderSize = "0"
$Nova.BackColor = $theme[2]
$tooltip.SetToolTip($Nova, "Set Nova Launcher as default launcher")
$Form.Controls.Add($Nova)

$Custom = New-Object System.Windows.Forms.Button
$Custom.Text = "Custom Launcher"
$Custom.Size = New-Object System.Drawing.Size(180,38)
$Custom.Location = New-Object System.Drawing.Size(515,160)
$Custom.FlatStyle = "0"
$Custom.FlatAppearance.BorderSize = "0"
$Custom.BackColor = $theme[2]
$tooltip.SetToolTip($Custom, "Select a local default launcher")
$Form.Controls.Add($Custom)

# Buttons - Miscellaneous
$GitHub = New-Object System.Windows.Forms.Button
$GitHub.Text = "GitHub Page"
$GitHub.Size = New-Object System.Drawing.Size(180,38)
$GitHub.Location = New-Object System.Drawing.Size(15,305)
$GitHub.FlatStyle = "0"
$GitHub.FlatAppearance.BorderSize = "0"
$GitHub.BackColor = $theme[2]
$tooltip.SetToolTip($GitHub, "Link to my GitHub")
$Form.Controls.Add($GitHub)

$Update = New-Object System.Windows.Forms.Button
$Update.Text = "Update Scripts"
$Update.Size = New-Object System.Drawing.Size(180,38)
$Update.Location = New-Object System.Drawing.Size(265,305)
$Update.FlatStyle = "0"
$Update.FlatAppearance.BorderSize = "0"
$Update.BackColor = $theme[2]
$tooltip.SetToolTip($Update, "Update Fire Tools' scripts")
$Form.Controls.Add($Update)

$Website = New-Object System.Windows.Forms.Button
$Website.Text = "Website"
$Website.Size = New-Object System.Drawing.Size(180,38)
$Website.Location = New-Object System.Drawing.Size(515,305)
$Website.FlatStyle = "0"
$Website.FlatAppearance.BorderSize = "0"
$Website.BackColor = $theme[2]
$tooltip.SetToolTip($Website, "Link to my website")
$Form.Controls.Add($Website)

# Deboat List
$Disable = [IO.File]::ReadAllLines('.\Debloat.txt')

# Disable Amazon apps
$Debloat.Add_Click({
    Write-Host "Debloating Fire OS"
    # Search System for Packages in Debloat.txt, If There Attempt to Disable It
    foreach ($array in $Disable){
        debloat Disable $array
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
    adb shell settings put global private_dns_specifier "dns.adguard.com"
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
    foreach ($array in $Disable){
        debloat Enable $array
    }
    Write-Host "Disabling Adguard DNS"
    adb shell settings put global private_dns_mode -hostname
    Write-Host "Enabling Fire Launcher & OTA Updates"
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.device.software.ota.override
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    Write-Host "Successfully Enabled Fire OS Bloat"
})

# Disable OTA Updates
$OTA.Add_Click({
    Write-Host "Disabling OTA Updates"
    adb shell pm disable-user -k com.amazon.device.software.ota
    adb shell pm disable-user -k com.amazon.device.software.ota.override
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
    $gapps = (Get-ChildItem .\Gapps\Google*.apk*)
    foreach ($array in $gapps) {
        appinstaller $array
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

# Batch Install
$Batch.Add_Click({
    Write-Host "Batch Installing Apps"
    $custom = (Get-ChildItem .\Batch\*.apk*)
    foreach ($array in $custom) {
        appinstaller $array
    }
    Write-Host "Successfully Installed Application(s)"
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
    Write-Host "Latest Changelog:"; Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md" | Out-Host
    Write-Host "Updating Fire-Tools & Debloat List"
    Start-BitsTransfer "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Fire-Tools.ps1"
    Start-BitsTransfer "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/Debloat.txt"
    Write-Host "Updates Complete! Please Relaunch Application"
})

# Open My Website
$Website.Add_Click({
    Start-Process "https://mrhaydendp.github.io"
})

$Form.ShowDialog()
