# Set Placeholder Values for Device Name & Fire OS Version
$device = "Not Detected"
$fireos = "N/A"

# Find Device Name by Regexing Model Number & Subtracting 3 Lines on Amazon Developer Docs, Then get Fire OS Version
if (adb shell echo "Device Found" 2> $null){
    $amazon = adb shell getprop ro.build.mktg.fireos
    if (!("$amazon")){
        $device = "Generic ADB"
    } else {
        $model = (adb shell getprop ro.product.model)
        if (!(Test-Path .\ft-identify-tablet-devices.html)){
            Invoke-RestMethod "https://developer.amazon.com/docs/device-specs/ft-identify-tablet-devices.html" -OutFile ft-identify-tablet-devices.html
        }
        $device = ((Select-String -Pattern "$model" -Path .\ft-identify-tablet-devices.html -Context 3).Context.PreContext[1] | Select-String "(?:Kindle|Fire) (?:.*?)[Gg]en\)").Matches.Value
        $fireos = "$amazon"
    }
}
Write-Host "$device`n$fireos"
