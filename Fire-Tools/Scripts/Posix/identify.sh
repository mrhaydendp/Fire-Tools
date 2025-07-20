#!/usr/bin/env sh

# Set Placeholder Values for Device Name & Fire OS Version
device="Not Detected"
fireos="N/A"

# Find Device Name by Regexing Model Number & Subtracting 2 Lines on Amazon Developer Docs, Then get Fire OS Version
if (adb shell echo "Device Found" >/dev/null 2>&1); then
    amazon=$(adb shell getprop ro.build.mktg.fireos)
    if [ -z "$amazon" ]; then
        device="Generic ADB"
    else
        model=$(adb shell getprop ro.product.model)
        [ -e ft-identifying-tablet-devices.html ] || curl -O "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
        device=$(grep -B 2 "$model" < ft-identifying-tablet-devices.html | grep -E -o "(Kindle|Fire) (.*?)[G|g]en\)")
        fireos="$amazon"
    fi
fi
printf "%s\n" "$device" "$fireos"
