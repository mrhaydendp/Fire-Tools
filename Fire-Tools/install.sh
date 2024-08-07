#!/usr/bin/env sh

# Create .local/share/applications/fire-tools.desktop
# Place Fire-Tools into .local/share/bin

# Determine package manager and run [word] command to install ADB & Python-TK
linux_dependencies () {
    export packagemanagers="apt dnf pacman"
    for pm in ${packagemanagers}; do
        which "$pm" && something="$pm"
    done
    [ "$something" = "apt" ] && cmd="sudo apt install -y adb python3-tk"
    [ "$something" = "dnf" ] && cmd="sudo dnf install -y android-tools python3-tkinter"
    [ "$something" = "pacman" ] && cmd="sudo pacman -Sy android-tools tk"
    exec $cmd
}

# Install Brew (https://brew.sh) and use it to install ADB & Python-TK
mac_dependencies () {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    yes | brew install android-platform-tools python-tk
}

# If Linux, run Linux function else run MacOS function
[ "$(uname -s)" = "Linux" ] && linux_dependencies || mac_dependencies

# Download "requirements.txt" and import into Pip
curl -LO "https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/main/Fire-Tools/requirements.txt"
pip install -r requirements.txt
