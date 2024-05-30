import glob
import os
import requests
import subprocess
import customtkinter as ctk

# Platform & Device Variables
version = "24.06"
platform = "Linux/macOS"
path = f"{os.getcwd()}/Scripts/Posix/"
extension = ".sh"
shell = "Posix"
if os.name == "nt":
    platform = "Windows"
    path = f"powershell -ExecutionPolicy Bypass -file {os.getcwd()}\\Scripts\\PowerShell\\"
    extension = ".ps1"
    shell = "PowerShell"

# Get Device Name & Fire OS Version from identify Script, then Print Fire Tools Version, Platform, Device Name, and Software Version
device = subprocess.check_output(f"{path}identify{extension}", universal_newlines=True).splitlines()
print(f"Fire Tools Version: {version}\nPlatform: {platform}\nDevice: {device[0]}\nSoftware: {device[1]}\n")

# Window Config
window = ctk.CTk()
window.title(f"Fire Tools v{version} - ({platform}) | {device[0]}")
window.geometry("980x550")

# Run Debloat with Disable/Enable Option & Package Name
def debloat(option,package):
    if package:
        subprocess.run([f"{path}debloat{extension}", option, package])
    else:
        subprocess.run([f"{path}debloat{extension}", option])

# Pass Folder or .apk(m) to Appinstaller Script for Installation
def appinstaller(folder):
    search = f"{os.getcwd()}/{folder}*.apk*"
    for app in glob.iglob(search):
        subprocess.run([f"{path}appinstaller{extension}", app])

# On Update, Delete "ft-identifying-tablet-devices.html", Update Modules, and Make Scripts Executable (Linux/macOS)
def update_tool():
    print("Checking for Updates...\n")
    try:
        latest = requests.get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version", timeout=10).text
    except requests.exceptions.ConnectionError:
        latest = version
    if version.replace(".","") < latest.replace(".",""):
        if os.path.isfile("ft-identifying-tablet-devices.html"):
            os.remove("ft-identifying-tablet-devices.html")
        print("Latest Changelog:\n", requests.get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md", timeout=10).text)
        modules = ["main.py", "Debloat.txt", "requirements.txt", f"Scripts/{shell}/appinstaller{extension}", f"Scripts/{shell}/debloat{extension}", f"Scripts/{shell}/identify{extension}"]
        for module in modules:
            print(f"Updating: {module}")
            with open(f"{module}", "wb") as file:
                file.write(requests.get(f"https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/{module}", timeout=10).content)
        if platform == "Linux/macOS":
            for script in glob.glob(f"{os.getcwd()}/Scripts/Posix/*.sh"):
                os.chmod(script, 0o775 )
        print("\nUpdates Complete, Please Re-launch Application")
        quit()
    else:
        print("No Update Needed\n")

# Open Debloat.txt in Preferred Text Editor
def editfile():
    if platform != "Windows":
        subprocess.run("xdg-open Debloat.txt >/dev/null 2>&1 || open -e Debloat.txt", shell=True)
    else:
        os.startfile("Debloat.txt")

# Set DNS Mode to Hostname, then Set Selected Provider as Private DNS
def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "None":
        subprocess.run("adb shell settings put global private_dns_mode off", shell=True)
        subprocess.run("adb shell settings delete global private_dns_specifier", shell=True)
        print("Disabled Private DNS\n")
    elif dnsprovider != "Select or Enter DNS Server":
        try:
            subprocess.check_output("adb shell settings put global private_dns_mode hostname", stderr=subprocess.PIPE, shell=True)
            subprocess.check_output(f"adb shell settings put global private_dns_specifier {dnsprovider}", shell=True)
            print(f"Successfully Set DNS Provider to: {dnsprovider}\n")
        except subprocess.CalledProcessError:
            print("Failed to Set Private DNS\n")

# Attempt to Disable OTA Packages
def disableota():
    ota_packages = "com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota"
    for package in ota_packages:
        debloat("Disable",package)

# Pass Selected Package to Appinstaller with Launcher Argument
def set_launcher():
    if customlauncher.get() == "Custom":
        launcher = ctk.filedialog.askopenfilename(title="Select Launcher .apk(m) File",filetypes=(("APK","*.apk"),("Split APK","*.apkm"),("all files","*.*")))
        if not launcher:
            return
    elif customlauncher.get() != "Select Launcher":
        for app in glob.iglob(f"{os.getcwd()}/{customlauncher.get()}*.apk"):
            launcher = app
    subprocess.run([f"{path}appinstaller{extension}", launcher, "Launcher"])

# Extract Selected Package to Extracted/{package} If not Already Present
def extract(package):
    if not os.path.exists(f"Extracted/{package}"):
        print("Extracting:", package)
        os.mkdir(f"Extracted/{package}")
        for packagelocation in subprocess.check_output(f"adb shell \"pm path {package} | cut -f2 -d:\"", universal_newlines=True).splitlines():
            subprocess.run(["adb", "pull", {packagelocation}, f"./Extracted/{package}"])
            if not os.listdir(f"Extracted/{package}"):
                os.rmdir(f"Extracted/{package}")
    else:
        print(f"Found at: /Extracted/{package}")

# Add Selected Packages to "customlist" & Remove if Package is Already Found
def add_package(package):
    if package in customlist:
        customlist.remove(package)
    else:
        customlist.append(package)

# Read Packages from "customlist" & Pass to Debloat or Extract Function
def custom(option):
    for package in customlist:
        if option == "Extract":
            extract(package)
        else:
            debloat(option,package)
    print("")

# Switch Segmented Button's Text & Command to the Selected Option
def switch(option):
    selected.configure(text=f"{option} Selected",command=lambda: custom(option))

# Update Button
update = ctk.CTkButton(window, text="⟳", font=("default",20), width=30, height=30, command=update_tool)
update.place(x=15, y=15)

# Column 1
label = ctk.CTkLabel(window, text="Debloat", font=("default",25))
label.grid(row=0, column=0, padx=60, pady=15)

disable = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=lambda: debloat("Disable",""))
disable.grid(row=1, column=0, padx=60, pady=15)

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=lambda: debloat("Enable",""))
undo.grid(row=2, column=0, padx=60, pady=15)

edit = ctk.CTkButton(window, text="Edit", width=200, height=50, command=editfile)
edit.grid(row=3, column=0, padx=60, pady=15)

label1 = ctk.CTkLabel(window, text="Custom DNS", font=("default",25))
label1.grid(row=4, column=0, padx=60, pady=15)

customdns = ctk.CTkComboBox(window, values=["dns.adguard.com", "security.cloudflare-dns.com", "None"], width=200, height=30)
customdns.grid(row=5, column=0, padx=60, pady=15)
customdns.set("Select or Enter DNS Server")

setdns = ctk.CTkButton(window, text="Set Selected DNS", width=200, height=50, command=set_dns)
setdns.grid(row=6, column=0, padx=60, pady=15)

# Column 2
label2 = ctk.CTkLabel(window, text="Utilities", font=("default",25))
label2.grid(row=0, column=1, padx=60, pady=15)

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50, command=lambda: appinstaller("Gapps/"))
googleservices.grid(row=1, column=1, padx=60, pady=15)

batchinstall = ctk.CTkButton(window, text="Batch Install", width=200, height=50, command=lambda: appinstaller("Batch/"))
batchinstall.grid(row=2, column=1, padx=60, pady=15)

ota = ctk.CTkButton(window, text="Disable OTA", width=200, height=50, command=disableota)
ota.grid(row=3, column=1, padx=60, pady=15)

label3 = ctk.CTkLabel(window, text="Custom Launcher", font=("default",25))
label3.grid(row=4, column=1, padx=60, pady=15)

customlauncher = ctk.CTkComboBox(window, values=["Lawnchair", "Nova Launcher", "Custom"], width=200, height=30, state="readonly")
customlauncher.grid(row=5, column=1, padx=60, pady=15)
customlauncher.set("Select Launcher")

setlauncher = ctk.CTkButton(window, text="Install Selected Launcher", width=200, height=50, command=set_launcher)
setlauncher.grid(row=6, column=1, padx=60, pady=15)

# Column 3
label4 = ctk.CTkLabel(window, text="Packages", font=("default",25))
label4.grid(row=0, column=2, padx=60, pady=15)

package_option = ctk.CTkSegmentedButton(window, values=["Disable", "Enable", "Extract"], width=200, height=50, dynamic_resizing=False, command=switch)
package_option.set("Disable")
package_option.grid(row=5, column=2, padx=60, pady=15)

selected = ctk.CTkButton(window, text="Disable Selected", width=200, height=50, command=lambda: custom("Disable"))
selected.grid(row=6, column=2, padx=60, pady=15)

tabview = ctk.CTkTabview(window, width=250, height=300)
tabview.add("Enabled")
tabview.add("Disabled")
tabview.place(x=694, y=55)
if platform == "Windows":
    tabview.place(x=674, y=55)

enabled_list = ctk.CTkScrollableFrame(tabview.tab("Enabled"), width=200, height=230)
enabled_list.pack()
disabled_list = ctk.CTkScrollableFrame(tabview.tab("Disabled"), width=200, height=230)
disabled_list.pack()
customlist = []

if device[0] != "Unknown/Undetected":
    for enabled_package in subprocess.check_output("adb shell \"pm list packages -e | cut -f2 -d:\"", universal_newlines=True, shell=True).splitlines():
        checkbox = ctk.CTkCheckBox(enabled_list, text=enabled_package, command = lambda param = enabled_package: add_package(param)).pack()
    for disabled_package in subprocess.check_output("adb shell \"pm list packages -d | cut -f2 -d:\"", universal_newlines=True, shell=True).splitlines():
        checkbox = ctk.CTkCheckBox(disabled_list, text=disabled_package, command = lambda param = disabled_package: add_package(param)).pack()

window.mainloop()

# Remove Temp Files when Application Closes
for temp_file in glob.glob("*packagelist*"):
    os.remove(temp_file)
