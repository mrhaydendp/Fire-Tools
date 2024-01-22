# Change Application Installation Method Based on Filetype
Write-Host "Installing: $args" 
if ("$args" -like '*.apk'){
    adb install -g "$args" *> $null
} elseif ("$args" -like '*.apk*'){
    Copy-Item "$args" -Destination "$args.zip"
    Expand-Archive "$args.zip" -DestinationPath .\Split
    adb install-multiple -r -g (Get-ChildItem .\Split\*apk) *> $null
    Remove-Item -r .\Split, "$args.zip"
}
if ("$?" -eq "True"){
    Write-Host "Success"
} else {
    Write-Host "Fail"
}
