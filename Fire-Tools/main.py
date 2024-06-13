import glob
import os
import requests
import subprocess
import time
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
device = subprocess.check_output(f"{path}identify{extension}".split(), universal_newlines=True).splitlines()
print(f"Fire Tools Version: {version}\nPlatform: {platform}\nDevice: {device[0]}\nSoftware: {device[1]}\n")

# Window Config
window = ctk.CTk()
window.title(f"Fire Tools v{version} - ({platform}) | {device[0]}")
window.geometry("980x550")

# Run Debloat with Disable/Enable Option & Package Name
def debloat(option, package=""):
    cmdlist = f"{path}debloat{extension} {option}".split()
    if package:
        cmdlist.append(package)
    subprocess.run(cmdlist)

# Pass Folder or .apk(m) to Appinstaller Script for Installation
def appinstaller(folder):
    cmdlist = f"{path}appinstaller{extension}".split()
    search = f"{os.getcwd()}/{folder}*.apk*"
    for app in glob.iglob(search):
        cmdlist.append(app)
        subprocess.run(cmdlist)
        cmdlist.remove(app)

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
        try:
            subprocess.run(["xdg-open", "Debloat.txt"], check=True, stderr=subprocess.PIPE)
        except subprocess.CalledProcessError:
            subprocess.run(["open", "-e", "Debloat.txt"], check=True, stderr=subprocess.PIPE)
    else:
        os.startfile("Debloat.txt")

# Set DNS Mode to Hostname, then Set Selected Provider as Private DNS
def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "None":
        subprocess.run(["adb", "shell", "settings", "put", "global", "private_dns_mode", "off"])
        subprocess.run(["adb", "shell", "settings", "delete", "global", "private_dns_specifier"], stdout=subprocess.PIPE)
        print("Disabled Private DNS\n")
    elif dnsprovider != "Select or Enter DNS Server":
        try:
            subprocess.check_output(["adb", "shell", "settings", "put", "global", "private_dns_mode", "hostname"], stderr=subprocess.PIPE)
            subprocess.check_output(["adb", "shell", "settings", "put", "global", "private_dns_specifier", dnsprovider])
            print(f"Successfully Set DNS Provider to: {dnsprovider}\n")
        except subprocess.CalledProcessError:
            print("Failed to Set Private DNS\n")

# Install Gapps in Gapps Folder then Re-install Play Store
def install_gapps():
    appinstaller("Gapps/")
    appinstaller("Gapps/Google Play Store")

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
    cmdlist = f"{path}appinstaller{extension}".split()
    cmdlist.append(launcher)
    cmdlist.append("Launcher")
    subprocess.run(cmdlist)

# Extract Selected Package to Extracted/{package} If not Already Present
def extract(package):
    if not os.path.exists(f"Extracted/{package}"):
        print("Extracting:", package)
        os.mkdir(f"Extracted/{package}")
        for packagelocation in subprocess.check_output(["adb", "shell", "pm", "path", package], universal_newlines=True).splitlines():
            subprocess.run(["adb", "pull", packagelocation.replace("package:",""), f"./Extracted/{package}"])
            if not os.listdir(f"Extracted/{package}"):
                os.rmdir(f"Extracted/{package}")
            print("")
    else:
        print(f"Found at: /Extracted/{package}")


# Read Packages from "customlist" & Pass to Debloat or Extract Function
def custom(option):
    customlist = [package for package in packages if checkboxes[package].get()]
    for package in customlist:
        if option == "Extract":
            extract(package)
        else:
            debloat(option,package)
    print("")

# Switch Segmented Button's Text & Command to the Selected Option
def switch(option):
    selected.configure(text=f"{option} Selected",command=lambda: custom(option))

def filter_packagelist(event):
    filtered = [package for package in packages if search.get() in package]
    generate_list(filtered)

def generate_list(items):
    for package in packages:
        checkboxes[package].pack_forget()
    for package in items:
        checkboxes[package] = ctk.CTkCheckBox(master=package_list, text=package)
        checkboxes[package].pack(anchor="w", pady=5)

# Update Button
update = ctk.CTkButton(window, text="⟳", font=("default",20), width=30, height=30, command=update_tool)
update.place(x=15, y=15)

# Column 1
label = ctk.CTkLabel(window, text="Debloat", font=("default",25))
label.grid(row=0, column=0, padx=60, pady=15)

disable = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=lambda: debloat("Disable"))
disable.grid(row=1, column=0, padx=60, pady=15)

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=lambda: debloat("Enable"))
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

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50, command=install_gapps)
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

package_list = ctk.CTkScrollableFrame(window, width=235, height=270)
package_list.place(x=690, y=75)
if platform == "Windows":
    package_list.place(x=670, y=75)

search = ctk.CTkEntry(package_list, placeholder_text="Filter Packages")
search.bind("<Return>", command=filter_packagelist)
search.pack()

if device[0] != "Unknown/Undetected":
    print("Generating Packagelist")
    start = time.time()
    packages = [package.replace("package:","") for package in subprocess.check_output(["adb", "shell", "pm", "list", "packages"], universal_newlines=True).splitlines()]
    checkboxes = {}
    for package in packages:
        checkboxes[package] = ctk.CTkCheckBox(package_list, text=package)
        checkboxes[package].pack(anchor="w", pady=5)
    print(f"Completed in {round(time.time() - start, 2)}s\n")

window.mainloop()

# Remove Temp Files when Application Closes
for temp_file in glob.glob("*packagelist*"):
    os.remove(temp_file)
