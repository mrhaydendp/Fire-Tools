from os import chdir, chmod, path, getcwd, remove, name, listdir, rmdir, mkdir
from glob import glob, iglob
from requests import get
from subprocess import run, check_output, PIPE, CalledProcessError
import shlex
import customtkinter as ctk

# Set Path
chdir(path.dirname(path.realpath(__file__)))

# Platform Variables
version = "25.09"
platform = "Linux/macOS"
default_path = f"{getcwd()}/Scripts/Posix/"
extension = ".sh"
shell = "Posix"
if name == "nt":
    platform = "Windows"
    default_path = f"powershell -ExecutionPolicy Bypass -file \"{getcwd()}\\Scripts\\PowerShell\\"
    extension = ".ps1\""
    shell = "PowerShell"

# Start ADB Server
run(["adb", "start-server"], check=True, stderr=PIPE)

# Get Device Name & Fire OS Version from identify Script, then Print Fire Tools Version, Platform, Device Name, and Software Version
device = check_output(shlex.split(f"{default_path}identify{extension}"), universal_newlines=True).splitlines()
print(f"Fire Tools Version: {version}\nPlatform: {platform}\nDevice: {device[0]}\nSoftware: {device[1]}\n")

# Window Config
window = ctk.CTk()
window.title(f"Fire Tools v{version} - ({platform}) | {device[0]}")
window.geometry("980x550")

# Run Debloat with Disable/Enable Option & Package Name
def debloat(option, package=""):
    cmdlist = shlex.split(f"{default_path}debloat{extension} {option}")
    if package:
        cmdlist.append(package)
    run(cmdlist)

# Pass Folder or .apk(m) File to Appinstaller Script for Installation
def appinstaller(folder):
    cmdlist = shlex.split(f"{default_path}appinstaller{extension}")
    if not path.isfile(folder):
        search = f"{getcwd()}/{folder}*.apk*"
        apps = 0
        for app in iglob(search):
            apps =+ 1
            appinstaller(app)
        if apps == 0:
            print(f"{folder} is Empty, Opening File Picker")
            app = ctk.filedialog.askopenfilename(title="Select .apk(m) File", filetypes=(("APK/Split", "*.apk*"), ("All Files", "*.*")))
            if app:
                appinstaller(app)
    else:
        cmdlist.append(folder)
        run(cmdlist)
        cmdlist.remove(folder)

# On Update, Delete "ft-identify-tablet-devices.html", Update Modules, and Make Scripts Executable (Linux/macOS)
def update_tool():
    print("Checking for Updates...\n")
    try:
        latest = get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/version", timeout=10).text.rstrip()
    except exceptions.ConnectionError:
        latest = version
    if version.replace(".","") < latest.replace(".",""):
        print("Latest Changelog:\n", get("https://github.com/mrhaydendp/Fire-Tools/raw/main/Changelog.md", timeout=10).text)
        for identify_cache in glob("*ft-identify-tablet-devices.html*"):
            remove(identify_cache)
        modules = ["Debloat.txt", f"Scripts/{shell}/appinstaller{extension}", f"Scripts/{shell}/debloat{extension}", f"Scripts/{shell}/identify{extension}", f"Scripts/{shell}/install{extension}"]
        # Check if User is Running in Python or Binary Mode
        if not glob("fire-tools*"):
            # Grab Latest requirements.txt and Install with Pip
            print("\nUpdating Dependencies")
            with open("requirements.txt", "wb") as file:
                file.write(get("https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/refs/heads/main/Fire-Tools/requirements.txt", timeout=10).content)
            run(["pip3","install","-r","requirements.txt"])
            modules.append("main.py")        
        for module in modules:
            if platform == "Windows":
                module = module.replace(".ps1\"",".ps1")
            print(f"Updating: {module}")
            with open(f"{module}", "wb") as file:
                file.write(get(f"https://github.com/mrhaydendp/Fire-Tools/raw/main/Fire-Tools/{module}", timeout=10).content)
        if platform == "Linux/macOS":
            for script in glob(f"{getcwd()}/Scripts/Posix/*.sh"):
                chmod(script, 0o775 )
        print("\nUpdates Complete, Please Re-launch Application")
    else:
        print("No Update Needed\n")

# Open Debloat.txt in Preferred Text Editor
def editfile():
    if platform != "Windows":
        try:
            run(["xdg-open", "Debloat.txt"], check=True, stderr=PIPE)
        except CalledProcessError:
            run(["open", "-e", "Debloat.txt"], check=True, stderr=PIPE)
    else:
        run(["notepad.exe", "Debloat.txt"])

# Set DNS Mode to Hostname, then Set Selected Provider as Private DNS
def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "Disable":
        run(["adb", "shell", "settings", "put", "global", "private_dns_mode", "off"])
        run(["adb", "shell", "settings", "delete", "global", "private_dns_specifier"], stdout=PIPE)
        print("Disabled Private DNS\n")
        customdns.set("Select or Enter DNS Server")
    elif dnsprovider != "Select or Enter DNS Server":
        try:
            check_output(["adb", "shell", "settings", "put", "global", "private_dns_mode", "hostname"], stderr=PIPE)
            check_output(["adb", "shell", "settings", "put", "global", "private_dns_specifier", dnsprovider])
            print(f"Successfully Set DNS Provider to: {dnsprovider}\n")
        except CalledProcessError:
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
    # Ensure launcher is always defined before use
    launcher = None
    selection = customlauncher.get()
    if selection == "Custom":
        launcher = ctk.filedialog.askopenfilename(title="Select Launcher .apk(m) File", filetypes=(("APK/Split", "*.apk*"), ("All Files", "*.*")))
        if not launcher:
            print("No custom launcher selected, aborting.")
            return
    elif selection != "Select Launcher":
        # Try to find a matching apk in the working directory
        for app in iglob(f"{getcwd()}/{selection}*.apk"):
            launcher = app
            break

    if not launcher:
        print("No launcher specified or found. Please select a launcher.")
        return

    cmdlist = shlex.split(f"{default_path}appinstaller{extension}")
    cmdlist.append(launcher)
    cmdlist.append("Launcher")
    run(cmdlist)

# Extract Selected Package to Extracted/{package} if not Already Present
def extract(package):
    if not path.exists(f"Extracted/{package}"):
        print("Extracting:", package)
        mkdir(f"Extracted/{package}")
        for packagelocation in check_output(["adb", "shell", "pm", "path", package], universal_newlines=True).splitlines():
            run(["adb", "pull", packagelocation.replace("package:",""), f"./Extracted/{package}"])
            if not listdir(f"Extracted/{package}"):
                rmdir(f"Extracted/{package}")
            print("")
    else:
        if platform == "Windows":
            print(f"Skipping, Found at: {getcwd()}\\Extracted\\{package}")
        else:
            print(f"Skipping, Found at: {getcwd()}/Extracted/{package}")

# Read Packages from "customlist" & Pass to Debloat or Extract Function
def custom(option):
    customlist = [package for package in packages if checkboxes[package].get()]
    for package in customlist:
        if option == "Extract":
            extract(package)
        else:
            debloat(option,package)
    print("")

# Action to be performed when the select all checkbox is clicked.
def select_all_click():
    # Clear all selections
    select_none()
    # If select_all_bx is selected, select packages currently in the filtered view.
    if select_all_bx.get():
        for package in packages:
            if checkboxes[package].winfo_ismapped():
                checkboxes[package].select()

# Removes all package selections
def select_none():
    for package in packages:
        checkboxes[package].deselect()

# Deselect the select all check box
def clear_select_all():
    select_all_bx.deselect()

# Check if all currently filtered packages are selected, mark the select all if they are.
def check_select_all():
    select_all_bx.select()
    for package in packages:
        # Deselect check all if any currently filtered package is not selected
        if checkboxes[package].winfo_ismapped() and not checkboxes[package].get():
            clear_select_all()
            break

# Switch Segmented Button's Text & Command to the Selected Option
def switch(option):
    selected.configure(text=f"{option} Selected",command=lambda: custom(option))

# If Search Input is Found in "package", add to Filtered List & Regenerate Package List (UI)
def filter_packagelist(event):
    filtered = [package for package in packages if search.get() in package]
    generate_list(filtered)

# Remove all Checkboxes and Replace with ones from Filtered List
def generate_list(items):
    for package in packages:
        if package in items:
            checkboxes[package].pack(anchor="w", pady=5)
        else:
            checkboxes[package].deselect()
            checkboxes[package].pack_forget()
    check_select_all()

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

customdns = ctk.CTkComboBox(window, values=["one.one.one.one", "dns.quad9.net", "dns.adguard.com", "adblock.dns.mullvad.net", "family.cloudflare-dns.com", "family.adguard-dns.com", "Disable"], width=200, height=30)
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
package_list.bind_all("<Button-5>", lambda e: package_list._parent_canvas.yview("scroll", 1, "units"))
package_list.bind_all("<Button-4>", lambda e: package_list._parent_canvas.yview("scroll", -1, "units"))
package_list.place(x=690, y=75)
if platform == "Windows":
    package_list.place(x=670, y=75)

options_frame = ctk.CTkFrame(package_list)
select_all_bx = ctk.CTkCheckBox(options_frame, width=30, text="", command=lambda: select_all_click())
select_all_bx.grid(row=0, column = 0)
search = ctk.CTkEntry(options_frame, width=200, placeholder_text="Filter Packages")
search.bind("<Return>", command=filter_packagelist)
search.grid(row=0, column = 1)
options_frame.pack(anchor="w", pady=5)

if device[0] != "Not Detected":
    dnsprovider = check_output(["adb", "shell", "settings", "get", "global", "private_dns_specifier"], universal_newlines=True).splitlines()
    if "null" not in dnsprovider:
        customdns.set(dnsprovider)
    packages = [package.replace("package:","") for package in check_output(["adb", "shell", "pm", "list", "packages", "--user", "0"], universal_newlines=True).splitlines()]
    checkboxes = {}
    for package in packages:
        checkboxes[package] = ctk.CTkCheckBox(package_list, text=package, command=check_select_all)
        checkboxes[package].pack(anchor="w", pady=5)

window.mainloop()

# Remove Temp Files when Application Closes
for temp_file in glob("*packagelist*"):
    remove(temp_file)