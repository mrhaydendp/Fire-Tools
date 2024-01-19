#!/usr/bin/env sh

# Change Application Installation Method Based on Filetype
printf "%s\n" "Installing: $1"
case "$1" in
*.apk)
    adb install -g "$1" >/dev/null 2>&1;;
*.apkm)
    unzip "$1" -d ./Split >/dev/null
    adb install-multiple -r -g ./Split/*.apk >/dev/null 2>&1
    rm -rf ./Split;;
esac
[ "$?" = 0 ] && printf "%s\n\n" "Success" || printf "%s\n\n" "Fail"
