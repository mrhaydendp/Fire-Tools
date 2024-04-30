import customtkinter as ctk
import glob, os, requests

# Build/Device Variables
version = "24.05"
platform = "Linux/macOS"
path = f"{os.getcwd()}/Scripts/Posix/"
extension = ".sh"
shell = "Posix"
if os.name == "nt":
    platform = "Windows"
    path = f"powershell -ExecutionPolicy Bypass -file {os.getcwd()}\\Scripts\\PowerShell\\"
    extension = ".ps1"
    shell = "PowerShell"

# Identify Fire Device
device = os.popen(f"{path}identify{extension}").read()
print(f"{device}\n")

# Window Config
window = ctk.CTk()
window.title(f"Fire Tools v{version} - ({platform}) | {device}")
window.geometry("980x550")
window.columnconfigure(0)
window.columnconfigure(1)
window.columnconfigure(2)

# If Update is Available, Download main.py then Modules for your OS
def update_tool():
    print("Checking for Updates...\n")
    try:
        latest = requests.get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version").text
    except:
        latest = version
    if version.replace(".","") < latest.replace(".",""):
        if os.path.isfile("ft-identifying-tablet-devices.html"):
            os.remove("ft-identifying-tablet-devices.html")
        print("Latest Changelog:\n", requests.get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md").text)
        modules = ["main.py", "Debloat.txt", "requirements.txt", f"Scripts/{shell}/appinstaller{extension}", f"Scripts/{shell}/debloat{extension}", f"Scripts/{shell}/identify{extension}"]
        for module in modules:
            print(f"Updating: {module}")
            open(f"{module}", "wb").write(requests.get(f"https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/{module}").content)
        if platform == "Linux/macOS":
            os.popen("chmod +x Scripts/Posix/*.sh")
        print("\nUpdates Complete, Please Re-launch Application")
        quit()
    else:
        print("No Update Needed\n")

# Run Debloat Script & Pass in Arguments
def debloat(option,package):
    os.system(f"{path}debloat{extension} {option} {package}")

# Open Debloat.txt in Preferred Text Editor
def editfile():
    if platform != "Windows":
        os.system("xdg-open Debloat.txt >/dev/null 2>&1 || open -e Debloat.txt")
    else:
        os.startfile('Debloat.txt')

# Set DNS Mode to Hostname and Set Selected Provider as Private DNS
def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "None":
        os.system(f"adb shell \"settings put global private_dns_mode off && printf 'Disabled Private DNS\\n\\n'\"")
    elif dnsprovider != "Select or Enter DNS Server":
            os.system("adb shell settings put global private_dns_mode hostname")
            os.system(f"adb shell \"settings put global private_dns_specifier {dnsprovider} && printf 'Successfully Set Private DNS to: {dnsprovider}\\n\\n'\"")

# Get all .apk(m) Files from Selected Folder & Pass to AppInstaller Script
def appinstaller(folder):
    search = f"{os.getcwd()}{folder}/*.apk*"
    for app in glob.iglob(search):
        os.system(f"{path}appinstaller{extension} \"{app}\"")

# Attempt to Disable OTA Packages
def disableota():
    ota = "com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota"
    for package in ota:
        debloat("Disable",package)

# Pass Selected Package to Appinstaller with Launcher Argument
def set_launcher():
    if customlauncher.get() == "Custom":
        launcher = ctk.filedialog.askopenfilename(title="Select Launcher .apk(m) File",filetypes=(("APK","*.apk"),("Split APK","*.apkm"),("all files","*.*")))
        if launcher:
            os.system(f"{path}appinstaller{extension} \"{launcher}\" Launcher")
    elif customlauncher.get() != "Select Launcher":
        search = f"{os.getcwd()}/{customlauncher.get()}*.apk"
        for launcher in glob.iglob(search):
            os.system(f"{path}appinstaller{extension} \"{launcher}\" Launcher")

# Make Folder using Package Name & Extract Package from Device
def extract(package):
    if not os.path.exists(f"Extracted/{package}"):
        print("Extracting:", package)
        os.mkdir(f"Extracted/{package}")
        for packagelocation in os.popen(f"adb shell pm path {package}").read().splitlines():
                packagelocation = packagelocation.replace("package:","")
                os.system(f"adb pull {packagelocation} ./Extracted/{package}")
                if os.listdir(f"Extracted/{package}"):
                    print("Success\n")
                else:
                    os.rmdir(f"Extracted/{package}")
                    print("Fail\n")
    else:
        print(f"Found at: /Extracted/{package}\n")

# Add Selected Packages to 'customlist' & if Package is Already Found in List, Remove it
def add_package(package):
    if package in customlist:
        customlist.remove(package)
    else:
        customlist.append(package)

# Read Packages from 'customlist' & Pass to Debloat or Extract Function
def custom(option):
    for package in customlist:
        if option == "Extract":
            extract(package)
        else:
            debloat(option,package)

# Switch Segmented Button's Text & Command to Selected Option
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

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50, command=lambda: appinstaller("/Gapps"))
googleservices.grid(row=1, column=1, padx=60, pady=15)

batchinstall = ctk.CTkButton(window, text="Batch Install", width=200, height=50, command=lambda: appinstaller("/Batch"))
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

tabview = ctk.CTkTabview(window, width=20)
tabview.add("Enabled")
tabview.add("Disabled")
tabview.place(x=698, y=55)
if os.name == "nt":
    tabview.place(x=680, y=55)

enabled_list = ctk.CTkScrollableFrame(tabview.tab("Enabled"), width=200, height=230)
enabled_list.pack()
disabled_list = ctk.CTkScrollableFrame(tabview.tab("Disabled"), width=200, height=230)
disabled_list.pack()
customlist = []

for package in os.popen("adb shell pm list packages -e").read().splitlines():
    checkbox = ctk.CTkCheckBox(enabled_list, text=package.replace("package:",""), command = lambda param = package.replace("package:",""): add_package(param)).pack()
for package in os.popen("adb shell pm list packages -d").read().splitlines():
   checkbox = ctk.CTkCheckBox(disabled_list, text=package.replace("package:",""), command = lambda param = package.replace("package:",""): add_package(param)).pack()

window.mainloop()
