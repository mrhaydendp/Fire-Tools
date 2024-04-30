#!/usr/bin/env sh

# Set Placeholder Values for Device Name & Fire OS Version
device="Unknown/Undetected"
fireos="Unknown"

# Find Device Name by Regexing Model Number & Subtracting 2 Lines on Amazon Developer Docs, Then get Fire OS Version
if (adb shell echo "Device Found" >/dev/null 2>&1); then
    model=$(adb shell getprop ro.product.model)
    [ -e ft-identifying-tablet-devices.html ] || curl -O "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html"
    device=$(grep -B 2 "$model" < ft-identifying-tablet-devices.html | grep -E -o "(Kindle|Fire) (.*?)[G|g]en\)")
    fireos=$(adb shell getprop ro.build.mktg.fireos)
fi
printf "%s\n" "$device" "$fireos"