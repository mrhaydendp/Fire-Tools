#!/usr/bin/env sh

# Export Package List to Compare After Installation
adb shell pm list packages -3 > packagelist

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

# Grant Launcher Appwidget Permission & Attempt to Disable Fire Launcher. If Failed, Install LauncherHijack
if [ "$2" = "Launcher" ]; then
    adb shell pm list packages -3 > packagelist.new
    launcher=$(diff packagelist* | grep -E -o "[a-z0-9]*(\.[a-z0-9]+)+[a-z0-9]")
    [ -n "$launcher" ] && adb shell appwidget grantbind --package "$launcher"
    adb shell pm disable-user -k com.amazon.firelauncher >/dev/null 2>&1 ||
    grep -q "com.baronkiko.launcherhijack" ./packagelist || ./Scripts/Posix/appinstaller.sh LauncherHijackV403.apk
fi
