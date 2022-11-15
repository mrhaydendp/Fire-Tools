$version = "22.11"

# Set Theme Based on AppsUseLightTheme Prefrence
$theme = @("#ffffff","#202020","#323232")
if (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme"){
    $theme = @("#292929","#f3f3f3","#fbfbfb")
}

# Device Identifier (Find Product Name from Model Number -2 Lines)
$device = "Device is Unknown/Undetected"
if (adb shell echo "Device Connected"){
    $model = adb shell getprop ro.product.model
    if (!(Test-Path .\identifying-tablet-devices.html)){
        Invoke-RestMethod "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html" -OutFile identifying-tablet-devices.html
    }
    $line = Select-String "$model" .\identifying-tablet-devices.html
    Select-String "Kindle.Fire.(.*?)Gen\)|Fire (.*?)Gen\)" .\identifying-tablet-devices.html | % {
    if ( $_.LineNumber -eq $line.LineNumber - 2 ){
        $device = ($_.Matches.Value)
    }
    }
}

# Change ADB Shell Arguments Based on Selection
function debloat {
    if ($args[0] -eq "Debloat"){
        adb shell pm disable-user -k $args[1] | Out-Host
    } elseif ($args[0] -eq "Undo"){
        adb shell pm enable $args[1] | Out-Host
    }
}

# Change Application Installation Method Based on Filetype
function appinstaller {
    if ("$args" -like '*.apk'){
        adb install -r -g "$args" | Out-Host
    } elseif ("$args" -like '*.apkm'){
        Copy-Item "$args" -Destination $args".zip"
        Expand-Archive $args".zip" -DestinationPath .\Split
        adb install-multiple -r -g (Get-ChildItem .\Split\*apk) | Out-Host
        Remove-Item -r .\Split, $args".zip"
    }
}

# GUI Specs
Add-Type -AssemblyName System.Windows.Forms
$tooltip = New-Object System.Windows.Forms.ToolTip
[System.Windows.Forms.Application]::EnableVisualStyles()
$form = New-Object System.Windows.Forms.Form
$form.Text = "Fire Tools v$version - $device"
$form.StartPosition = "CenterScreen"
$form.ClientSize = New-Object System.Drawing.Point(715,410)
$form.ForeColor = $theme[0]
$form.BackColor = $theme[1]

# Categories
$label = New-Object System.Windows.Forms.Label
$label.Text = "Debloat"
$label.Size = New-Object System.Drawing.Size(120,30)
$label.Location = New-Object System.Drawing.Size(60,15)
$label.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$form.Controls.Add($label)

$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Utilities"
$label2.Size = New-Object System.Drawing.Size(120,30)
$label2.Location = New-Object System.Drawing.Size(310,15)
$label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$form.Controls.Add($label2)

$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Custom Launchers"
$label2.Size = New-Object System.Drawing.Size(220,30)
$label2.Location = New-Object System.Drawing.Size(500,15)
$label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$form.Controls.Add($label2)

$label3 = New-Object System.Windows.Forms.Label
$label3.Text = "Miscellaneous"
$label3.Size = New-Object System.Drawing.Size(170,30)
$label3.Location = New-Object System.Drawing.Size(273,260)
$label3.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)
$form.Controls.Add($label3)

# Buttons - Debloat
$debloat = New-Object System.Windows.Forms.Button
$debloat.Text = "Debloat"
$debloat.Size = New-Object System.Drawing.Size(180,38)
$debloat.Location = New-Object System.Drawing.Size(15,60)
$debloat.FlatStyle = "0"
$debloat.FlatAppearance.BorderSize = "0"
$debloat.BackColor = $theme[2]
$tooltip.SetToolTip($debloat, "Disable all Amazon apps")
$form.Controls.Add($debloat)

$rebloat = New-Object System.Windows.Forms.Button
$rebloat.Text = "Undo"
$rebloat.Size = New-Object System.Drawing.Size(180,38)
$rebloat.Location = New-Object System.Drawing.Size(15,110)
$rebloat.FlatStyle = "0"
$rebloat.FlatAppearance.BorderSize = "0"
$rebloat.BackColor = $theme[2]
$tooltip.SetToolTip($rebloat, "Enable all Amazon apps")
$form.Controls.Add($rebloat)

$disableota = New-Object System.Windows.Forms.Button
$disableota.Text = "Disable OTA"
$disableota.Size = New-Object System.Drawing.Size(180,38)
$disableota.Location = New-Object System.Drawing.Size(15,160)
$disableota.FlatStyle = "0"
$disableota.FlatAppearance.BorderSize = "0"
$disableota.BackColor = $theme[2]
$tooltip.SetToolTip($disableota, "Disable Fire OS updates")
$form.Controls.Add($disableota)

$customdebloat = New-Object System.Windows.Forms.Button
$customdebloat.Text = "Custom Debloat"
$customdebloat.Size = New-Object System.Drawing.Size(180,38)
$customdebloat.Location = New-Object System.Drawing.Size(15,210)
$customdebloat.FlatStyle = "0"
$customdebloat.FlatAppearance.BorderSize = "0"
$customdebloat.BackColor = $theme[2]
$tooltip.SetToolTip($customdebloat, "Disable selected packages")
$form.Controls.Add($customdebloat)

# Buttons - Utilities
$googleservices = New-Object System.Windows.Forms.Button
$googleservices.Text = "Install Google Apps"
$googleservices.Size = New-Object System.Drawing.Size(180,38)
$googleservices.Location = New-Object System.Drawing.Size(265,60)
$googleservices.FlatStyle = "0"
$googleservices.FlatAppearance.BorderSize = "0"
$googleservices.BackColor = $theme[2]
$tooltip.SetToolTip($googleservices, "Install Google Play Services")
$form.Controls.Add($googleservices)

$apkextract = New-Object System.Windows.Forms.Button
$apkextract.Text = "Apk Extractor"
$apkextract.Size = New-Object System.Drawing.Size(180,38)
$apkextract.Location = New-Object System.Drawing.Size(265,110)
$apkextract.FlatStyle = "0"
$apkextract.FlatAppearance.BorderSize = "0"
$apkextract.BackColor = $theme[2]
$tooltip.SetToolTip($apkextract, "Extract .apk(s) from installed applications")
$form.Controls.Add($apkextract)

$batchinstall = New-Object System.Windows.Forms.Button
$batchinstall.Text = "Batch Install"
$batchinstall.Size = New-Object System.Drawing.Size(180,38)
$batchinstall.Location = New-Object System.Drawing.Size(265,160)
$batchinstall.FlatStyle = "0"
$batchinstall.FlatAppearance.BorderSize = "0"
$batchinstall.BackColor = $theme[2]
$tooltip.SetToolTip($batchinstall, "Install all .apk(m) files in the Batch folder")
$form.Controls.Add($batchinstall)

# Buttons - Custom Launchers
$lawnchair = New-Object System.Windows.Forms.Button
$lawnchair.Text = "Lawnchair"
$lawnchair.Size = New-Object System.Drawing.Size(180,38)
$lawnchair.Location = New-Object System.Drawing.Size(515,60)
$lawnchair.FlatStyle = "0"
$lawnchair.FlatAppearance.BorderSize = "0"
$lawnchair.BackColor = $theme[2]
$tooltip.SetToolTip($lawnchair, "Set Lawnchair as default launcher")
$form.Controls.Add($lawnchair)

$novalauncher = New-Object System.Windows.Forms.Button
$novalauncher.Text = "Nova Launcher"
$novalauncher.Size = New-Object System.Drawing.Size(180,38)
$novalauncher.Location = New-Object System.Drawing.Size(515,110)
$novalauncher.FlatStyle = "0"
$novalauncher.FlatAppearance.BorderSize = "0"
$novalauncher.BackColor = $theme[2]
$tooltip.SetToolTip($novalauncher, "Set Nova Launcher as default launcher")
$form.Controls.Add($novalauncher)

$customlauncher = New-Object System.Windows.Forms.Button
$customlauncher.Text = "Custom Launcher"
$customlauncher.Size = New-Object System.Drawing.Size(180,38)
$customlauncher.Location = New-Object System.Drawing.Size(515,160)
$customlauncher.FlatStyle = "0"
$customlauncher.FlatAppearance.BorderSize = "0"
$customlauncher.BackColor = $theme[2]
$tooltip.SetToolTip($customlauncher, "Select a launcher .apk(m) from File Explorer")
$form.Controls.Add($customlauncher)

# Buttons - Miscellaneous
$update = New-Object System.Windows.Forms.Button
$update.Text = "Update Scripts"
$update.Size = New-Object System.Drawing.Size(180,38)
$update.Location = New-Object System.Drawing.Size(265,305)
$update.FlatStyle = "0"
$update.FlatAppearance.BorderSize = "0"
$update.BackColor = $theme[2]
$tooltip.SetToolTip($update, "Grab the latest Fire-Tools scripts")
$form.Controls.Add($update)

# Multi-Buttons
$debloattool = $debloat, $rebloat
$launchers = $lawnchair, $novalauncher, $customlauncher

# Deboat & Package List
$disable = [IO.File]::ReadAllLines('.\Debloat.txt')
adb shell pm list packages -s | Out-File packagelist

# Enable or Disable Packages (if Present) & Features Based on Selection
$debloattool.Add_Click{
    foreach ($array in $disable){
        if (Select-String -Quiet $array.split(' #')[0] .\packagelist){
            debloat $this.Text "$array"
        }
    }
    if ($this.Text -eq "Undo"){
        Write-Host "Disabling Adguard DNS"
        adb shell settings put global private_dns_mode -hostname
        Write-Host "Enabling Fire Launcher & OTA Updates"
        adb shell pm enable com.amazon.firelauncher
        adb shell pm enable com.amazon.device.software.ota
        adb shell pm enable com.amazon.device.software.ota.override
        adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
        Write-Host "Enabling Background Activities"
        adb shell settings put global always_finish_activities 0
        Write-Host "Successfully Enabled Fire OS Bloat"
    } else {
        Write-Host "Disabling Telemetry & Resetting Advertising ID"
        adb shell settings put secure limit_ad_tracking 1
        adb shell settings put secure usage_metrics_marketing_enabled 0
        adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
        adb shell pm clear com.amazon.advertisingidsettings
        Write-Host "Disabling Location"
        adb shell settings put secure location_providers_allowed -network
        Write-Host "Blocking Ads With AdGuard DNS"
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
        $ram = (adb shell grep "MemTotal" /proc/meminfo)
        if ("$ram" -replace "[^0-9]" , '' -lt "1500000"){
        Write-Host "Disabling Background Activities (< 1.5GB Ram)"
        adb shell settings put global always_finish_activities 1
        }
        Write-Host "Successfully Debloated Fire OS"
    }
}

# Disable OTA Packages
$disableota.Add_Click{
    $ota = @("com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota")
    foreach ($package in $ota){
        debloat Debloat "$package"
    }
    Write-Host "Successfully Disabled OTA Updates"
}

# Disable Selected Package(s)
$customdebloat.Add_Click{
    adb shell pm list packages -e | ForEach-Object {
        $_.split(":")[1]
    } | Out-GridView -Title "Disable Selected Package(s) (Ctrl + Click to Select Multiple)" -OutputMode Multiple | ForEach-Object {
        debloat Debloat "$_"
    }
    Write-Host "Successfully Disabled Selected Package(s)"
}

# Install Google Services
$googleservices.Add_Click{
    Get-ChildItem .\Gapps\Google*.apk* | ForEach-Object {
        appinstaller "$_"
    }
    appinstaller (Get-ChildItem .\Gapps\*Store*)
    Write-Host "Successfully Installed Google Apps"
}

# Extract Apk from Selected Packages 
$apkextract.Add_Click{
    New-Item .\Extracted -Type Directory -Force
    $extract = (adb shell pm list packages | ForEach-Object {
        $_.split(":")[1]
    } | Out-GridView -Title "Select Application to Extract" -OutputMode Single)
    adb shell pm path "$extract" | ForEach-Object {
        adb pull $_.split(":")[1] .\Extracted
    }
    Write-Host "Successfully Extracted Selected Apk"
}

# Batch Installer
$batchinstall.Add_Click{
    Get-ChildItem .\Batch\*.apk* | ForEach-Object {
        appinstaller "$_"
    }
    Write-Host "Successfully Installed Application(s)"
}

# Set Selection as Default Launcher
$launchers.Add_Click{
    debloat Debloat com.amazon.firelauncher
    if ($this.Text -eq "Custom Launcher"){
        $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
        $FileBrowser.filter = "Apk (*.apk)| *.apk|Apkm (*.apkm)| *.apkm"
        [void]$FileBrowser.ShowDialog()
        appinstaller $FileBrowser.FileName
    } else {
        $package = ($this.Text)
        appinstaller (Get-ChildItem $package*.apk)
    }
    Write-Host "Successfully Changed Default Launcher"
}

# Update Scripts
$update.Add_Click{
    $latest = (Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version")
    if ("$version" -lt "$latest"){
        Write-Host "Latest Changelog:"; Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md" | Out-Host
        $modules = @("Fire-Tools.ps1", "Debloat.txt")
        foreach ($module in $modules){
            Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/$module" -OutFile "$module"
        }
        Write-Host "Successfully Updated, Please Relaunch Application"
    } else {
        Write-Host "No Updates Available"
    }
}

$form.ShowDialog()
