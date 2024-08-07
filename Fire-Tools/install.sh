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
    $cmd
}

# Install Brew (https://brew.sh) and use it to install ADB & Python-TK
mac_dependencies () {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    yes | brew install android-platform-tools python-tk
}

# If Linux, run Linux function else run MacOS function
if [ "$(uname -s)" = "Linux" ]; then
    linux_dependencies 
else
    mac_dependencies
fi

# Download "requirements.txt" and import into Pip
curl -LO "https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/main/Fire-Tools/requirements.txt"
pip install -r requirements.txt

# Download Latest Release & Extract, Then Run
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip
unzip Fire-Tools.zip && rm Fire-Tools.zip
cd Fire-Tools || return
python3 main.py
