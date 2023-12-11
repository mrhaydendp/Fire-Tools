import customtkinter as ctk
from CTkToolTip import *
import platform, webbrowser

version = "BETA"
operating_system = platform.system()

# Window Config
window = ctk.CTk()
window.title("Fire Tools v" + version + " - (" + operating_system + ")")
window.geometry("1000x600")

# Functions
def debloat():
    print("Selected:", debloat.cget("text"))

def undo():
    print("Selected:", undo.cget("text"))

def edit_list():
    webbrowser.open('Instructions.txt', 'r')

def set_dns():
    print("Selected Server: " + customdns.get())

# Buttons
debloat = ctk.CTkButton(window, text="Debloat", width=200, height=50, command=debloat)
debloat.pack(padx=20, pady=15)
CTkToolTip(debloat, message="Disable Amazon Bloat")

undo = ctk.CTkButton(window, text="Undo", width=200, height=50, command=undo)
undo.pack(padx=20, pady=15)
CTkToolTip(undo, message="Enable Amazon Bloat")

editlist = ctk.CTkButton(window, text="Edit", width=200, height=50, command=edit_list)
editlist.pack(padx=20, pady=15)
CTkToolTip(editlist, message="Open Debloat.txt in Preferred Text Editor")

customdns = ctk.CTkComboBox(window, values=["dns.adguard.com", "security.cloudflare-dns.com", "None"], width=200, height=30)
customdns.set("Select DNS Server")
customdns.pack(padx=20, pady=20)

setdns = ctk.CTkButton(window, text="Set Custom DNS", width=200, height=50, command=set_dns)
setdns.pack(padx=20, pady=15)
CTkToolTip(setdns, message="Set the Selected DNS Server as Private DNS Provider")

window.mainloop()