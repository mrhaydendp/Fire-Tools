#!/usr/bin/env sh

# GUI Specs
opt=$(zenity --list \
--title="Debloat" \
--width=500 --height=400 \
--column="Option" --column="Description" \
    "Enable" "Enables All Amazon Apps" \
    "Disable" "Disables All Amazon Apps" \
    "Custom" "Lists Installed Packages & Lets You Disable Them")

# Debloat List
packages=$(awk '{print $1}' < Debloat.txt)

# Enable Apps
if [ "$opt" = "Enable" ]; then
    for package in ${packages}
    do
        adb shell pm enable "$package" 2> /dev/null ||
        echo "Failed to Enable: $package"
    done
    echo "Disabling Adguard DNS"
    adb shell settings put global private_dns_mode -hostname
    adb shell settings put global private_dns_specifier -dns.adguard.com
    echo "Enabling Fire Launcher & OTA Updates"
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.device.software.ota.override
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    echo "Successfully Enabled Fire OS Bloat"

# Disable Apps
elif [ "$opt" = "Disable" ]; then
    for package in ${packages}
    do
        adb shell pm disable-user -k "$package" 2> /dev/null ||
        echo "Failed to Disable: $package"
    done
    echo "Disabling Telemetry & Resetting Advertising ID"
    adb shell settings put secure limit_ad_tracking 1
    adb shell settings put secure usage_metrics_marketing_enabled 0
    adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
    adb shell pm clear com.amazon.advertisingidsettings
    echo "Disabling Location"
    adb shell settings put secure location_providers_allowed -network
    echo "Blocking Ads With Adguard DNS"
    adb shell settings put global private_dns_mode hostname
    adb shell settings put global private_dns_specifier dns.adguard.com
    echo "Disabling Lockscreen Ads"
    adb shell settings put global LOCKSCREEN_AD_ENABLED 0
    echo "Disabling Search on Lockscreen"
    adb shell settings put secure search_on_lockscreen_settings 0
    echo "Speeding Up Animations"
    adb shell settings put global window_animation_scale 0.50
    adb shell settings put global transition_animation_scale 0.50
    adb shell settings put global animator_duration_scale 0.50
    echo "Disabling Background Apps"
    adb shell settings put global always_finish_activities 1
    echo "Successfully Debloated Fire OS"
fi

# List Packages & Disable Apps
[ "$opt" = "Custom" ] &&
    adb shell pm list packages -e | cut -f 2 -d ":" > packagelist &&
    disable=$(zenity --list --width=500 --height=400 --column=Packages --multiple < packagelist) &&
    echo "$disable" | tr '|' '\n' > Packages.txt &&
    xargs -L1 adb shell pm disable-user -k < Packages.txt &&
    echo "Successfully Disabled Package(s)"

exec ./ui.sh