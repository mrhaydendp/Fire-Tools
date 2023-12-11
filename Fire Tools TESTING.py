import customtkinter as ctk
from CTkToolTip import *
import platform, webbrowser

version = "BETA"

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - (" + platform.system() + ")")
window.geometry("1000x550")
window.columnconfigure(0, weight=1)
window.columnconfigure(1, weight=50)

# Functions
def debloat():
    print("Selected:", debloat.cget("text"))

def undo():
    print("Selected:", undo.cget("text"))

def edit_list():
    webbrowser.open('Instructions.txt', 'r')

def set_dns():
    print("Selected Server: " + customdns.get())

# Column 1
label = ctk.CTkLabel(window, text="Debloat", font=("default",30))
label.grid(row=0, column=0, padx=20, pady=15)

debloat = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=debloat)
debloat.grid(row=1, column=0, padx=20, pady=15)
CTkToolTip(debloat, message="Disable Amazon bloatware, then set privacy and performance settings")

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=undo)
undo.grid(row=2, column=0, padx=20, pady=15)
CTkToolTip(undo, message="Enable Amazon bloatware, then revert privacy and performance settings")

edit = ctk.CTkButton(window, text="Edit", width=200, height=50, command=edit_list)
edit.grid(row=3, column=0, padx=20, pady=15)
CTkToolTip(edit, message="Open 'Debloat.txt' in preferred text editor")

label1 = ctk.CTkLabel(window, text="Custom DNS", font=("default",30))
label1.grid(row=4, column=0, padx=20, pady=15)

customdns = ctk.CTkComboBox(window, values=["dns.adguard.com", "security.cloudflare-dns.com", "None"], width=200, height=30)
customdns.grid(row=5, column=0, padx=20, pady=15)
customdns.set("Select DNS Server")
CTkToolTip(customdns, message="Select DNS provider from the dropdown or type one in the selection bar")

setdns = ctk.CTkButton(window, text="Set Selected DNS", width=200, height=50, command=set_dns)
setdns.grid(row=6, column=0, padx=20, pady=15)
CTkToolTip(setdns, message="Set the selected DNS server as Private DNS provider")

window.mainloop()
