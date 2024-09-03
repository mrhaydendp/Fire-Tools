#!/usr/bin/env sh

# Set Variables & Export Package List
app="$1"
option="$2"
adb shell pm list packages -3 > packagelist

# Change Application Installation Method Based on Filetype
printf "%s\n" "Installing: $app"
case "$app" in
*.apk)
    adb install -g "$app" >/dev/null 2>&1;;
*.apkm)
    unzip "$app" -d ./Split >/dev/null
    adb install-multiple -r -g ./Split/*.apk >/dev/null 2>&1
    rm -rf ./Split;;
esac
[ "$?" = 0 ] && printf "%s\n\n" "Success" || printf "%s\n\n" "Fail"

# Grant Launcher Appwidget Permission & Attempt to Disable Fire Launcher. If Failed, Install LauncherHijack
if [ "$option" = "Launcher" ]; then
    adb shell pm list packages -3 > packagelist.new
    if [ -s packagelist ];
        launcher=$(diff packagelist* | grep -E -o "[a-z0-9]*(\.[a-z0-9]+)+[a-z0-9]")
        [ -n "$launcher" ] && adb shell appwidget grantbind --package "$launcher"
    fi
    adb shell pm disable-user -k com.amazon.firelauncher >/dev/null 2>&1 ||
    ./Scripts/Posix/appinstaller.sh LauncherHijackV403.apk
fi
