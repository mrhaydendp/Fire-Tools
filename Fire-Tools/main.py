import customtkinter as ctk
import subprocess, os, glob

# Build/Device Variables
version = "Testing"
platform = "(Linux/macOS)"
path = os.getcwd() + "/Scripts/Posix"
extension = ".sh"
if os.name == "nt":
    platform = "(Windows)"
    path = os.getcwd() + "/Scripts/Powershell"
    extension = ".ps1"

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - " + platform)
window.geometry("980x550")
window.columnconfigure(0)
window.columnconfigure(1)
window.columnconfigure(2)

# Functions
def debloat(option):
    subprocess.call([path + "/debloat" + extension, option])

def editfile():
    if platform != "(Windows)":
        os.system("xdg-open Debloat.txt >/dev/null 2>&1 || open -e Debloat.txt")
    else:
        os.system("Debloat.txt")

def set_dns():
    dnsprovider = customdns.get()
    if dnsprovider == "None":
        os.system("adb shell settings put global private_dns_mode off")
        print("Disabled Private DNS")

    elif dnsprovider != "Select or Enter DNS Server":
        try:
            os.system("adb shell settings put global private_dns_mode hostname")
            os.system("adb shell settings put global private_dns_specifier " + dnsprovider)
            print("Successfully Set Private DNS to:", dnsprovider)
        except:
            print("Error:", dnsprovider, "is Unreachable or Invalid")

def appinstaller(folder):
    dir = os.getcwd() + folder + "/*.apk*"
    for app in glob.iglob(dir):
        subprocess.call([path + "/appinstaller" + extension, app])

def disableota():
    ota = "com.amazon.device.software.ota", "com.amazon.device.software.ota.override", "com.amazon.kindle.otter.oobe.forced.ota"
    for package in ota:
        subprocess.call([path + "/debloat" + extension, "Disable", package])

def set_launcher():
    if customlauncher.get() == "Custom":
        launcher = ctk.filedialog.askopenfilename(title = "Select .apk(m) File",filetypes = (("APK","*.apk"),("Split APK","*.apkm"),("all files","*.*")))
        if launcher:
            subprocess.call([path + "/appinstaller" + extension, launcher])

    elif customlauncher.get() != "Select Launcher":
        test = os.getcwd() + "/" + customlauncher.get() + "*.apk"
        for launcher in glob.iglob(test):
            subprocess.call([path + "/appinstaller" + extension, launcher])

def switch(value):
    selected.configure(text=value + " Selected")

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

customlauncher = ctk.CTkOptionMenu(window, values=["Lawnchair", "Nova Launcher", "Custom"], width=200, height=30, fg_color=("#F9F9FA","#343638"), button_color=("#979DA2","#565b5e"), text_color=("#1A1A1A","#DCE4EE"))
customlauncher.grid(row=5, column=1, padx=60, pady=15)
customlauncher.set("Select Launcher")

setlauncher = ctk.CTkButton(window, text="Install Selected Launcher", width=200, height=50, command=set_launcher)
setlauncher.grid(row=6, column=1, padx=60, pady=15)

# Column 3
label4 = ctk.CTkLabel(window, text="Packages", font=("default",25))
label4.grid(row=0, column=2, padx=60, pady=15)

package_option = ctk.CTkSegmentedButton(window, values=["Enable", "Disable"], width=200, height=50, dynamic_resizing=False, command=switch)
package_option.set("Disable")
package_option.grid(row=1, column=2, padx=60, pady=15)

selected = ctk.CTkButton(window, text="Disable Selected", width=200, height=50)
selected.grid(row=2, column=2, padx=60, pady=15)

extract = ctk.CTkButton(window, text="Extract", width=200, height=50)
extract.grid(row=3, column=2, padx=60, pady=15)

window.mainloop()