# Find Device Name by Regexing Model Number & Subtracting 3 Lines on Amazon Developer Docs
$device = "Unknown/Undetected"
if (adb devices){
    $model = (adb shell getprop ro.product.model)
    if (!(Test-Path .\ft-identifying-tablet-devices.html)){
        Invoke-RestMethod "https://developer.amazon.com/docs/fire-tablets/ft-identifying-tablet-devices.html" -OutFile ft-identifying-tablet-devices.html
    }
    $modelLine = (Select-String -Pattern "$model" -Path .\ft-identifying-tablet-devices.html).LineNumber
    $device = (Get-Content .\ft-identifying-tablet-devices.html | Select -Index ("$modelLine" - 3) | Select-String "(Kindle|Fire) (.*?)[Gg]en\)").Matches.Value
}
Write-Host "Device: $device"
