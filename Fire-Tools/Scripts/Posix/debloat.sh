#!/usr/bin/env sh

# Set Variables & Export Package List
option="$1"
app="$2"
packages=$(awk '{print $1}' < Debloat.txt)
adb shell pm list packages -s > packagelist

# Change ADB Shell Arguments Based on Selection
debloat () {
    case "$option" in
        Enable)
            adb shell pm enable "$app" >/dev/null 2>&1;;
        Disable)
            adb shell pm disable-user "$app" >/dev/null 2>&1 && adb shell pm clear "$app" > /dev/null;;
    esac
        # Enable/Disable(d): package || Failed to Enable/Disable: package
        [ "$?" = 0 ] && printf "%sd: $app\n" "$option" || printf "%s\n" "Failed to $option: $app"
}

# If a Package is Specified, Only run Debloat Function
if [ -n "$app" ]; then
    debloat "$option" "$app"
elif [ -n "$option" ]; then
    # Loop & Check if Package from Debloat.txt is Present in 'packagelist' if so, Send to the Debloat Function with Enable/Disable Option
    for app in ${packages}; do
        grep -q "$package" < packagelist && debloat "$option" "$app"
    done
    if [ "$option" = "Enable" ]; then
        printf "%s\n" "Disabling Private DNS"
        adb shell settings put global private_dns_mode off
        printf "%s\n" "Enabling Location Services"
        adb shell settings put global location_global_kill_switch 0
        printf "%s\n" "Resetting Background Process Limit"
        adb shell /system/bin/device_config set_sync_disabled_for_tests none
        printf "%s\n" "Enabling Core Apps"
        export core="firelauncher device.software.ota device.software.ota.override kindle.otter.oobe.forced.ota"
        for package in ${core}; do
            debloat Enable "com.amazon.$package"
        done
        printf "%s\n\n" "Successfully Enabled Fire OS Bloat"
    elif [ "$option" = "Disable" ]; then
        printf "%s\n" "Disabling Telemetry & Resetting Advertising ID"
        adb shell settings put secure limit_ad_tracking 1
        adb shell settings put secure usage_metrics_marketing_enabled 0
        adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
        printf "%s\n" "Disabling Location"
        adb shell settings put global location_global_kill_switch 1
        printf "%s\n" "Disabling Lockscreen Ads"
        adb shell settings put global LOCKSCREEN_AD_ENABLED 0
        printf "%s\n" "Disabling Search on Lockscreen"
        adb shell settings put secure search_on_lockscreen_settings 0
        printf "%s\n" "Speeding Up Animations"
        adb shell settings put global window_animation_scale 0.50
        adb shell settings put global transition_animation_scale 0.50
        adb shell settings put global animator_duration_scale 0.50
        printf "%s\n" "Setting Background Process Limit to 4"
        adb shell /system/bin/device_config set_sync_disabled_for_tests persistent
        adb shell /system/bin/device_config put activity_manager max_cached_processes 4
        printf "%s\n\n" "Successfully Debloated Fire OS"
    fi
fi
