#!/usr/bin/env python3

import customtkinter as ctk
from CTkToolTip import *
import platform, webbrowser, subprocess, os

version = "BETA"

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - (" + platform.system() + ")")
window.geometry("1000x550")
window.columnconfigure(0)
window.columnconfigure(1)
window.columnconfigure(2)

# Functions
def debloat():
    subprocess.call(os.getcwd() + "/debloat.sh")

def set_dns():
    if customdns.get() == "None":
        print("Removing Private DNS Server")
        
    elif customdns.get() != "Select DNS Server":
        print("Setting Private DNS Provider to:", customdns.get())

def set_launcher():
    if customlauncher.get() == "Custom":
        print("Select .apk(m) File")

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
CTkToolTip(debloat, message="Disable Amazon bloatware, then set privacy & performance settings")

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=debloat)
undo.grid(row=2, column=0, padx=60, pady=15)
CTkToolTip(undo, message="Enable Amazon bloatware, then revert privacy & performance settings")

edit = ctk.CTkButton(window, text="Edit", width=200, height=50)
edit.grid(row=3, column=0, padx=60, pady=15)
CTkToolTip(edit, message="Open 'Debloat.txt' in preferred text editor")

label1 = ctk.CTkLabel(window, text="Custom DNS", font=("default",25))
label1.grid(row=4, column=0, padx=60, pady=15)

customdns = ctk.CTkComboBox(window, values=["dns.adguard.com", "security.cloudflare-dns.com", "None"], width=200, height=30)
customdns.grid(row=5, column=0, padx=60, pady=15)
customdns.set("Select DNS Server")
CTkToolTip(customdns, message="Select DNS provider from the dropdown or type one in the selection bar")

setdns = ctk.CTkButton(window, text="Set Selected DNS", width=200, height=50, command=set_dns)
setdns.grid(row=6, column=0, padx=60, pady=15)
CTkToolTip(setdns, message="Set the selected DNS server as Private DNS provider")

# Column 2
label2 = ctk.CTkLabel(window, text="Utilities", font=("default",25))
label2.grid(row=0, column=1, padx=60, pady=15)

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50)
googleservices.grid(row=1, column=1, padx=60, pady=15)
CTkToolTip(googleservices, message="Install Google Services & Play Store")

batchinstall = ctk.CTkButton(window, text="Batch Install", width=200, height=50)
batchinstall.grid(row=2, column=1, padx=60, pady=15)
CTkToolTip(batchinstall, message="Install all .apk(m) files in the 'Batch' folder")

disableota = ctk.CTkButton(window, text="Disable OTA", width=200, height=50)
disableota.grid(row=3, column=1, padx=60, pady=15)
CTkToolTip(disableota, message="Disable OTA update services")

label3 = ctk.CTkLabel(window, text="Custom Launcher", font=("default",25))
label3.grid(row=4, column=1, padx=60, pady=15)

customlauncher = ctk.CTkOptionMenu(window, values=["Lawnchair", "Nova Launcher", "Custom"], width=200, height=30, fg_color=("#F9F9FA","#343638"), button_color=("#979DA2","#565b5e"), text_color=("#1A1A1A","#DCE4EE"))
customlauncher.grid(row=5, column=1, padx=60, pady=15)
customlauncher.set("Select Launcher")
CTkToolTip(customlauncher, message="Replace the stock launcher with one listed, or select a local .apk(m)")

setlauncher = ctk.CTkButton(window, text="Install Selected Launcher", width=200, height=50, command=set_launcher)
setlauncher.grid(row=6, column=1, padx=60, pady=15)
CTkToolTip(setlauncher, message="Replace the stock launcher with the one selected")

# Column 3
label4 = ctk.CTkLabel(window, text="Packages", font=("default",25))
label4.grid(row=0, column=2, padx=60, pady=15)

segemented_button = ctk.CTkSegmentedButton(window, values=["Enable", "Disable"], width=200, height=50, dynamic_resizing=False, command=test)
segemented_button.set("Disable")
segemented_button.grid(row=1, column=2, padx=60, pady=15)

extract = ctk.CTkButton(window, text="Extract", width=200, height=50)
extract.grid(row=2, column=2, padx=60, pady=15)
CTkToolTip(extract, message="Extract selected packages to 'Extracted' folder")

window.mainloop()
