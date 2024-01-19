#!/usr/bin/env sh

# Change ADB Shell Arguments Based on Selection
debloat () {
case "$1" in
    Enable)
        adb shell pm enable "$2" >/dev/null 2>&1;;
    Disable)
        adb shell pm disable-user "$2" >/dev/null 2>&1 && adb shell pm clear "$2" > /dev/null;;
esac
    # [Enable/Disable]d: package || Failed to [Enable/Disable]: Package
    [ "$?" = 0 ] && printf "%sd: $2\n" "$1" || printf "%s\n" "Failed to $1: $2"
}

# If a Package is Specified, Only run Debloat Function
if [ -n "$2" ]; then
    debloat "$1" "$2"
else
    # Save Debloat.txt to a Variable & Export Package List
    packages=$(awk '{print $1}' < Debloat.txt)
    adb shell pm list packages -s > packagelist

    # Loop & Check if Package from Debloat.txt is Present in 'packagelist' if so, Send to the Debloat Function with Enable/Disable Option
    for package in ${packages}; do
        grep -q "$package" < packagelist && debloat "$1" "$package"
    done
    if [ "$1" = "Enable" ]; then
        printf "%s\n" "Enabling Location"
        adb shell settings put secure location_providers_allowed network
        printf "%s\n" "Disabling Private DNS"
        adb shell settings put global private_dns_mode -hostname
        printf "%s\n" "Enabling Core Apps"
        export core="firelauncher device.software.ota device.software.ota.override kindle.otter.oobe.forced.ota"
        for package in ${core}; do
            debloat Enable "com.amazon.$package"
        done
        printf "%s\n\n" "Successfully Enabled Fire OS Bloat"
    else
        printf "%s\n" "Disabling Telemetry & Resetting Advertising ID"
        adb shell settings put secure limit_ad_tracking 1
        adb shell settings put secure usage_metrics_marketing_enabled 0
        adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
        printf "%s\n" "Disabling Location"
        adb shell settings put secure location_providers_allowed -network
        printf "%s\n" "Disabling Lockscreen Ads"
        adb shell settings put global LOCKSCREEN_AD_ENABLED 0
        printf "%s\n" "Disabling Search on Lockscreen"
        adb shell settings put secure search_on_lockscreen_settings 0
        printf "%s\n" "Speeding Up Animations"
        adb shell settings put global window_animation_scale 0.50
        adb shell settings put global transition_animation_scale 0.50
        adb shell settings put global animator_duration_scale 0.50
        printf "%s\n\n" "Successfully Debloated Fire OS"
    fi
fi
