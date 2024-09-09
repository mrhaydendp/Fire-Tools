# Download, Extract to AppData\Roaming, then Delete Fire-Tools.zip
Start-BitsTransfer -Source "https://github.com/mrhaydendp/fire-tools/releases/latest/download/Fire-Tools.zip"
Expand-Archive -Path .\Fire-Tools.zip -Destination "$env:APPDATA"
Remove-Item -Path .\Fire-Tools.zip

# Add Shortcut to Start Menu
$startmenu = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
$targetPath = "$env:APPDATA\Fire-Tools\main.py"
New-Item -ItemType SymbolicLink -Path "$startmenu" -TargetPath "$targetPath"

# Check / Install Python & Requirements
if (!(Select-String -Pattern "Python" -InputObject "$env:PATH" -Quiet)) {
    if (Get-Command winget) {
        winget install -s winget "Python.Python.3.12" --force
    } else {
        # Find Latest Python Version by Scraping Page & Install 
        $latest = (Invoke-WebRequest -Uri "https://www.python.org/downloads/").Links.href -like "*.exe"
        Start-BitsTransfer -Source "$latest"
        .\*python*.exe /passive PrependPath=1
        while (!(Get-Package -Name "*Python*" -ErrorAction SilentlyContinue)) {}
        Remove-Item .\*python*.exe
    }
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/mrhaydendp/Fire-Tools/main/Fire-Tools/requirements.txt" -Destination "$env:APPDATA\Fire-Tools"
    pip install -r "$env:APPDATA\Fire-Tools\requirements.txt"
}
