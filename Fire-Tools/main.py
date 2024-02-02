import customtkinter as ctk
import os, glob

# Build/Device Variables
version = "Testing"
platform = "(Linux/macOS)"
path = os.getcwd() + "/Scripts/Posix"
extension = ".sh "
if os.name == "nt":
    platform = "(Windows)"
    path = "powershell.exe -ExecutionPolicy Bypass -file " + os.getcwd() + "/Scripts/PowerShell"
    extension = ".ps1 "

# Identify Fire Device
device = os.popen(path + "/identify" + extension).read()

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - " + platform + " | " + device)
window.geometry("980x550")
window.columnconfigure(0)
window.columnconfigure(1)
window.columnconfigure(2)

# Functions
def debloat(option):
    os.system(path + "/debloat" + extension + option)

def editfile():
    if platform != "(Windows)":
        os.system("xdg-open Debloat.txt >/dev/null 2>&1 || open -e Debloat.txt")
    else:
        os.startfile('Debloat.txt')

def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "None":
        os.system("adb shell \"settings put global private_dns_mode off && printf '%s\\n\\n' 'Disabled Private DNS'\"")
    elif dnsprovider != "Select or Enter DNS Server":
            os.system("adb shell settings put global private_dns_mode hostname")
            os.system("adb shell \"settings put global private_dns_specifier " + dnsprovider + " && printf 'Successfully Set Private DNS to: %s\\n\\n' " + dnsprovider + "\"")

def appinstaller(folder):
    search = os.getcwd() + folder + "/*.apk*"
    for app in glob.iglob(search):
        os.system(path + "/appinstaller" + extension + "\"" + app + "\"")

def disableota():
    ota = "com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota"
    for package in ota:
        os.system(path + "/debloat" + extension + "Disable " + package)

def set_launcher():
    if customlauncher.get() == "Custom":
        launcher = ctk.filedialog.askopenfilename(title = "Select .apk(m) File",filetypes = (("APK","*.apk"),("Split APK","*.apkm"),("all files","*.*")))
        if launcher:
            os.system(path + "/appinstaller" + extension + "\"" + launcher + "\"")
    elif customlauncher.get() != "Select Launcher":
        search = os.getcwd() + "/" + customlauncher.get() + "*.apk"
        for launcher in glob.iglob(search):
            os.system(path + "/appinstaller" + extension + "\"" + launcher + "\" " + "Launcher")

def test(option):
    packages = textbox.get("1.0", "100.0")
    for package in packages.split():       
        if option == "Disable":
            print("Disabling:", package)
        elif option == "Enable":
            print("Enabling:", package)
        elif option == "Extract":
            print("Extracting:", package)

def switch(value):
    selected.configure(text=value + " Selected")
    selected.configure(command=lambda: test(value))

def add_package(value):
    #print("Selected:", value)
    textbox.insert("1.0", value)

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

# Read Packages from packagelist
with open("test.txt") as package:
    packagelist = [line for line in package]

packagelist = ctk.CTkComboBox(window, values=packagelist, width=200, height=30, state="readonly", command=add_package)
packagelist.grid(row=1, column=2, padx=60, pady=15)
packagelist.set("Select Package(s) for List")

textbox = ctk.CTkTextbox(window, wrap="none")
#textbox.grid(row=2, column=2, padx=60, pady=15)

package_option = ctk.CTkSegmentedButton(window, values=["Disable", "Enable", "Extract"], width=200, height=50, dynamic_resizing=False, command=switch)
package_option.set("Disable")
package_option.grid(row=3, column=2, padx=60, pady=15)

selected = ctk.CTkButton(window, text="Disable Selected", width=200, height=50, command=lambda: test("Disable"))
selected.grid(row=4, column=2, padx=60, pady=15)

window.mainloop()
