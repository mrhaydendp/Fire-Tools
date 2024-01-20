# Enable or Disable Specified Package and Provide Clean Output
function debloat {
    if ($args[0] -eq "Disable"){
        adb shell pm disable-user $args[1] *> $null
        if ("$?" -eq "True") {adb shell pm clear $args[1] *> $null}
    } elseif ($args[0] -eq "Enable"){
        adb shell pm enable $args[1] *> $null
    }
    if ("$?" -eq "True"){
        Write-Host "$($args[0])d: $($args[1])"
    } else {
        Write-Host "Failed to $($args[0]): $($args[1])"
    }
}

# If a Package is Specified, Only run Debloat Function
if ($args[1]){
    debloat $args[0] $args[1]
} else {
    # Save Debloat.txt to a Variable & Export Package List
    $disable = Get-Content .\Debloat.txt
    adb shell pm list packages | Out-File packagelist

    # Loop & Check if Package from Debloat.txt is Present in 'packagelist' if so, Send to the Debloat Function with Enable/Disable Option
    foreach ($package in $disable){
        if (Select-String $package.split(' #')[0] .\packagelist){
            debloat $args[0] $package.split(" #")[0]
        }
    }
    if ($args[0] -eq "Enable"){
        Write-Host "Disabling Private DNS"
        adb shell settings put global private_dns_mode off
        Write-Host "Enabling Location Services"
        adb shell settings put global location_global_kill_switch 0
        Write-Host "Enabling Core Apps"
        $core = @("firelauncher", "device.software.ota", "device.software.ota.override", "kindle.otter.oobe.forced.ota")
        foreach ($package in $core){
            debloat Enable com.amazon."$package"
        }
        Write-Host "Enabling Background Activities"
        adb shell settings put global always_finish_activities 0
        Write-Host "Successfully Enabled Fire OS Bloat`n"
    } else {
        Write-Host "Disabling Telemetry & Resetting Advertising ID"
        adb shell settings put secure limit_ad_tracking 1
        adb shell settings put secure usage_metrics_marketing_enabled 0
        adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
        Write-Host "Disabling Location Services"
        adb shell settings put global location_global_kill_switch 1
        Write-Host "Disabling Lockscreen Ads"
        adb shell settings put global LOCKSCREEN_AD_ENABLED 0
        Write-Host "Disabling Search on Lockscreen"
        adb shell settings put secure search_on_lockscreen_settings 0
        Write-Host "Speeding Up Animations"
        adb shell settings put global window_animation_scale 0.50
        adb shell settings put global transition_animation_scale 0.50
        adb shell settings put global animator_duration_scale 0.50
        Write-Host "Successfully Debloated Fire OS`n"
    }
}
