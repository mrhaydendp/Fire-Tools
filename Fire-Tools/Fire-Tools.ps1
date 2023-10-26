$version = "23.10"

# Check if ADB is installed. If not, open documentation
try {
    adb --version; ""
} catch {
    $option = Read-Host "Error: ADB was not Found`nWould you like to open the Docs to help get it installed? (Y/n)"
    if ("$option" -ne "n"){
        Start-Process "https://github.com/mrhaydendp/Fire-Tools/blob/main/Setup-Instructions.md#adb"
    }
    Write-Host "Exiting..."; exit
}

# Set application theme based on AppsUseLightTheme prefrence
$theme = @("#ffffff","#202020","#323232")
if (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme"){
    $theme = @("#292929","#f3f3f3","#fbfbfb")
}

# Wait for device
if (!(adb get-state 2> $null)){
    Write-Host "Please Connect a Fire Tablet`nWaiting for Device..."
    adb wait-for-device
}

# Device identifier (find product name from model number -3 lines)
$device = "Unknown/Undetected"
if (adb shell pm list features | Select-String -Quiet "fireos"){
    $model = (adb shell getprop ro.product.model)
    if (!(Test-Path .\ft-identifying-tablet-devices.html)){
        Invoke-RestMethod "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html" -OutFile ft-identifying-tablet-devices.html
    }
    $modelLine = (Select-String -Pattern "$model" -Path .\ft-identifying-tablet-devices.html).LineNumber
    $device = (Get-Content .\ft-identifying-tablet-devices.html | Select -Index ("$modelLine" - 3) | Select-String "(Kindle|Fire) (.*?)[Gg]en\)").Matches.Value
    Write-Host "Device Detected: $device"
    Write-Host "Software Version: $((adb shell getprop | Select-String "Fire OS (.*?)\.[1-9] ").Matches.Value)`n"
}

function debloat {
    if ($args[0] -eq "Debloat"){
        adb shell pm disable-user $args[1] 2> $null | Out-Host
        if ("$?" -eq "True") {adb shell pm clear $args[1]}
    } elseif ($args[0] -eq "Undo"){
        adb shell pm enable $args[1] 2> $null | Out-Host
    }
    if ("$?" -eq "False") {Write-Host "Failed to $($args[0]): $($args[1])"}
}

# Change Application Installation Method Based on Filetype
function appinstaller {
    Write-Host "Installing: $args"
    if ("$args" -like '*.apk'){
        adb install -g "$args" 2> $null | Out-Host
    } elseif ("$args" -like '*.apk*'){
        Copy-Item "$args" -Destination "$args.zip"
        Expand-Archive "$args.zip" -DestinationPath .\Split
        adb install-multiple -r -g (Get-ChildItem .\Split\*apk) 2> $null | Out-Host
        Remove-Item -r .\Split, "$args.zip"
    }
    if ("$?" -eq "False") {Write-Host "Failed to Install: $args"}
}

# GUI specs
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$form = New-Object System.Windows.Forms.Form
$form.Text = "Fire Tools v$version | Device: $device"
$form.StartPosition = "CenterScreen"
$form.ClientSize = New-Object System.Drawing.Point(800,430)
$form.ForeColor = $theme[0]
$form.BackColor = $theme[1]
$tooltip = New-Object System.Windows.Forms.ToolTip

# Categories
$label = New-Object System.Windows.Forms.Label
$label.Text = "Debloat"
$label.Size = New-Object System.Drawing.Size(100,30)
$label.Location = New-Object System.Drawing.Size(65,10)
$label.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)

$label1 = New-Object System.Windows.Forms.Label
$label1.Text = "Installed Packages"
$label1.Size = New-Object System.Drawing.Size(220,30)
$label1.Location = New-Object System.Drawing.Size(525,10)
$label1.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)

$label2 = New-Object System.Windows.Forms.Label
$label2.Text = "Utilities"
$label2.Size = New-Object System.Drawing.Size(220,30)
$label2.Location = New-Object System.Drawing.Size(295,10)
$label2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',18)

# Buttons
$installedlist = New-Object System.Windows.Forms.ListBox
$installedlist.Size = New-Object System.Drawing.Size(300,200)
$installedlist.Location = New-Object System.Drawing.Size(480,50)
$installedlist.SelectionMode = "MultiExtended"
$installedlist.ForeColor = $theme[0]
$installedlist.BackColor = $theme[2]
$tooltip.SetToolTip($installedlist, "CTRL + Click to Select Multiple Items")

$debloat = New-Object System.Windows.Forms.Button
$debloat.Text = "Debloat"
$debloat.Size = New-Object System.Drawing.Size(180,38)
$debloat.Location = New-Object System.Drawing.Size(20,50)
$debloat.FlatStyle = "0"
$debloat.FlatAppearance.BorderSize = "0"
$debloat.BackColor = $theme[2]
$tooltip.SetToolTip($debloat, "Disable pre-installed bloatware")

$rebloat = New-Object System.Windows.Forms.Button
$rebloat.Text = "Undo"
$rebloat.Size = New-Object System.Drawing.Size(180,38)
$rebloat.Location = New-Object System.Drawing.Size(20,100)
$rebloat.FlatStyle = "0"
$rebloat.FlatAppearance.BorderSize = "0"
$rebloat.BackColor = $theme[2]
$tooltip.SetToolTip($rebloat, "Enable pre-installed bloatware")

$edit = New-Object System.Windows.Forms.Button
$edit.Text = "Edit"
$edit.Size = New-Object System.Drawing.Size(180,38)
$edit.Location = New-Object System.Drawing.Size(20,150)
$edit.FlatStyle = "0"
$edit.FlatAppearance.BorderSize = "0"
$edit.BackColor = $theme[2]
$tooltip.SetToolTip($edit, "Open Debloat.txt in preferred text editor")

$dnsServers = New-Object System.Windows.Forms.ComboBox
$dnsServers.Text = "Select DNS Server"
$dnsServers.Size = New-Object System.Drawing.Size(180,38)
$dnsServers.Location = New-Object System.Drawing.Size(20,276)
$dnsServers.ForeColor = $theme[0]
$dnsServers.BackColor = $theme[2]
$dnsServers.FlatStyle = "0"
$dnsServers.Items.AddRange(@("dns.adguard.com","dns.quad9.net","security.cloudflare-dns.com","None"))
$tooltip.SetToolTip($dnsServers, "Select DoT provider or type one in")

$customdns = New-Object System.Windows.Forms.Button
$customdns.Text = "Set Custom DNS"
$customdns.Size = New-Object System.Drawing.Size(180,38)
$customdns.Location = New-Object System.Drawing.Size(20,310)
$customdns.FlatStyle = "0"
$customdns.FlatAppearance.BorderSize = "0"
$customdns.BackColor = $theme[2]

$googleservices = New-Object System.Windows.Forms.Button
$googleservices.Text = "Install Google Services"
$googleservices.Size = New-Object System.Drawing.Size(180,38)
$googleservices.Location = New-Object System.Drawing.Size(250,50)
$googleservices.FlatStyle = "0"
$googleservices.FlatAppearance.BorderSize = "0"
$googleservices.BackColor = $theme[2]
$tooltip.SetToolTip($googleservices, "Install: Google Services, Play, & Account Manager")

$batchinstall = New-Object System.Windows.Forms.Button
$batchinstall.Text = "Batch Install"
$batchinstall.Size = New-Object System.Drawing.Size(180,38)
$batchinstall.Location = New-Object System.Drawing.Size(250,100)
$batchinstall.FlatStyle = "0"
$batchinstall.FlatAppearance.BorderSize = "0"
$batchinstall.BackColor = $theme[2]
$tooltip.SetToolTip($batchinstall, "Install all .apk(m) files in the Batch folder")

$disableota = New-Object System.Windows.Forms.Button
$disableota.Text = "Disable OTA"
$disableota.Size = New-Object System.Drawing.Size(180,38)
$disableota.Location = New-Object System.Drawing.Size(250,150)
$disableota.FlatStyle = "0"
$disableota.FlatAppearance.BorderSize = "0"
$disableota.BackColor = $theme[2]
$tooltip.SetToolTip($disableota, "Disable Fire OS updates")

$update = New-Object System.Windows.Forms.Button
$update.Text = "Check for Updates"
$update.Size = New-Object System.Drawing.Size(180,38)
$update.Location = New-Object System.Drawing.Size(250,200)
$update.FlatStyle = "0"
$update.FlatAppearance.BorderSize = "0"
$update.BackColor = $theme[2]
$tooltip.SetToolTip($update, "Grab the latest Fire-Tools scripts")

$launchers = New-Object System.Windows.Forms.ComboBox
$launchers.Text = "Select Launcher"
$launchers.Size = New-Object System.Drawing.Size(180,38)
$launchers.Location = New-Object System.Drawing.Size(250,276)
$launchers.ForeColor = $theme[0]
$launchers.BackColor = $theme[2]
$launchers.FlatStyle = "0"
$launchers.Items.AddRange(@("Nova Launcher","Lawnchair","Custom"))

$customlauncher = New-Object System.Windows.Forms.Button
$customlauncher.Text = "Set Custom Launcher"
$customlauncher.Size = New-Object System.Drawing.Size(180,38)
$customlauncher.Location = New-Object System.Drawing.Size(250,310)
$customlauncher.FlatStyle = "0"
$customlauncher.FlatAppearance.BorderSize = "0"
$customlauncher.BackColor = $theme[2]

$disableselected = New-Object System.Windows.Forms.Button
$disableselected.Text = "Disable Selected"
$disableselected.Size = New-Object System.Drawing.Size(180,38)
$disableselected.Location = New-Object System.Drawing.Size(540,260)
$disableselected.FlatStyle = "0"
$disableselected.FlatAppearance.BorderSize = "0"
$disableselected.BackColor = $theme[2]

$enableselected = New-Object System.Windows.Forms.Button
$enableselected.Text = "Enable Selected"
$enableselected.Size = New-Object System.Drawing.Size(180,38)
$enableselected.Location = New-Object System.Drawing.Size(540,310)
$enableselected.FlatStyle = "0"
$enableselected.FlatAppearance.BorderSize = "0"
$enableselected.BackColor = $theme[2]

$extractselected = New-Object System.Windows.Forms.Button
$extractselected.Text = "Extract Selected"
$extractselected.Size = New-Object System.Drawing.Size(180,38)
$extractselected.Location = New-Object System.Drawing.Size(540,360)
$extractselected.FlatStyle = "0"
$extractselected.FlatAppearance.BorderSize = "0"
$extractselected.BackColor = $theme[2]

# Multi-button
$debloatTool = $debloat, $rebloat

# Debloat & package list
$disable = Get-Content .\Debloat.txt
adb shell pm list packages | Out-File packagelist
Get-Content .\packagelist | % { $installedlist.Items.AddRange($_.split(":")[1]) | Out-Null }

# Enable or disable packages (if present) & features based on selection
$debloatTool.Add_Click{
    foreach ($package in $disable){
        debloat $this.text $package.split(" #")[0]
    }
    if ($this.Text -eq "Undo"){
        Write-Host "Disabling Private DNS"
        adb shell settings put global private_dns_mode -hostname
        Write-Host "Enabling Background Activities"
        adb shell settings put global always_finish_activities 0
        Write-Host "Successfully Enabled Fire OS Bloat`n"
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
        Write-Host "Successfully Debloated Fire OS`n"
    }
}

# Open Debloat.txt in preferred text editor
$edit.Add_Click{.\Debloat.txt}

# Set Private DNS provider to selected server
$customdns.Add_Click{
    if ($dnsServers.SelectedItem -eq "None"){
        Write-Host "Disabling Private DNS"
        adb shell settings put global private_dns_mode -hostname
    } elseif ($dnsServers.Text | Select-String -Quiet "dns(\.|[a-z])"){
        if (Test-Connection -Count 1 -Quiet $dnsServers.Text){
            adb shell settings put global private_dns_mode hostname
            adb shell settings put global private_dns_specifier $dnsServers.Text
            Write-Host "Successfully Changed Private DNS to: $($dnsServers.Text)`n"
        } else {
            Write-Host "Error: $($dnsServers.Text) is not a Valid DoT Address`n"
        }
    }
}

# Install Google Services
$googleservices.Add_Click{
    Get-ChildItem .\Gapps\Google*.apk* | ForEach-Object {
        appinstaller "$_"
    }
    appinstaller (Get-ChildItem .\Gapps\*Store*)
    $status = "Failed to Install Google Apps"
    if (adb shell pm list packages -3 | Select-String "google"){
        $status = "Successfully Installed Google Apps"
    }
    Write-Host "$status`n"
}

# Install all .apk(m) files in Batch folder
$batchinstall.Add_Click{
    Get-ChildItem .\Batch\*.apk* | ForEach-Object {
        appinstaller "$_"
    }
}

# Disable OTA apps and check
$disableota.Add_Click{
    $ota = @("com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota")
    foreach ($package in $ota){
        debloat debloat "$package"
    }
    $status = "Failed to Disable OTA Updates"
    if (adb shell pm list packages -d | Select-String "com.amazon.device.software.ota"){
        $status = "Successfully Disabled OTA Updates"
    }
    Write-Host "$status`n"
}

# Check for updates, if available get changelog & scripts
$update.Add_Click{
    $latest = (Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version")
    if ("$version" -lt "$latest"){
        Write-Host "`nLatest Changelog:"; Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md" | Out-Host
        @("Fire-Tools.ps1", "Debloat.txt") | % {
            Invoke-RestMethod "https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/$_" -OutFile "$_"
        }
        Write-Host "Updates Complete, Please Re-launch Application"
        pause; $form.Close()
    }
    Write-Host "No Updates Available`n"
}

# Install selected launcher & disable stock. If custom, open file picker
$customlauncher.Add_Click{
    if ($launchers.SelectedItem -eq "Custom"){
        $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
        $FileBrowser.Title = "Select Launcher .apk(m)"
        $FileBrowser.filter = "Apk (*.apk)| *.apk|Apkm (*.apkm)| *.apkm"
        [void]$FileBrowser.ShowDialog()
        if ($FileBrowser.FileName){
            appinstaller $FileBrowser.FileName
        }
    } else {
        $launcher = $launchers.SelectedItem
        appinstaller (Get-ChildItem "$launcher*.apk")
    }
    if (Get-Content .\packagelist){
        (Compare-Object (Get-Content .\packagelist) (adb shell pm list packages)).inputobject | % {
            if ("$_"){
                adb shell appwidget grantbind --package $_.split(":")[1]
                debloat debloat com.amazon.firelauncher
                adb shell input keyevent KEYCODE_HOME
                Write-Host "Installed Launcher: $($_.split(":")[1])`n"
            }
        }
    }
}

# Disable selected packages
$disableselected.Add_Click{
    foreach ($package in $installedlist.SelectedItems){
        debloat debloat "$package"
    }
}

# Enable selected packages
$enableselected.Add_Click{
    foreach ($package in $installedlist.SelectedItems){
        debloat undo "$package"
    }
}

# Extract selected packages to Extracted\packagename
$extractselected.Add_Click{
    foreach ($package in $installedlist.SelectedItems){
        Write-Host "Extracting: $package"
        New-Item -Type Directory .\Extracted\"$package" -Force
        adb shell pm path "$package" | % {
            adb pull $_.split(":")[1] .\Extracted\"$package" | Out-Host
        }
    }
}

$form.Controls.AddRange(@($label,$label1,$label2,$debloat,$rebloat,$edit,$dnsServers,$customdns,$googleservices,$batchinstall,$disableota,$update,$launchers,$customlauncher,$installedlist,$disableselected,$enableselected,$extractselected))
$form.ShowDialog()
