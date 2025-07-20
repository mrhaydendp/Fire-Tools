# Set Placeholder Values for Device Name & Fire OS Version
$device = "Not Detected"
$fireos = "N/A"

# Find Device Name by Regexing Model Number & Subtracting 3 Lines on Amazon Developer Docs, Then get Fire OS Version
if (adb shell echo "Device Found" 2> $null){
    if (!(adb shell getprop ro.build.mktg.fireos)){
        $device = "Generic ADB"
    }
    $model = (adb shell getprop ro.product.model)
    if (!(Test-Path .\ft-identifying-tablet-devices.html)){
        Invoke-RestMethod "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html" -OutFile ft-identifying-tablet-devices.html
    }
    $modelLine = (Select-String -Pattern "$model" -Path .\ft-identifying-tablet-devices.html).LineNumber
    if ($modelLine){
        $device = (Get-Content .\ft-identifying-tablet-devices.html | Select -Index ("$modelLine" - 3) | Select-String "(?:Kindle|Fire) (?:.*?)[Gg]en\)").Matches.Value
        $fireos = (adb shell getprop ro.build.mktg.fireos)
    }
}
Write-Host "$device`n$fireos"