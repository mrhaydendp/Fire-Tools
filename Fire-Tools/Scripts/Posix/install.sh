#!/usr/bin/env sh

# Download & Unzip Fire Tools
curl -LO https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip
unzip -o Fire-Tools.zip -d "$HOME"
rm Fire-Tools.zip

# Install Dependencies with Respective Package Manager
if command -v apt >/dev/null 2>&1; then
    sudo apt install -y adb python3 python3-tk python3-pip
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm android-tools tk python-pip
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y android-tools python3-tkinter python3-pip
elif command -v brew >/dev/null 2>&1; then
    yes | brew install android-platform-tools python-tk
else
    echo "Unsupported OS"
    exit 1
fi

# Download Latest Requirements File & Install with Pip
curl -L "https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/main/Fire-Tools/requirements.txt" -o "$HOME/Fire-Tools/requirements.txt"
pip install -r "$HOME/Fire-Tools/requirements.txt"

# Create .Desktop File
if [ -d "$HOME/.local/share/applications" ]; then
    printf "[Desktop Entry]\nName=Fire Tools\nExec=python3 %s/Fire-Tools/main.py\nTerminal=true\nType=Application\nCategories=Utility" "$HOME" > "$HOME/.local/share/applications/Fire-Tools.desktop"
    chmod +x "$HOME/.local/share/applications/Fire-Tools.desktop"
fi
