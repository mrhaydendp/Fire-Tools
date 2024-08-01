#!/usr/bin/env sh

# Determine OS
# Check for Python3, adb, python3-tk
# Input requirements.txt into Pip
# Create .local/share/applications/fire-tools.desktop
# Place Fire-Tools into .local/share/bin

#Distros vars
export supported="ubuntu, debian, fedora, arch"

# Determine OS (Mac OS or Linux Distro)
if [ ! -e /etc/os-release ]; then
    echo "MacOS"
else
    for distro in $supported; do
        grep "$distro" /etch/os
    done
fi
