## Fire Device Preparation

Enabling USB Debugging is required for Fire-Tools to work. Make sure to plug device into a computer with a data transfer cable (preferably the one in the box).

1. **Initial Setup:**
* Select preferred language.
* Choose "Set up manually".
* Tap on a random locked network, then press "Cancel".
* Select "Skip Setup"

2. **Developer Options:**
* Open Settings.
* Scroll down to and select "Device Options".
* Go to "About Fire Tablet".
* Tap on "Serial Number" 7 times .

3. **USB Debugging:**
* Go back to "Device Options" and select "Developer Options".
* Turn the toggle switch on.
* Scroll down to "USB debugging" and switch it on.
* Scroll down to "Default USB configuration", tap it, then select "File Transfer" (Optional, but fixes plugdev group issues on Linux).

## Setting Up Fire Tools Dependencies

This guide will help you install the necessary dependencies to run Fire Tools on Windows, Linux, and macOS.

**Software Requirements:**

* [ADB](https://developer.android.com/tools/releases/platform-tools) (Android Debug Bridge)
* [Python](https://www.python.org/) (Python 3 with Tkinter)
* [CustomTkinter](https://github.com/TomSchimansky/CustomTkinter) (Python GUI toolkit library)
* [Requests](https://requests.readthedocs.io/en/latest/) (Python HTTP library)

**Windows**

1. **ADB:**
    * Download the Android SDK Platform-Tools package from [Platform-Tools](https://dl.google.com/android/repository/platform-tools-latest-windows.zip).
    * Extract the downloaded zip file.
    * Search and launch "Environment Variables" from the Start Menu.
    * In the “System Properties” window, click the “Environment Variables” button at the bottom.
    * Select the "Path" variable, then "Edit" and type in the platform-tools folder location, then hit "OK" on all open windows.  

2. **Python:**
    * Download the latest Python 3.x installer from [https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/).
    * Run the installer and make sure to check the option to "Add Python 3.x to PATH" during installation.

3. **CustomTkinter & Requests:**
    * Open PowerShell or Windows Terminal.
    * Use the `pip` package manager to install CustomTkinter:
      ``` powershell
      python.exe -m pip install customtkinter requests
      ```

**Linux:**

1. **ADB & Python:**
    * Open a Terminal window.
    * Install the ADB & Python-tk package:
      ``` bash
      # Ubuntu/Debian/Chrome OS Linux Container
      sudo apt install adb python3-tk

      # Arch
      sudo pacman -S android-tools tk

      # Fedora
      sudo dnf install android-tools python3-tkinter
      ```
      
2. **CustomTkinter & Requests:**
    * Use `pip` to install CustomTkinter:
      ```bash
      pip3 install customtkinter requests
      ```

**macOS**

1. **Brew:**
    * [Brew](https://brew.sh/) is a package manager for macOS. Install it by pasting the provided command into the Terminal.
      ``` bash
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```

2. **ADB & Python:**
    * Open a Terminal window.
    * Install the ADB & Python-tk package:
      ``` bash
      brew install android-platform-tools python-tk
      ```
    
3. **CustomTkinter & Requests:**
    * Use `pip` to install CustomTkinter:
      ```bash
      pip3 install customtkinter requests
      ```
