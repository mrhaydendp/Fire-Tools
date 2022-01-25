#!/usr/bin/env bash

# Thank you https://stackoverflow.com/questions/41475261/need-alternative-to-readarray-mapfile-for-script-on-older-version-of-bash
if ! type -t readarray >/dev/null; then
  # Very minimal readarray implementation using read. Does NOT work with lines that contain double-quotes due to eval()
  readarray() {
    local cmd opt t v=MAPFILE
    while [ -n "$1" ]; do
      case "$1" in
      -h|--help) echo "minimal substitute readarray for older bash"; exit; ;;
      -r) shift; opt="$opt -r"; ;;
      -t) shift; t=1; ;;
      -u) 
          shift; 
          if [ -n "$1" ]; then
            opt="$opt -u $1"; 
            shift
          fi
          ;;
      *)
          if [[ "$1" =~ ^[A-Za-z_]+$ ]]; then
            v="$1"
            shift
          else
            echo -en "${C_BOLD}${C_RED}Error: ${C_RESET}Unknown option: '$1'\n" 1>&2
            exit
          fi
          ;;
      esac
    done
    cmd="read $opt"
    eval "$v=()"
    while IFS= eval "$cmd line"; do      
      line=$(echo "$line" | sed -e "s#\([\"\`]\)#\\\\\1#g" )
      eval "${v}+=(\"$line\")"
    done
  }
fi

# UI
opt=$(zenity --list \
  --title="Debloat" \
  --width=500 --height=400 \
  --column="Option" --column="Description" \
    "Enable" "Enables All Amazon Apps" \
    "Disable" "Disables All Amazon Apps" \
    "Custom" "Lists Installed Packages & Lets You Disable Them")

# Enable Apps
if [ "$opt" = "Enable" ]; then
    readarray -t packages < <(awk '{print $1}' < Debloat.txt)
    for package in "${packages[@]}"
    do
        readarray -t check < <(adb shell pm list packages | cut -f 2 -d ":" | grep -ow "${package}")
    if [ "${check[0]}" = "${package}" ]; then
        adb shell pm enable "${package}" &>/dev/null &&
        echo "Enabled: ${package}" || echo "Failed to Enable: ${package}"
    fi
    done
    echo "Disabling Adguard DNS"
    adb shell settings put global private_dns_mode -hostname
    adb shell settings put global private_dns_specifier -dns.adguard.com
    echo "Enabling Fire Launcher & OTA Updates"
    adb shell pm enable com.amazon.firelauncher
    adb shell pm enable com.amazon.device.software.ota
    adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
    zenity --notification --text="Successfully Enabled Fire OS Bloat"

# Disable Apps
elif [ "$opt" = "Disable" ]; then
    readarray -t packages < <(awk '{print $1}' < Debloat.txt)
    for package in "${packages[@]}"
    do
        readarray -t check < <(adb shell pm list packages | cut -f 2 -d ":" | grep -ow "${package}")
    if [ "${check[0]}" = "${package}" ]; then
        adb shell pm disable-user -k "${package}" &>/dev/null &&
        echo "Disabled: ${package}" || echo "Failed to Disable: ${package}"
    fi
    done
    echo "Disabling Telemetry & Resetting Advertising ID"
    adb shell settings put secure limit_ad_tracking 1
    adb shell settings put secure usage_metrics_marketing_enabled 0
    adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
    adb shell pm clear com.amazon.advertisingidsettings
    echo "Disabling Location"
    adb shell settings put secure location_providers_allowed -network
    echo "Blocking Ads With Adguard DNS"
    adb shell settings put global private_dns_mode hostname
    adb shell settings put global private_dns_specifier dns.adguard.com
    echo "Disabling Lockscreen Ads"
    adb shell settings put global LOCKSCREEN_AD_ENABLED 0
    echo "Disabling Search on Lockscreen"
    adb shell settings put secure search_on_lockscreen_settings 0
    echo "Speeding Up Animations"
    adb shell settings put global window_animation_scale 0.50
    adb shell settings put global transition_animation_scale 0.50
    adb shell settings put global animator_duration_scale 0.50
    echo "Disabling Background Apps"
    adb shell settings put global always_finish_activities 1
    zenity --notification --text="Successfully Debloated Fire OS"
fi

# List Packages & Disable Apps
[ "$opt" = "Custom" ] &&
    adb shell pm list packages -e | cut -f 2 -d ":" > packagelist &&
    disable=$(zenity --list --width=500 --height=400 --column=Packages --multiple < packagelist) &&
    echo "$disable" | tr '|' '\n' > Packages.txt &&
    xargs -l adb shell pm disable-user -k < Packages.txt &&
    zenity --notification --text="Successfully Disabled Packages"

exec ./ui.sh