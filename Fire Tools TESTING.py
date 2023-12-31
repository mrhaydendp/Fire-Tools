import customtkinter as ctk
import subprocess, os, webbrowser

# Build/Device Variables
version = "BETA"
platform = "(Linux/macOS)"
if os.name == "nt":
    platform = "(Windows)"

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - " + platform)
window.geometry("980x550")
window.columnconfigure(0)
window.columnconfigure(1)
window.columnconfigure(2)

# Functions
def debloat():
    subprocess.call(os.getcwd() + "/debloat.sh")

def edit():
    webbrowser.open("test.txt")

def set_dns():
    if customdns.get() == "None":
        print("Removing Private DNS Server")
        
    elif customdns.get() != "Select or Enter DNS Server":
        print("Setting Private DNS Provider to:", customdns.get())

def set_launcher():
    if customlauncher.get() == "Custom":
        launcher = ctk.filedialog.askopenfilename(title = "Select .apk(m) File",filetypes = (("APK","*.apk"),("Split APK","*.apkm"),("all files","*.*")))
        print("Selected:", launcher)

    elif customlauncher.get() != "Select Launcher":
        print("Installing Launcher:", customlauncher.get())

def test(value):
    if value == "Enable":
        print("Enabling Selected Packages")
    else:
        print("Disabling Selected Packages")

# Column 1
label = ctk.CTkLabel(window, text="Debloat", font=("default",25))
label.grid(row=0, column=0, padx=60, pady=15)

debloat = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=debloat)
debloat.grid(row=1, column=0, padx=60, pady=15)

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=debloat)
undo.grid(row=2, column=0, padx=60, pady=15)

edit = ctk.CTkButton(window, text="Edit", width=200, height=50, command=edit)
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

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50)
googleservices.grid(row=1, column=1, padx=60, pady=15)

batchinstall = ctk.CTkButton(window, text="Batch Install", width=200, height=50)
batchinstall.grid(row=2, column=1, padx=60, pady=15)

disableota = ctk.CTkButton(window, text="Disable OTA", width=200, height=50)
disableota.grid(row=3, column=1, padx=60, pady=15)

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

segemented_button = ctk.CTkSegmentedButton(window, values=["Enable", "Disable"], width=200, height=50, dynamic_resizing=False, command=test)
segemented_button.set("Disable")
segemented_button.grid(row=1, column=2, padx=60, pady=15)

extract = ctk.CTkButton(window, text="Extract", width=200, height=50)
extract.grid(row=2, column=2, padx=60, pady=15)

window.mainloop()
