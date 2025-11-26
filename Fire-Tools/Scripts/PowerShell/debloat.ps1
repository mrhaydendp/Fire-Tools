# Set Variables & Export Package List
$option = $args[0]
$app = $args[1]
$packages = Get-Content .\Debloat.txt | % { $_.Split(" #")[0] }
adb shell pm list packages | Out-File packagelist

# Enable or Disable Specified Package and Provide Clean Output
function debloat {
    if ("$option" -eq "Disable"){
        adb shell pm disable-user "$app" *> $null
        if ("$?" -eq "True") {adb shell pm clear "$app" *> $null}
    } elseif ("$option" -eq "Enable"){
        adb shell pm enable "$app" *> $null
    }
    if ("$?" -eq "True"){Write-Host "$($option)d: $($app)"} else {Write-Host "Failed to $($option): $($app)"}
}

# If a Package is Specified, Only run Debloat Function
if ("$app"){
    debloat "$option" "$app"
} elseif ("$option") {
    # Loop & Check if Package from Debloat.txt is Present in 'packagelist' if so, Send to the Debloat Function with Enable/Disable Option
    foreach ($app in $packages){
        if (Select-String "$app" .\packagelist){
            debloat "$option" "$app"
        }
    }
    if ("$option" -eq "Enable"){
        Write-Host "Disabling Private DNS"
        adb shell settings put global private_dns_mode off
        Write-Host "Enabling Location Services"
        adb shell settings put global location_global_kill_switch 0
        Write-Host "Resetting Background Process Limit"
        adb shell /system/bin/device_config set_sync_disabled_for_tests none
        Write-Host "Enabling Core Apps"
        $core = @("firelauncher", "device.software.ota", "device.software.ota.override", "kindle.otter.oobe.forced.ota")
        foreach ($app in $core){
            debloat Enable "com.amazon.$app"
        }
        Write-Host "Successfully Enabled Fire OS Bloat`n"
    } elseif ("$option" -eq "Disable") {
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
        Write-Host "Setting Background Process Limit to 4"
        adb shell /system/bin/device_config set_sync_disabled_for_tests persistent
        adb shell /system/bin/device_config put activity_manager max_cached_processes 4
        Write-Host "Successfully Debloated Fire OS`n"
    }
}
