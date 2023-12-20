import customtkinter as ctk
from CTkToolTip import *
import platform, webbrowser

version = "BETA"

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - (" + platform.system() + ")")
window.geometry("1000x550")
window.columnconfigure(0, weight=1)
window.columnconfigure(1, weight=1)
window.columnconfigure(2, weight=1)

# Functions
def debloat():
    print("Selected:", debloat.cget("text"))

def undo():
    print("Selected:", undo.cget("text"))

def edit_list():
    webbrowser.open('Instructions.txt', 'r')

def set_dns():
    print("Selected Server: " + customdns.get())

def set_launcher():
    print("Selected Launcher: " + customlauncher.get())

def selected(value):
    print("Selected:", value)

# Column 1
label = ctk.CTkLabel(window, text="Debloat", font=("default",25))
label.grid(row=0, column=0, padx=25, pady=15)

debloat = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=debloat)
debloat.grid(row=1, column=0, padx=25, pady=15)
CTkToolTip(debloat, message="Disable Amazon bloatware, then set privacy and performance settings")

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=undo)
undo.grid(row=2, column=0, padx=25, pady=15)
CTkToolTip(undo, message="Enable Amazon bloatware, then revert privacy and performance settings")

edit = ctk.CTkButton(window, text="Edit", width=200, height=50, command=edit_list)
edit.grid(row=3, column=0, padx=25, pady=15)
CTkToolTip(edit, message="Open 'Debloat.txt' in preferred text editor")

label1 = ctk.CTkLabel(window, text="Custom DNS", font=("default",25))
label1.grid(row=4, column=0, padx=25, pady=15)

customdns = ctk.CTkComboBox(window, values=["dns.adguard.com", "security.cloudflare-dns.com", "None"], width=200, height=30)
customdns.grid(row=5, column=0, padx=25, pady=15)
customdns.set("Select DNS Server")
CTkToolTip(customdns, message="Select DNS provider from the dropdown or type one in the selection bar")

setdns = ctk.CTkButton(window, text="Set Selected DNS", width=200, height=50, command=set_dns)
setdns.grid(row=6, column=0, padx=25, pady=15)
CTkToolTip(setdns, message="Set the selected DNS server as Private DNS provider")

# Column 2
label2 = ctk.CTkLabel(window, text="Utilities", font=("default",25))
label2.grid(row=0, column=1, padx=25, pady=15)

googleservices = ctk.CTkButton(window, text="Install Google Services", width=200, height=50, command=debloat)
googleservices.grid(row=1, column=1, padx=25, pady=15)

batchinstall = ctk.CTkButton(window, text="Batch Install", width=200, height=50, command=debloat)
batchinstall.grid(row=2, column=1, padx=25, pady=15)

disableota = ctk.CTkButton(window, text="Disable OTA", width=200, height=50, command=debloat)
disableota.grid(row=3, column=1, padx=25, pady=15)

label3 = ctk.CTkLabel(window, text="Custom Launcher", font=("default",25))
label3.grid(row=4, column=1, padx=25, pady=15)

customlauncher = ctk.CTkComboBox(window, values=["Lawnchair", "Nova Launcher", "Custom"], width=200, height=30)
customlauncher.grid(row=5, column=1, padx=25, pady=15)
customlauncher.set("Select Launcher")

setlauncher = ctk.CTkButton(window, text="Install Selected Launcher", width=200, height=50, command=set_launcher)
setlauncher.grid(row=6, column=1, padx=25, pady=15)

# Column 3
label4 = ctk.CTkLabel(window, text="Packages", font=("default",25))
label4.grid(row=0, column=2, padx=25, pady=15)

segemented_button = ctk.CTkSegmentedButton(window, values=["Enable", "Disable"], width=200, height=50, dynamic_resizing=False, command=selected)
segemented_button.set("Enable")
segemented_button.grid(row=1, column=2, padx=25, pady=15)

extract = ctk.CTkButton(window, text="Extract", width=200, height=50, command=debloat)
extract.grid(row=2, column=2, padx=25, pady=15)

textbox = ctk.CTkTextbox(window)
#textbox.configure(state="disabled")  # configure textbox to be read-only
#textbox.grid(row=3, column=2, padx=25, pady=0)

window.mainloop()
