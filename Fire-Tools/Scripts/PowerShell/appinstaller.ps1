# Set Variables & Export Package List
$app = $args[0]
$option = $args[1]
adb shell pm list packages -3 | Out-File packagelist

# Change ADB Shell Arguments Based on Selection
Write-Host "Installing: $app"
if ("$app" -like '*.apk'){
    adb install -g "$app" *> $null
} elseif ("$app" -like '*.apk*'){
    Copy-Item "$app" -Destination "$app.zip"
    Expand-Archive "$app.zip" -DestinationPath .\Split
    adb install-multiple -r -g (Get-ChildItem .\Split\*apk) *> $null
    Remove-Item -r .\Split, "$app.zip"
}
if ("$?" -eq "True"){Write-Host "Success`n"} else {Write-Host "Fail`n"}

# Grant Launcher Appwidget Permission & Attempt to Disable Fire Launcher. If Failed, Install LauncherHijack
if ("$option" -eq "Launcher"){
    (Compare-Object (Get-Content .\packagelist) (adb shell pm list packages -3)).InputObject | Select -First 1 | % {
        adb shell appwidget grantbind --package "$_".split(":")[1]
    }
    adb shell pm disable-user -k com.amazon.firelauncher *> $null
    if ("$?" -eq "False") {powershell -ExecutionPolicy Bypass -file .\Scripts\PowerShell\appinstaller.ps1 .\LauncherHijackV403.apk}
}
